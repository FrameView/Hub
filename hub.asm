; my first assembly app
; compile: nasm -f elf64 hub.asm -o hub.o
; link:    gcc -no-pie hub.o -o hub -lX11

section .data

window_width      equ 1600
window_height     equ 800
button_width      equ 120
button_height     equ 30

ExposeMask        equ 0x00008000
ButtonPressMask   equ 0x00000004
Expose            equ 12
ButtonPress       equ 4

display_name      dq 0
font_name         db "fixed",0

sky               dq 0x87CEEB
blue              dq 0x0000FF  
white             dq 0xFFFFFF
black             dq 0x000000
purple            dq 0x7777FF
green             dq 0x2d5016
red               dq 0xFF0000

updates_title     db "[UPDATES]",0

update_x          equ 100
update_y          equ 100
update_txt        db "Check for updates",0
update_cmd        db "konsole -e sudo apt update &",0

upgrade_x         equ 300
upgrade_y         equ 100
upgrade_txt       db "Upgrade packages",0
upgrade_cmd       db "konsole -e sudo apt upgrade -y &",0

driver_x          equ 500
driver_y          equ 100
driver_txt        db "Update RTX driver",0
driver_cmd        db "konsole -e sudo apt install --reinstall linux-headers-$(uname -r) dkms nvidia-driver nvidia-kernel-dkms nvidia-persistenced -y &",0

coding_title      db "[CODING]",0

vsc_x             equ 100
vsc_y             equ 300
vsc_txt           db "Visual Studio Code",0
vsc_cmd           db "code &",0

idea_x            equ 300
idea_y            equ 300
idea_txt          db "IntelliJ IDEA",0
idea_cmd          db "idea &",0

terminal_x        equ 500
terminal_y        equ 300
terminal_txt      db "Terminal",0
terminal_cmd      db "konsole &",0

gaming_title      db "[GAMING]",0

steam_x           equ 100
steam_y           equ 500
steam_txt         db "Steam",0
steam_cmd         db "steam &",0

hytale_x          equ 300
hytale_y          equ 500
hytale_txt        db "Hytale",0
hytale_cmd        db "hytale &",0

mc_x              equ 500
mc_y              equ 500
mc_txt            db "Minecraft",0
mc_cmd            db "mc &",0

discord_x         equ 700
discord_y         equ 500
discord_txt       db "Discord",0
discord_cmd       db "discord &",0

pxlart_x          equ 900
pxlart_y          equ 500
pxlart_txt        db "Pixel Art",0
pxlart_cmd        db "pxlart &",0

general_title     db "[GENERAL]",0

files_x           equ 100
files_y           equ 700
files_txt         db "File Manager",0
files_cmd         db "dolphin &",0

browser_x         equ 300
browser_y         equ 700
browser_txt       db "Web Browser",0
browser_cmd       db "brave-browser &",0

reboot_x          equ 500
reboot_y          equ 700
reboot_txt        db "Reboot",0
reboot_cmd        db "konsole -e sudo reboot &",0

shutdown_x        equ 700
shutdown_y        equ 700
shutdown_txt      db "Shutdown",0
shutdown_cmd      db "konsole -e sudo shutdown -h now &",0

section .bss
display           resq 1
window            resq 1
gc                resq 1
event             resb 192

section .text

; macros
%macro draw_button 5
    mov rdi, [display]
    mov rsi, [gc]
    mov rdx, [%1]                   ; rect_color
    call XSetForeground
    mov rdi, [display]
    mov rsi, [window]
    mov rdx, [gc]
    mov rcx, %2                     ; rect_x
    mov r8, %3                      ; rect_y
    mov r9, button_width
    sub rsp, 8
    mov qword [rsp], button_height
    call XFillRectangle
    add rsp, 8
    
    mov rdi, [display]
    mov rsi, [gc]
    mov rdx, [white]
    call XSetForeground
    mov rdi, [display]
    mov rsi, [window]
    mov rdx, [gc]
    mov rcx, %2 + 10                ; text_x
    mov r8, %3 + 20                 ; text_y
    mov r9, %4                      ; text_string
    sub rsp, 8
    mov qword [rsp], %5             ; text_length
    call XDrawString
    add rsp, 8
%endmacro

%macro draw_title 4
    mov rdi, [display]
    mov rsi, [gc]
    mov rdx, [black]
    call XSetForeground
    mov rdi, [display]
    mov rsi, [window]
    mov rdx, [gc]
    mov rcx, %1                     ; x
    mov r8, %2                      ; y
    mov r9, %3                      ; text_string
    sub rsp, 8
    mov qword [rsp], %4             ; text_length
    call XDrawString
    add rsp, 8
%endmacro

%macro check_button 4
    cmp eax, %1                     ; x
    jl %4                           ; next_check
    cmp eax, %1 + button_width
    jg %4
    cmp ebx, %2                     ; y
    jl %4
    cmp ebx, %2 + button_height
    jg %4
    lea rdi, [%3]                   ; cmd
    call system
    jmp event_loop
%endmacro

global main

; libs
extern XOpenDisplay
extern XDefaultRootWindow
extern XCreateSimpleWindow
extern XSelectInput
extern XMapWindow
extern XCreateGC
extern XSetForeground
extern XFillRectangle
extern XDrawString
extern XLoadFont
extern XSetFont
extern XNextEvent
extern XFlush
extern XCloseDisplay
extern system
extern exit

