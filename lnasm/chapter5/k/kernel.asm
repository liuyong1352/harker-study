; 编译链接方法
; $ nasm -f elf kernel.asm -o kernel.o
; $ ld -s kernel.o -o kernel.bin    #‘-s’选项意为“strip all”

SELECTOR_KERNEL_CS	equ	8

; 导入函数
extern	cstart

; 导入全局变量
extern	gdt_ptr
[SECTION .bss]
StackSpace		resb	2 * 1024
StackTop:		; 栈顶

[section .text]	; 代码在此

global _start	; 导出 _start

_start:
	mov esp , StackTop
	sgdt [gdt_ptr]
	call cstart
	
	jmp	$
