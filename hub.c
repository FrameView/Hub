// Update: You can now add custom colors, groups and apps, simply modify the userconfig.json!
// Feel free to delete the apps you don't need!
// You can build the hub either using the C or Assembly program:
// With hub.c            : gcc hub.c -o hub -lX11 
// With hub.s            : gcc hub.s -o hub -lX11
// Convert C to Assembly : gcc -S hub.c -o hub.s

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <sys/stat.h>
#include <time.h>
#include <ctype.h>
#include <stdbool.h>

#define WINDOW_WIDTH 1600
#define WINDOW_HEIGHT 800
#define BUTTON_WIDTH 120
#define BUTTON_HEIGHT 30
#define GROUP_SPACING 100
#define GROUP_TITLE_Y 80
#define APP_START_Y 100
#define MAX_GROUPS 16
#define MAX_APPS 64
#define MAX_COLORS 32

typedef struct {
    unsigned long rgb;
    char name[24];
} Color;

typedef struct {
    char group[32];
    char text[48];
    char cmd[256];
    unsigned short rect_color_idx;
    unsigned short text_color_idx;
} App;

typedef struct {
    int x;
    int y;
    unsigned short app_idx;
} Button;

Display *display = NULL;
Window window;
GC gc;
time_t last_config_time = 0;

Color colors[MAX_COLORS];
int color_count = 0;

char *groups[MAX_GROUPS];
int group_count = 0;

App apps[MAX_APPS];
int app_count = 0;

Button buttons[MAX_APPS];
int button_count = 0;

Bool dark_mode = false;
const char *mode = "Switch mode";

char config_file[128] = "userconfig.json";
char config_buffer[32768];

// ============================================================================
// JSON PARSING
// ============================================================================

// Find next occurrence of pattern in string
const char* find_next(const char *str, const char *pattern) {
    return strstr(str, pattern);
}

// Extract quoted string, return pointer to after closing quote
const char* extract_until_quote(const char *start, char *dest, int max_len) {
    if (*start != '"') return start;
    start++;  // Skip opening quote
    
    int len = 0;
    while (*start && *start != '"' && len < max_len - 1) {
        dest[len++] = *start++;
    }
    dest[len] = '\0';
    
    if (*start == '"') start++;  // Skip closing quote
    return start;
}

// Parse hex color from string like "0x87CEEB"
unsigned long parse_color_hex(const char *str) {
    unsigned long val = 0;
    
    // Skip opening quote
    if (*str == '"') str++;
    
    // Skip 0x or #
    if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X')) str += 2;
    else if (str[0] == '#') str++;
    
    // Parse hex digits until we hit closing quote
    while (*str && *str != '"') {
        char c = *str++;
        val = (val << 4);
        if (c >= '0' && c <= '9') val |= (c - '0');
        else if (c >= 'a' && c <= 'f') val |= (c - 'a' + 10);
        else if (c >= 'A' && c <= 'F') val |= (c - 'A' + 10);
        else break;
    }
    return val;
}

// Find color index by name
int find_color_idx(const char *name) {
    for (int i = 0; i < color_count; i++) {
        if (strcmp(colors[i].name, name) == 0) {
            return i;
        }
    }
    return 0;
}

// Parse colors: { "name": "0xHEX", "name": "0xHEX", ... }
void parse_colors(const char *buf) {
    printf("Scanning for colors section...\n");
    
    const char *colors_pos = find_next(buf, "\"colors\"");
    if (!colors_pos) {
        printf("No colors section found\n");
        return;
    }
    
    // Find the opening brace
    colors_pos = find_next(colors_pos, "{");
    if (!colors_pos) return;
    colors_pos++;
    
    // Find closing brace
    const char *colors_end = find_next(colors_pos, "}");
    if (!colors_end) return;
    
    color_count = 0;
    const char *p = colors_pos;
    
    while (p < colors_end && color_count < MAX_COLORS) {
        // Look for opening quote (start of color name)
        p = find_next(p, "\"");
        if (!p || p >= colors_end) break;
        p++;
        
        // Extract color name until closing quote
        char color_name[24];
        int i = 0;
        while (*p && *p != '"' && i < 23) {
            color_name[i++] = *p++;
        }
        color_name[i] = '\0';
        if (*p != '"') break;
        p++;  // Skip closing quote
        
        // Find the colon
        p = find_next(p, ":");
        if (!p || p >= colors_end) break;
        p++;
        
        // Find the opening quote of the hex value
        p = find_next(p, "\"");
        if (!p || p >= colors_end) break;
        
        // Parse hex value
        unsigned long hex_val = parse_color_hex(p);
        
        // Store color
        strcpy(colors[color_count].name, color_name);
        colors[color_count].rgb = hex_val;
        printf("Color: %s = 0x%06lx\n", color_name, hex_val);
        color_count++;
        
        // Move to next value (skip past this hex value)
        p = find_next(p, "\"");  // Find closing quote of hex
        if (p) p++;
        
        // Skip comma if present
        p = find_next(p, ",");
        if (p && p < colors_end) p++;
    }
}

