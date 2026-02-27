	.file	"hub.c"
	.text
	.globl	display
	.bss
	.align 8
	.type	display, @object
	.size	display, 8
display:
	.zero	8
	.globl	window
	.align 8
	.type	window, @object
	.size	window, 8
window:
	.zero	8
	.globl	gc
	.align 8
	.type	gc, @object
	.size	gc, 8
gc:
	.zero	8
	.globl	last_config_time
	.align 8
	.type	last_config_time, @object
	.size	last_config_time, 8
last_config_time:
	.zero	8
	.globl	colors
	.align 32
	.type	colors, @object
	.size	colors, 1024
colors:
	.zero	1024
	.globl	color_count
	.align 4
	.type	color_count, @object
	.size	color_count, 4
color_count:
	.zero	4
	.globl	groups
	.align 32
	.type	groups, @object
	.size	groups, 128
groups:
	.zero	128
	.globl	group_count
	.align 4
	.type	group_count, @object
	.size	group_count, 4
group_count:
	.zero	4
	.globl	apps
	.align 32
	.type	apps, @object
	.size	apps, 21760
apps:
	.zero	21760
	.globl	app_count
	.align 4
	.type	app_count, @object
	.size	app_count, 4
app_count:
	.zero	4
	.globl	buttons
	.align 32
	.type	buttons, @object
	.size	buttons, 768
buttons:
	.zero	768
	.globl	button_count
	.align 4
	.type	button_count, @object
	.size	button_count, 4
button_count:
	.zero	4
	.globl	dark_mode
	.align 4
	.type	dark_mode, @object
	.size	dark_mode, 4
dark_mode:
	.zero	4
	.globl	mode
	.section	.rodata
.LC0:
	.string	"Switch mode"
	.section	.data.rel.local,"aw"
	.align 8
	.type	mode, @object
	.size	mode, 8
mode:
	.quad	.LC0
	.globl	config_file
	.data
	.align 32
	.type	config_file, @object
	.size	config_file, 128
config_file:
	.string	"userconfig.json"
	.zero	112
	.globl	config_buffer
	.bss
	.align 32
	.type	config_buffer, @object
	.size	config_buffer, 32768
config_buffer:
	.zero	32768
	.text
	.globl	find_next
	.type	find_next, @function
find_next:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	find_next, .-find_next
	.globl	extract_until_quote
	.type	extract_until_quote, @function
extract_until_quote:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	je	.L4
	movq	-24(%rbp), %rax
	jmp	.L5
.L4:
	addq	$1, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L6
