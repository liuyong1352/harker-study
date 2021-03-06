; ==========================================
; pmtest2.asm
; 编译方法：nasm pmtest2.asm -o pmtest2.com
; ==========================================
%include "pm.inc"
;org 07c00h
org 0100h
jmp LABEL_BEGIN

[SECTION .gdt]
; GDT
; 段基址, 段界限 , 属性
LABEL_GDT: Descriptor 0, 0, 0 ; 空描述符
LABEL_DESC_CODE32: Descriptor 0, SegCode32Len - 1, DA_C + DA_32; 非一致代码段
LABEL_DESC_DATA:   Descriptor    0,      DataLen-1, DA_DRW    ; Data
LABEL_DESC_TEST:   Descriptor 0500000h,     0ffffh, DA_DRW
LABEL_DESC_VIDEO: Descriptor 0B8000h, 0ffffh, DA_DRW ; 显存首地址
; GDT 结束

GdtLen 	equ $ - LABEL_GDT ; GDT长度
GdtPtr 	dw GdtLen - 1 ; GDT界限
	dd 0 ; GDT基地址
; GDT 选择子
SelectorCode32 	equ LABEL_DESC_CODE32 - LABEL_GDT
SelectorData		equ	LABEL_DESC_DATA		- LABEL_GDT
SelectorTest	equ LABEL_DESC_TEST  - LABEL_GDT
SelectorVideo 	equ LABEL_DESC_VIDEO - LABEL_GDT
; END of [SECTION .gdt]

[SECTION .data1]	 ; 数据段
ALIGN	32
[BITS	32]
LABEL_DATA:
SPValueInRealMode	dw	0
; 字符串
PMMessage:		db	"In Protect Mode now. ^-^", 0	; 在保护模式中显示
OffsetPMMessage		equ	PMMessage - $$
StrTest:		db	"ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
OffsetStrTest		equ	StrTest - $$
DataLen			equ	$ - LABEL_DATA
; END of [SECTION .data1]

; 全局堆栈段
[SECTION .gs]
ALIGN	32
[BITS	32]
LABEL_STACK:
	times 512 db 0

TopOfStack	equ	$ - LABEL_STACK - 1

; END of [SECTION .gs]

[SECTION .s16]
[BITS 16]
LABEL_BEGIN:
mov ax, cs
mov ds , ax 
mov es , ax 
mov ss , ax 
mov sp , 0100h
; 初始化 32 位代码段描述符

xor eax, eax
mov ax, cs
shl eax, 4
add eax, LABEL_SEG_CODE32
mov word [LABEL_DESC_CODE32 + 2], ax
shr eax, 16
mov byte [LABEL_DESC_CODE32 + 4], al
mov byte [LABEL_DESC_CODE32 + 7], ah

xor eax , eax 
mov ax , cs 
shl eax , 4 
add eax , LABEL_DATA
mov word [LABEL_DESC_DATA + 2], ax
shr eax, 16
mov byte [LABEL_DESC_DATA + 4], al
mov byte [LABEL_DESC_DATA + 7], ah

; 为加载GDTR 作准备
xor eax, eax
mov ax, ds
shl eax, 4
add eax, LABEL_GDT ; eax <- gdt 基地址
mov dword [GdtPtr + 2], eax ; [GdtPtr + 2] <- gdt 基地址

; 加载 GDTR
lgdt [GdtPtr]
;关中断
cli
;打开地址线A20
; 打开地址线A20
in al, 92h
or al, 00000010b
out 92h, al

; 准备切换到保护模式
mov eax, cr0
or eax, 1
mov cr0, eax

; 真正进入保护模式
jmp dword SelectorCode32:0 ; 执行这一句会把SelectorCode32 装入cs,
; 并跳转到Code32Selector:0 处
; END of [SECTION .s16]


[SECTION .s32]; 32 位代码段. 由实模式跳入.
[BITS 32]

LABEL_SEG_CODE32:
	mov ax , SelectorData
	mov ds , ax ;数据段选择子
	mov ax , SelectorTest
	mov es , ax ;测试选择子
	mov ax, SelectorVideo
	mov gs, ax ; 视频段选择子(目的)

	mov ah, 0Ch ; 0000:黑底 1100:红字
	xor esi , esi 
	xor edi , edi 
	mov esi , OffsetPMMessage  ; 源数据偏移
	mov edi , (80 * 10 + 0 )*2 ; 目的数据偏移 。屏幕第 10 行 ，第0列
	cld 
.1:	
	lodsb
	test al , al
	jz .2  
	mov [gs:edi], ax;
	add edi , 2
	jmp .1 
	; 到此停止
.2:	hlt
	jmp .2
	
SegCode32Len equ $ - LABEL_SEG_CODE32
; END of [SECTION .s32]
;[SECTION .end]
;times   510-($-$$)      db      0       ; 填充剩下的空间，使生成的二进制代码恰好为512字节
;dw      0xaa55                          ; 结束标志