// Parse groups: [ "name", "name", ... ]
void parse_groups(const char *buf) {
    printf("Scanning for groups section...\n");
    
    const char *groups_pos = find_next(buf, "\"groups\"");
    if (!groups_pos) {
        printf("No groups section found\n");
        return;
    }
    
    // Find opening bracket
    groups_pos = find_next(groups_pos, "[");
    if (!groups_pos) return;
    groups_pos++;
    
    // Find closing bracket
    const char *groups_end = find_next(groups_pos, "]");
    if (!groups_end) return;
    
    group_count = 0;
    const char *p = groups_pos;
    
    while (p < groups_end && group_count < MAX_GROUPS) {
        // Look for opening quote
        p = find_next(p, "\"");
        if (!p || p >= groups_end) break;
        p++;
        
        // Extract group name until closing quote
        char group_name[32];
        int i = 0;
        while (*p && *p != '"' && i < 31) {
            group_name[i++] = *p++;
        }
        group_name[i] = '\0';
        if (*p != '"') break;
        p++;  // Skip closing quote
        
        // Store group
        groups[group_count] = malloc(strlen(group_name) + 1);
        strcpy(groups[group_count], group_name);
        printf("Group: %s\n", group_name);
        group_count++;
        
        // Skip comma if present
        p = find_next(p, ",");
        if (p && p < groups_end) p++;
    }
}

// Parse apps: [ { "field": "value", ... }, ... ]
void parse_apps(const char *buf) {
    printf("Scanning for apps section...\n");
    
    const char *apps_pos = find_next(buf, "\"apps\"");
    if (!apps_pos) {
        printf("No apps section found\n");
        return;
    }
    
    // Find opening bracket
    apps_pos = find_next(apps_pos, "[");
    if (!apps_pos) return;
    apps_pos++;
    
    // Find closing bracket (last ] in file)
    const char *buf_end = buf + strlen(buf);
    const char *apps_end = buf_end;
    for (const char *p = buf_end - 1; p >= apps_pos; p--) {
        if (*p == ']') {
            apps_end = p;
            break;
        }
    }
    
    app_count = 0;
    const char *p = apps_pos;
    
    while (p < apps_end && app_count < MAX_APPS) {
        // Look for opening brace (start of app object)
        p = find_next(p, "{");
        if (!p || p >= apps_end) break;
        p++;
        
        // Find closing brace for this app
        const char *app_end = find_next(p, "}");
        if (!app_end || app_end > apps_end) break;
        
        App *app = &apps[app_count];
        memset(app, 0, sizeof(App));
        
        // Parse all fields within this app object
        const char *ap = p;
        while (ap < app_end) {
            // Look for field name
            ap = find_next(ap, "\"");
            if (!ap || ap >= app_end) break;
            ap++;
            
            // Extract field name
            char field_name[32];
            int i = 0;
            while (*ap && *ap != '"' && i < 31) {
                field_name[i++] = *ap++;
            }
            field_name[i] = '\0';
            if (*ap != '"') break;
            ap++;
            
            // Find colon
            ap = find_next(ap, ":");
            if (!ap || ap >= app_end) break;
            ap++;
            
            // Find opening quote of value
            ap = find_next(ap, "\"");
            if (!ap || ap >= app_end) break;
            ap++;
            
            // Extract value
            char value[512];
            i = 0;
            while (*ap && *ap != '"' && i < 511) {
                value[i++] = *ap++;
            }
            value[i] = '\0';
            
            // Store in appropriate field
            if (strcmp(field_name, "group") == 0) {
                strcpy(app->group, value);
            } else if (strcmp(field_name, "text") == 0) {
                strcpy(app->text, value);
            } else if (strcmp(field_name, "cmd") == 0) {
                strcpy(app->cmd, value);
            } else if (strcmp(field_name, "rect_color") == 0) {
                app->rect_color_idx = (unsigned short)find_color_idx(value);
            } else if (strcmp(field_name, "text_color") == 0) {
                app->text_color_idx = (unsigned short)find_color_idx(value);
            }
            
            if (*ap == '"') ap++;  // Skip closing quote
        }
        
        // Validate app has required fields
        if (app->group[0] && app->text[0] && app->cmd[0]) {
            printf("App: %s (%s)\n", app->text, app->group);
            app_count++;
        }
        
        p = app_end + 1;
    }
}

void load_config(void) {
    FILE *fp = fopen(config_file, "r");
    if (!fp) {
        fprintf(stderr, "Cannot open: %s\n", config_file);
        exit(1);
    }

    size_t sz = fread(config_buffer, 1, sizeof(config_buffer) - 1, fp);
    fclose(fp);
    config_buffer[sz] = '\0';
    
    printf("\nLoaded config: %zu bytes\n", sz);
    
    struct stat st;
    stat(config_file, &st);
    last_config_time = st.st_mtime;

    printf("Parsing colors...\n");
    parse_colors(config_buffer);
    
    printf("Parsing groups...\n");
    parse_groups(config_buffer);
    
    printf("Parsing apps...\n");
    parse_apps(config_buffer);
    
    printf("\nLoaded: %d colors, %d groups, %d apps\n\n", 
           color_count, group_count, app_count);
}