.L8:
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movl	-4(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%ecx, -4(%rbp)
	movslq	%edx, %rcx
	movq	-32(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
.L6:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L7
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	je	.L7
	movl	-36(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L8
.L7:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L9
	addq	$1, -24(%rbp)
.L9:
	movq	-24(%rbp), %rax
.L5:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	extract_until_quote, .-extract_until_quote
	.globl	parse_color_hex
	.type	parse_color_hex, @function
parse_color_hex:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	$0, -8(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L11
	addq	$1, -24(%rbp)
.L11:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$48, %al
	jne	.L12
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$120, %al
	je	.L13
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	cmpb	$88, %al
	jne	.L12
.L13:
	addq	$2, -24(%rbp)
	jmp	.L14
.L12:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$35, %al
	jne	.L15
	addq	$1, -24(%rbp)
.L14:
	jmp	.L15
.L19:
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movzbl	(%rax), %eax
	movb	%al, -9(%rbp)
	salq	$4, -8(%rbp)
	cmpb	$47, -9(%rbp)
	jle	.L16
	cmpb	$57, -9(%rbp)
	jg	.L16
	movsbl	-9(%rbp), %eax
	subl	$48, %eax
	cltq
	orq	%rax, -8(%rbp)
	jmp	.L15
.L16:
	cmpb	$96, -9(%rbp)
	jle	.L17
	cmpb	$102, -9(%rbp)
	jg	.L17
	movsbl	-9(%rbp), %eax
	subl	$87, %eax
	cltq
	orq	%rax, -8(%rbp)
	jmp	.L15
.L17:
	cmpb	$64, -9(%rbp)
	jle	.L18
	cmpb	$70, -9(%rbp)
	jg	.L18
	movsbl	-9(%rbp), %eax
	subl	$55, %eax
	cltq
	orq	%rax, -8(%rbp)
.L15:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L18
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L19
.L18:
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	parse_color_hex, .-parse_color_hex
	.globl	find_color_idx
	.type	find_color_idx, @function
find_color_idx:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L22
.L25:
	movl	-4(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	colors(%rip), %rax
	addq	%rdx, %rax
	leaq	8(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L23
	movl	-4(%rbp), %eax
	jmp	.L24
.L23:
	addl	$1, -4(%rbp)
.L22:
	movl	color_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L25
	movl	$0, %eax
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	find_color_idx, .-find_color_idx
	.section	.rodata
	.align 8
.LC1:
	.string	"Scanning for colors section..."
.LC2:
	.string	"\"colors\""
.LC3:
	.string	"No colors section found"
.LC4:
	.string	"{"
.LC5:
	.string	"}"
.LC6:
	.string	"\""
.LC7:
	.string	":"
.LC8:
	.string	"Color: %s = 0x%06lx\n"
.LC9:
	.string	","
	.text
	.globl	parse_colors
	.type	parse_colors, @function
parse_colors:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-72(%rbp), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L27
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L26
.L27:
	movq	-24(%rbp), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L40
	addq	$1, -24(%rbp)
	movq	-24(%rbp), %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L41
	movl	$0, color_count(%rip)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L31
.L39:
	movq	-8(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L26
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jnb	.L26
	addq	$1, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L33
.L35:
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -8(%rbp)
	movl	-12(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%ecx, -12(%rbp)
	movzbl	(%rax), %ecx
	movslq	%edx, %rax
	movb	%cl, -64(%rbp,%rax)
.L33:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L34
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	je	.L34
	cmpl	$22, -12(%rbp)
	jle	.L35
.L34:
	movl	-12(%rbp), %eax
	cltq
	movb	$0, -64(%rbp,%rax)
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L42
	addq	$1, -8(%rbp)
	movq	-8(%rbp), %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L26
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jnb	.L26
	addq	$1, -8(%rbp)
	movq	-8(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L26
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jnb	.L26
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	parse_color_hex
	movq	%rax, -40(%rbp)
	movl	color_count(%rip), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	colors(%rip), %rax
	addq	%rdx, %rax
	leaq	8(%rax), %rdx
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movl	color_count(%rip), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rcx
	leaq	colors(%rip), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, (%rcx,%rdx)
	movq	-40(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	color_count(%rip), %eax
	addl	$1, %eax
	movl	%eax, color_count(%rip)
	movq	-8(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L37
	addq	$1, -8(%rbp)
.L37:
	movq	-8(%rbp), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L31
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jnb	.L31
	addq	$1, -8(%rbp)
.L31:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jnb	.L26
	movl	color_count(%rip), %eax
	cmpl	$31, %eax
	jle	.L39
	jmp	.L26
.L40:
	nop
	jmp	.L26
.L41:
	nop
	jmp	.L26
.L42:
	nop
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	parse_colors, .-parse_colors
	.section	.rodata
	.align 8
.LC10:
	.string	"Scanning for groups section..."
.LC11:
	.string	"\"groups\""
.LC12:
	.string	"No groups section found"
.LC13:
	.string	"["
.LC14:
	.string	"]"
.LC15:
	.string	"Group: %s\n"
	.text
	.globl	parse_groups
	.type	parse_groups, @function
parse_groups:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -88(%rbp)
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-88(%rbp), %rax
	leaq	.LC11(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L44
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L43
.L44:
	movq	-40(%rbp), %rax
	leaq	.LC13(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L56
	addq	$1, -40(%rbp)
	movq	-40(%rbp), %rax
	leaq	.LC14(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	je	.L57
	movl	$0, group_count(%rip)
	movq	-40(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.L48
.L55:
	movq	-24(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L43
	movq	-24(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jnb	.L43
	addq	$1, -24(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L50
.L52:
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movl	-28(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%ecx, -28(%rbp)
	movzbl	(%rax), %ecx
	movslq	%edx, %rax
	movb	%cl, -80(%rbp,%rax)
.L50:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L51
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	je	.L51
	cmpl	$30, -28(%rbp)
	jle	.L52
.L51:
	movl	-28(%rbp), %eax
	cltq
	movb	$0, -80(%rbp,%rax)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L58
	addq	$1, -24(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movl	group_count(%rip), %ebx
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %rcx
	movslq	%ebx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	%rcx, (%rdx,%rax)
	movl	group_count(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	(%rdx,%rax), %rax
	leaq	-80(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC15(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	group_count(%rip), %eax
	addl	$1, %eax
	movl	%eax, group_count(%rip)
	movq	-24(%rbp), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L48
	movq	-24(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jnb	.L48
	addq	$1, -24(%rbp)
.L48:
	movq	-24(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jnb	.L43
	movl	group_count(%rip), %eax
	cmpl	$15, %eax
	jle	.L55
	jmp	.L43
.L56:
	nop
	jmp	.L43
.L57:
	nop
	jmp	.L43
.L58:
	nop
.L43:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	parse_groups, .-parse_groups
	.section	.rodata
.LC16:
	.string	"Scanning for apps section..."
.LC17:
	.string	"\"apps\""
.LC18:
	.string	"No apps section found"
.LC19:
	.string	"group"
.LC20:
	.string	"text"
.LC21:
	.string	"cmd"
.LC22:
	.string	"rect_color"
.LC23:
	.string	"text_color"
.LC24:
	.string	"App: %s (%s)\n"
	.text
	.globl	parse_apps
	.type	parse_apps, @function
parse_apps:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$640, %rsp
	movq	%rdi, -632(%rbp)
	leaq	.LC16(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-632(%rbp), %rax
	leaq	.LC17(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	jne	.L60
	leaq	.LC18(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L59
.L60:
	movq	-48(%rbp), %rax
	leaq	.LC13(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	je	.L87
	addq	$1, -48(%rbp)
	movq	-632(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	-632(%rbp), %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-56(%rbp), %rax
	subq	$1, %rax
	movq	%rax, -16(%rbp)
	jmp	.L63
.L66:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$93, %al
	jne	.L64
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L65
.L64:
	subq	$1, -16(%rbp)
.L63:
	movq	-16(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jnb	.L66
.L65:
	movl	$0, app_count(%rip)
	movq	-48(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.L67
.L86:
	movq	-24(%rbp), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L59
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jnb	.L59
	addq	$1, -24(%rbp)
	movq	-24(%rbp), %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	je	.L59
	movq	-64(%rbp), %rax
	cmpq	%rax, -8(%rbp)
	jb	.L59
	movl	app_count(%rip), %eax
	cltq
	imulq	$340, %rax, %rax
	leaq	apps(%rip), %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movl	$340, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	jmp	.L68
.L84:
	movq	-32(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L83
	movq	-32(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jnb	.L83
	addq	$1, -32(%rbp)
	movl	$0, -36(%rbp)
	jmp	.L70
.L72:
	movq	-32(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -32(%rbp)
	movl	-36(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%ecx, -36(%rbp)
	movzbl	(%rax), %ecx
	movslq	%edx, %rax
	movb	%cl, -624(%rbp,%rax)
.L70:
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L71
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	je	.L71
	cmpl	$30, -36(%rbp)
	jle	.L72
.L71:
	movl	-36(%rbp), %eax
	cltq
	movb	$0, -624(%rbp,%rax)
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L88
	addq	$1, -32(%rbp)
	movq	-32(%rbp), %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L83
	movq	-32(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jnb	.L83
	addq	$1, -32(%rbp)
	movq	-32(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	find_next
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L83
	movq	-32(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jnb	.L83
	addq	$1, -32(%rbp)
	movl	$0, -36(%rbp)
	jmp	.L74
.L76:
	movq	-32(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -32(%rbp)
	movl	-36(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%ecx, -36(%rbp)
	movzbl	(%rax), %ecx
	movslq	%edx, %rax
	movb	%cl, -592(%rbp,%rax)
.L74:
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L75
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	je	.L75
	cmpl	$510, -36(%rbp)
	jle	.L76
.L75:
	movl	-36(%rbp), %eax
	cltq
	movb	$0, -592(%rbp,%rax)
	leaq	-624(%rbp), %rax
	leaq	.LC19(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L77
	movq	-72(%rbp), %rax
	leaq	-592(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	jmp	.L78
.L77:
	leaq	-624(%rbp), %rax
	leaq	.LC20(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L79
	movq	-72(%rbp), %rax
	leaq	32(%rax), %rdx
	leaq	-592(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	jmp	.L78
.L79:
	leaq	-624(%rbp), %rax
	leaq	.LC21(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L80
	movq	-72(%rbp), %rax
	leaq	80(%rax), %rdx
	leaq	-592(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	jmp	.L78
.L80:
	leaq	-624(%rbp), %rax
	leaq	.LC22(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L81
	leaq	-592(%rbp), %rax
	movq	%rax, %rdi
	call	find_color_idx
	movl	%eax, %edx
	movq	-72(%rbp), %rax
	movw	%dx, 336(%rax)
	jmp	.L78
.L81:
	leaq	-624(%rbp), %rax
	leaq	.LC23(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L78
	leaq	-592(%rbp), %rax
	movq	%rax, %rdi
	call	find_color_idx
	movl	%eax, %edx
	movq	-72(%rbp), %rax
	movw	%dx, 338(%rax)
.L78:
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L68
	addq	$1, -32(%rbp)
.L68:
	movq	-32(%rbp), %rax
	cmpq	-64(%rbp), %rax
	jb	.L84
	jmp	.L83
.L88:
	nop
.L83:
	movq	-72(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L85
	movq	-72(%rbp), %rax
	movzbl	32(%rax), %eax
	testb	%al, %al
	je	.L85
	movq	-72(%rbp), %rax
	movzbl	80(%rax), %eax
	testb	%al, %al
	je	.L85
	movq	-72(%rbp), %rax
	movq	-72(%rbp), %rdx
	leaq	32(%rdx), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	leaq	.LC24(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	app_count(%rip), %eax
	addl	$1, %eax
	movl	%eax, app_count(%rip)
.L85:
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
.L67:
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jnb	.L59
	movl	app_count(%rip), %eax
	cmpl	$63, %eax
	jle	.L86
	jmp	.L59
.L87:
	nop
.L59:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	parse_apps, .-parse_apps
	.section	.rodata
.LC25:
	.string	"r"
.LC26:
	.string	"Cannot open: %s\n"
.LC27:
	.string	"\nLoaded config: %zu bytes\n"
.LC28:
	.string	"Parsing colors..."
.LC29:
	.string	"Parsing groups..."
.LC30:
	.string	"Parsing apps..."
	.align 8
.LC31:
	.string	"\nLoaded: %d colors, %d groups, %d apps\n\n"
	.text
	.globl	load_config
	.type	load_config, @function
load_config:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	leaq	.LC25(%rip), %rax
	movq	%rax, %rsi
	leaq	config_file(%rip), %rax
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L90
	movq	stderr(%rip), %rax
	leaq	config_file(%rip), %rdx
	leaq	.LC26(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L90:
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	movl	$32767, %edx
	movl	$1, %esi
	leaq	config_buffer(%rip), %rax
	movq	%rax, %rdi
	call	fread@PLT
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	config_buffer(%rip), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC27(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-160(%rbp), %rax
	movq	%rax, %rsi
	leaq	config_file(%rip), %rax
	movq	%rax, %rdi
	call	stat@PLT
	movq	-72(%rbp), %rax
	movq	%rax, last_config_time(%rip)
	leaq	.LC28(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	config_buffer(%rip), %rax
	movq	%rax, %rdi
	call	parse_colors
	leaq	.LC29(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	config_buffer(%rip), %rax
	movq	%rax, %rdi
	call	parse_groups
	leaq	.LC30(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	config_buffer(%rip), %rax
	movq	%rax, %rdi
	call	parse_apps
	movl	app_count(%rip), %ecx
	movl	group_count(%rip), %edx
	movl	color_count(%rip), %eax
	movl	%eax, %esi
	leaq	.LC31(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	load_config, .-load_config
	.globl	build_ui
	.type	build_ui, @function
build_ui:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, button_count(%rip)
	movl	$0, -4(%rbp)
	jmp	.L92
.L96:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -24(%rbp)
	movl	$100, -8(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	imull	$100, %eax, %eax
	movl	%eax, -28(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L93
.L95:
	movl	-12(%rbp), %eax
	cltq
	imulq	$340, %rax, %rax
	leaq	apps(%rip), %rdx
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L94
	movl	button_count(%rip), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rcx
	leaq	buttons(%rip), %rdx
	movl	-8(%rbp), %eax
	movl	%eax, (%rcx,%rdx)
	movl	button_count(%rip), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rcx
	leaq	4+buttons(%rip), %rdx
	movl	-28(%rbp), %eax
	movl	%eax, (%rcx,%rdx)
	movl	button_count(%rip), %eax
	movl	-12(%rbp), %edx
	movl	%edx, %ecx
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdx
	leaq	8+buttons(%rip), %rax
	movw	%cx, (%rdx,%rax)
	movl	button_count(%rip), %eax
	addl	$1, %eax
	movl	%eax, button_count(%rip)
	addl	$150, -8(%rbp)
.L94:
	addl	$1, -12(%rbp)
.L93:
	movl	app_count(%rip), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L95
	addl	$1, -4(%rbp)
.L92:
	movl	group_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L96
	movl	app_count(%rip), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdx
	leaq	buttons(%rip), %rax
	movl	$1500, (%rdx,%rax)
	movl	app_count(%rip), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	movq	%rax, %rdx
	leaq	4+buttons(%rip), %rax
	movl	$25, (%rdx,%rax)
	movl	button_count(%rip), %eax
	addl	$1, %eax
	movl	%eax, button_count(%rip)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	build_ui, .-build_ui
	.globl	draw_ui
	.type	draw_ui, @function
draw_ui:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	dark_mode(%rip), %eax
	testl	%eax, %eax
	je	.L98
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movl	$856343, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	jmp	.L99
.L98:
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movl	$16119285, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
.L99:
	movq	gc(%rip), %rdx
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	subq	$8, %rsp
	pushq	$800
	movl	$1600, %r9d
	movl	$0, %r8d
	movl	$0, %ecx
	movq	%rax, %rdi
	call	XFillRectangle@PLT
	addq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L100
.L108:
	movl	dark_mode(%rip), %eax
	testl	%eax, %eax
	je	.L101
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movl	$16777215, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	jmp	.L102
.L101:
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
.L102:
	movl	-4(%rbp), %eax
	imull	$100, %eax, %eax
	addl	$80, %eax
	movl	%eax, -12(%rbp)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, %r8d
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	(%rdx,%rax), %rdi
	movq	gc(%rip), %rdx
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	movl	-12(%rbp), %ecx
	subq	$8, %rsp
	pushq	%r8
	movq	%rdi, %r9
	movl	%ecx, %r8d
	movl	$50, %ecx
	movq	%rax, %rdi
	call	XDrawString@PLT
	addq	$16, %rsp
	movl	$0, -8(%rbp)
	jmp	.L103
.L107:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	leaq	buttons(%rip), %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movl	button_count(%rip), %eax
	subl	$1, %eax
	cmpl	%eax, -8(%rbp)
	jne	.L104
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movl	$16777215, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	movq	-24(%rbp), %rax
	movl	4(%rax), %edi
	movq	-24(%rbp), %rax
	movl	(%rax), %ecx
	movq	gc(%rip), %rdx
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	subq	$8, %rsp
	pushq	$30
	movl	$80, %r9d
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	XFillRectangle@PLT
	addq	$16, %rsp
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	movq	mode(%rip), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, %r9d
	movq	mode(%rip), %rdi
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	leal	20(%rax), %r8d
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	5(%rax), %ecx
	movq	gc(%rip), %rdx
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	subq	$8, %rsp
	pushq	%r9
	movq	%rdi, %r9
	movq	%rax, %rdi
	call	XDrawString@PLT
	addq	$16, %rsp
	jmp	.L105
.L104:
	movq	-24(%rbp), %rax
	movzwl	8(%rax), %eax
	movzwl	%ax, %eax
	cltq
	imulq	$340, %rax, %rax
	leaq	apps(%rip), %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L109
	movq	-32(%rbp), %rax
	movzwl	336(%rax), %eax
	movzwl	%ax, %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	colors(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	movq	-24(%rbp), %rax
	movl	4(%rax), %edi
	movq	-24(%rbp), %rax
	movl	(%rax), %ecx
	movq	gc(%rip), %rdx
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	subq	$8, %rsp
	pushq	$30
	movl	$120, %r9d
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	XFillRectangle@PLT
	addq	$16, %rsp
	movq	-32(%rbp), %rax
	movzwl	338(%rax), %eax
	movzwl	%ax, %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	leaq	colors(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground@PLT
	movq	-32(%rbp), %rax
	addq	$32, %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%eax, %r9d
	movq	-32(%rbp), %rax
	leaq	32(%rax), %r8
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	leal	20(%rax), %edi
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leal	5(%rax), %ecx
	movq	gc(%rip), %rdx
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	subq	$8, %rsp
	pushq	%r9
	movq	%r8, %r9
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	XDrawString@PLT
	addq	$16, %rsp
	jmp	.L105
.L109:
	nop
.L105:
	addl	$1, -8(%rbp)
.L103:
	movl	button_count(%rip), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L107
	addl	$1, -4(%rbp)
.L100:
	movl	group_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L108
	movq	display(%rip), %rax
	movq	%rax, %rdi
	call	XFlush@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	draw_ui, .-draw_ui
	.section	.rodata
.LC32:
	.string	"Executing: %s\n"
	.text
	.globl	handle_click
	.type	handle_click, @function
handle_click:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L111
.L118:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	leaq	buttons(%rip), %rdx
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movl	button_count(%rip), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jne	.L112
	movl	$90, %eax
	jmp	.L113
.L112:
	movl	$120, %eax
.L113:
	movl	%eax, -20(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -36(%rbp)
	jl	.L114
	movq	-16(%rbp), %rax
	movl	(%rax), %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	cmpl	%eax, -36(%rbp)
	jge	.L114
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	%eax, -40(%rbp)
	jl	.L114
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	addl	$29, %eax
	cmpl	%eax, -40(%rbp)
	jg	.L114
	movl	button_count(%rip), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jne	.L115
	movl	dark_mode(%rip), %eax
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, dark_mode(%rip)
	call	draw_ui
	jmp	.L110
.L115:
	movq	-16(%rbp), %rax
	movzwl	8(%rax), %eax
	movzwl	%ax, %eax
	cltq
	imulq	$340, %rax, %rax
	leaq	apps(%rip), %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	addq	$80, %rax
	movq	%rax, %rsi
	leaq	.LC32(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-32(%rbp), %rax
	addq	$80, %rax
	movq	%rax, %rdi
	call	system@PLT
	jmp	.L110
.L114:
	addl	$1, -4(%rbp)
.L111:
	movl	button_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L118
.L110:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	handle_click, .-handle_click
	.globl	reload_config
	.type	reload_config, @function
reload_config:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L120
.L121:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	groups(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	addl	$1, -4(%rbp)
.L120:
	movl	group_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L121
	movl	$0, group_count(%rip)
	movl	$0, color_count(%rip)
	movl	$0, app_count(%rip)
	call	load_config
	call	build_ui
	call	draw_ui
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	reload_config, .-reload_config
	.section	.rodata
.LC33:
	.string	"Config changed, reloading..."
	.text
	.globl	check_file_changes
	.type	check_file_changes, @function
check_file_changes:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	config_file(%rip), %rax
	movq	%rax, %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L124
	movq	-56(%rbp), %rdx
	movq	last_config_time(%rip), %rax
	cmpq	%rax, %rdx
	jle	.L124
	leaq	.LC33(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	call	reload_config
.L124:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	check_file_changes, .-check_file_changes
	.section	.rodata
.LC34:
	.string	"\nHub Starting..."
.LC35:
	.string	"Cannot open X11 display\n"
.LC36:
	.string	"fixed"
.LC37:
	.string	"Listening for events...\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$240, %rsp
	movl	%edi, -228(%rbp)
	movq	%rsi, -240(%rbp)
	leaq	.LC34(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	cmpl	$1, -228(%rbp)
	jle	.L126
	movq	-240(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$127, %edx
	movq	%rax, %rsi
	leaq	config_file(%rip), %rax
	movq	%rax, %rdi
	call	strncpy@PLT
.L126:
	movl	$0, %edi
	call	XOpenDisplay@PLT
	movq	%rax, display(%rip)
	movq	display(%rip), %rax
	testq	%rax, %rax
	jne	.L127
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$24, %edx
	movl	$1, %esi
	leaq	.LC35(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	$1, %eax
	jmp	.L134
.L127:
	movq	display(%rip), %rax
	movl	224(%rax), %eax
	movl	%eax, -4(%rbp)
	movq	display(%rip), %rax
	movq	232(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$7, %rdx
	addq	%rdx, %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	display(%rip), %rax
	movq	232(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$7, %rdx
	addq	%rdx, %rax
	movq	88(%rax), %rcx
	movq	display(%rip), %rax
	movq	232(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$7, %rdx
	addq	%rdx, %rax
	movq	96(%rax), %rdx
	movq	display(%rip), %rax
	movq	-16(%rbp), %rsi
	subq	$8, %rsp
	pushq	%rcx
	pushq	%rdx
	pushq	$1
	movl	$800, %r9d
	movl	$1600, %r8d
	movl	$100, %ecx
	movl	$100, %edx
	movq	%rax, %rdi
	call	XCreateSimpleWindow@PLT
	addq	$32, %rsp
	movq	%rax, window(%rip)
	movq	window(%rip), %rcx
	movq	display(%rip), %rax
	movl	$32772, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSelectInput@PLT
	movq	window(%rip), %rsi
	movq	display(%rip), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateGC@PLT
	movq	%rax, gc(%rip)
	movq	display(%rip), %rax
	leaq	.LC36(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XLoadQueryFont@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L129
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movq	gc(%rip), %rcx
	movq	display(%rip), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetFont@PLT
.L129:
	movq	window(%rip), %rdx
	movq	display(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XMapWindow@PLT
	movq	display(%rip), %rax
	movq	%rax, %rdi
	call	XFlush@PLT
	call	load_config
	call	build_ui
	call	draw_ui
	leaq	.LC37(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L133:
	call	check_file_changes
	movq	display(%rip), %rax
	movq	%rax, %rdi
	call	XPending@PLT
	testl	%eax, %eax
	jle	.L130
	movq	display(%rip), %rax
	leaq	-224(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XNextEvent@PLT
	movl	-224(%rbp), %eax
	cmpl	$12, %eax
	jne	.L131
	call	draw_ui
	jmp	.L133
.L131:
	movl	-224(%rbp), %eax
	cmpl	$4, %eax
	jne	.L133
	leaq	-224(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movl	68(%rax), %edx
	movq	-32(%rbp), %rax
	movl	64(%rax), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	handle_click
	jmp	.L133
.L130:
	movl	$50000, %edi
	call	usleep@PLT
	jmp	.L133
.L134:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	main, .-main
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