; starting point
main:
    push rbp
    mov rbp, rsp

; open display
    mov rdi, 0
    call XOpenDisplay
    test rax, rax
    jz quit
    mov [display], rax

; create window
    mov rdi, [display]            ; arg1: display*
    mov rsi, [display]
    call XDefaultRootWindow       ; get root window
    mov rsi, rax                  ; arg2: parent
    mov rdx, 100                  ; arg3: x
    mov rcx, 100                  ; arg4: y
    mov r8, window_width          ; arg5: width
    mov r9, window_height         ; arg6: height
    sub rsp, 24                   ; space for args 7,8,9
    mov qword [rsp], 1            ; arg7: border_width
    mov qword [rsp+8], 0x000000   ; arg8: border color
    mov qword [rsp+16], 0xFFFFFF  ; arg9: background color
    call XCreateSimpleWindow
    add rsp, 24
    mov [window], rax

; select events
    mov rdi, [display]
    mov rsi, [window]
    mov rdx, ExposeMask | ButtonPressMask
    call XSelectInput

; create GC
    mov rdi, [display]
    mov rsi, [window]
    xor rdx, rdx
    xor rcx, rcx
    call XCreateGC
    mov [gc], rax

; load font
    mov rdi, [display]
    mov rsi, font_name
    call XLoadFont
    mov rdi, [display]
    mov rsi, [gc]
    mov rdx, rax
    call XSetFont

; map window
    mov rdi, [display]
    mov rsi, [window]
    call XMapWindow

; main loop
event_loop:
    mov rdi, [display]

    mov rsi, event
    call XNextEvent
    mov eax, dword [event]

    cmp eax, Expose
    je draw

    cmp eax, ButtonPress
    je handle_click

    jmp event_loop

draw:
    mov rdi, [display]
    mov rsi, [gc]
    mov rdx, [white]
    call XSetForeground
    mov rdi, [display]
    mov rsi, [window]
    mov rdx, [gc]
    xor rcx, rcx
    xor r8, r8
    mov r9, window_width
    sub rsp, 8
    mov qword [rsp], window_height
    call XFillRectangle
    add rsp, 8

    draw_title 100, 80, updates_title, 9
    draw_button green, update_x, update_y, update_txt, 17
    draw_button green, upgrade_x, upgrade_y, upgrade_txt, 16
    draw_button green, driver_x, driver_y, driver_txt, 17

    draw_title 100, 280, coding_title, 8
    draw_button sky, vsc_x, vsc_y, vsc_txt, 18
    draw_button sky, idea_x, idea_y, idea_txt, 13
    draw_button black, terminal_x, terminal_y, terminal_txt, 8

    draw_title 100, 480, gaming_title, 8
    draw_button blue, steam_x, steam_y, steam_txt, 5
    draw_button blue, hytale_x, hytale_y, hytale_txt, 6
    draw_button blue, mc_x, mc_y, mc_txt, 9
    draw_button blue, discord_x, discord_y, discord_txt, 7
    draw_button blue, pxlart_x, pxlart_y, pxlart_txt, 9

    draw_title 100, 680, general_title, 9
    draw_button purple, files_x, files_y, files_txt, 12
    draw_button purple, browser_x, browser_y, browser_txt, 11
    draw_button red, reboot_x, reboot_y, reboot_txt, 6
    draw_button red, shutdown_x, shutdown_y, shutdown_txt, 8

    mov rdi, [display]
    call XFlush
    jmp event_loop

; click event handler
handle_click:
    mov eax, dword [event+64] ; x
    mov ebx, dword [event+68] ; y 
    jmp check_update
 
; waypoints
check_update:
    check_button update_x, update_y, update_cmd, check_upgrade

check_upgrade:
    check_button upgrade_x, upgrade_y, upgrade_cmd, check_driver

check_driver:
    check_button driver_x, driver_y, driver_cmd, check_vsc

check_vsc:
    check_button vsc_x, vsc_y, vsc_cmd, check_idea

check_idea:
    check_button idea_x, idea_y, idea_cmd, check_terminal

check_terminal:
    check_button terminal_x, terminal_y, terminal_cmd, check_steam

check_steam:
    check_button steam_x, steam_y, steam_cmd, check_hytale

check_hytale:
    check_button hytale_x, hytale_y, hytale_cmd, check_mc

check_mc:
    check_button mc_x, mc_y, mc_cmd, check_discord

check_discord:
    check_button discord_x, discord_y, discord_cmd, check_pxlart

check_pxlart:
    check_button pxlart_x, pxlart_y, pxlart_cmd, check_files

check_files:
    check_button files_x, files_y, files_cmd, check_browser

check_browser:
    check_button browser_x, browser_y, browser_cmd, check_reboot

check_reboot:
    check_button reboot_x, reboot_y, reboot_cmd, check_shutdown

check_shutdown:
    check_button shutdown_x, shutdown_y, shutdown_cmd, event_loop

; close window
quit:
    mov rdi, [display]
    test rdi, rdi
    jz exit_program
    call XCloseDisplay
exit_program:
    xor rdi, rdi
    call exit