void build_ui(void) {
    button_count = 0;
    
    for (int g = 0; g < group_count; g++) {
        const char *group_name = groups[g];
        int x = 100;
        int y = APP_START_Y + (g * GROUP_SPACING);
        
        for (int a = 0; a < app_count; a++) {
            if (strcmp(apps[a].group, group_name) == 0) {
                buttons[button_count].x = x;
                buttons[button_count].y = y;
                buttons[button_count].app_idx = a;
                button_count++;
                x += 150;
            }
        }
    }

    //light/dark mode button
    buttons[app_count].x = 1500;
    buttons[app_count].y = 25;
    button_count++;
}

void draw_ui(void) {
    if(dark_mode) {
        XSetForeground(display, gc, 0x0D1117);
    } else {
        XSetForeground(display, gc, 0xF5F5F5);
    }
    XFillRectangle(display, window, gc, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);

    for (int g = 0; g < group_count; g++) {
        if(dark_mode) {
            XSetForeground(display, gc, 0xFFFFFF);
        } else {
            XSetForeground(display, gc, 0x000000);
        }
        int title_y = GROUP_TITLE_Y + (g * GROUP_SPACING);
        XDrawString(display, window, gc, 50, title_y, groups[g], strlen(groups[g]));

        for (int i = 0; i < button_count; i++) {
            Button *btn = &buttons[i];

            if(i==button_count-1) { // draw light/dark mode button
                
                XSetForeground(display, gc, 0xFFFFFF);
                XFillRectangle(display, window, gc, btn->x, btn->y, 80, BUTTON_HEIGHT);
                XSetForeground(display, gc, 0x000000);
                XDrawString(display, window, gc, btn->x + 5, btn->y + 20, (char*)mode, strlen(mode));

            } else {
                App *app = &apps[btn->app_idx];
                
                if (strcmp(app->group, groups[g]) != 0) {
                    continue;
                }
                
                XSetForeground(display, gc, colors[app->rect_color_idx].rgb);
                XFillRectangle(display, window, gc, btn->x, btn->y, BUTTON_WIDTH, BUTTON_HEIGHT);
                XSetForeground(display, gc, colors[app->text_color_idx].rgb);
                XDrawString(display, window, gc, btn->x + 5, btn->y + 20, app->text, strlen(app->text));
            }
        }
    }
    XFlush(display);
}

void handle_click(int x, int y) {
    for (int i = 0; i < button_count; i++) {
        Button *btn = &buttons[i];
        int width = (i == button_count - 1) ? 90 : BUTTON_WIDTH;

        if (x >= btn->x && x < btn->x + width &&
            y >= btn->y && y < btn->y + BUTTON_HEIGHT) {
            
            if(i==button_count-1){
                dark_mode = !dark_mode;
                draw_ui();
            } else {
                App *app = &apps[btn->app_idx];
                printf("Executing: %s\n", app->cmd);
                (void)system(app->cmd);
            }    
            return;
        }
    }
}

void reload_config(void) {
    for (int i = 0; i < group_count; i++) {
        free(groups[i]);
    }
    group_count = 0;
    color_count = 0;
    app_count = 0;
    
    load_config();
    build_ui();
    draw_ui();
}

void check_file_changes(void) {
    struct stat st;
    if (stat(config_file, &st) == 0) {
        if (st.st_mtime > last_config_time) {
            printf("Config changed, reloading...\n");
            reload_config();
        }
    }
}

int main(int argc, char *argv[]) {
    printf("\nHub Starting...\n");
    
    if (argc > 1) {
        strncpy(config_file, argv[1], sizeof(config_file) - 1);
    }

    display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Cannot open X11 display\n");
        return 1;
    }

    int screen = DefaultScreen(display);
    Window root = RootWindow(display, screen);

    window = XCreateSimpleWindow(
        display, root,
        100, 100,
        WINDOW_WIDTH, WINDOW_HEIGHT,
        1,
        BlackPixel(display, screen),
        WhitePixel(display, screen)
    );

    XSelectInput(display, window, ExposureMask | ButtonPressMask);
    gc = XCreateGC(display, window, 0, NULL);

    XFontStruct *font = XLoadQueryFont(display, "fixed");
    if (font) {
        XSetFont(display, gc, font->fid);
    }

    XMapWindow(display, window);
    XFlush(display);

    load_config();
    build_ui();
    draw_ui();

    printf("Listening for events...\n\n");

    XEvent event;
    while (1) {
        check_file_changes();

        if (XPending(display) > 0) {
            XNextEvent(display, &event);

            if (event.type == Expose) {
                draw_ui();
            } else if (event.type == ButtonPress) {
                XButtonEvent *be = (XButtonEvent *)&event;
                handle_click(be->x, be->y);
            }
        } else {
            usleep(50000);
        }
    }

    return 0;
}
