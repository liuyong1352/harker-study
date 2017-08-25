; ==========================================
; pmtest23.asm
; 编译方法：nasm pmtest23.asm -o pmtest23.com
; 探索ldt
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
LABEL_DESC_CODE16: Descriptor    0,         0ffffh, DA_C      ; 非一致代码段, 16
LABEL_DESC_CODE_DEST: Descriptor 0,SegCodeDestLen-1, DA_C+DA_32; 非一致代码段,32
LABEL_DESC_NORMAL: Descriptor    0,         0ffffh, DA_DRW    ; Normal 描述符
;LABEL_DESC_DATA:   Descriptor    0,      DataLen-1, DA_DRW + DA_DPL1   ; Data
LABEL_DESC_DATA:   Descriptor    0,      DataLen-1, DA_DRW    ; Data
LABEL_DESC_STACK:  Descriptor    0,     TopOfStack, DA_DRWA+DA_32; Stack, 32 位
LABEL_DESC_TEST:   Descriptor 0500000h,     0ffffh, DA_DRW
LABEL_DESC_LDT:    Descriptor       0,        LDTLen - 1, DA_LDT	; LDT
LABEL_DESC_VIDEO: Descriptor 0B8000h, 0ffffh, DA_DRW ; 显存首地址

; 门                               目标选择子,偏移,DCount, 属性
LABEL_CALL_GATE_TEST: Gate SelectorCodeDest,   0,     0, DA_386CGate+DA_DPL0
; GDT 结束

GdtLen 	equ $ - LABEL_GDT ; GDT长度
GdtPtr 	dw GdtLen - 1 ; GDT界限
	dd 0 ; GDT基地址
; GDT 选择子
SelectorNormal		equ	LABEL_DESC_NORMAL	- LABEL_GDT
SelectorCode32 		equ LABEL_DESC_CODE32 	- LABEL_GDT
SelectorCode16		equ	LABEL_DESC_CODE16	- LABEL_GDT
SelectorCodeDest	equ	LABEL_DESC_CODE_DEST	- LABEL_GDT
;SelectorData		equ	LABEL_DESC_DATA		- LABEL_GDT + SA_RPL3
SelectorData		equ	LABEL_DESC_DATA		- LABEL_GDT 
SelectorStack		equ	LABEL_DESC_STACK	- LABEL_GDT
SelectorLDT			equ	LABEL_DESC_LDT		- LABEL_GDT
SelectorTest	equ LABEL_DESC_TEST  - LABEL_GDT
SelectorVideo 	equ LABEL_DESC_VIDEO - LABEL_GDT
SelectorCallGateTest	equ	LABEL_CALL_GATE_TEST	- LABEL_GDT
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
	mov	[LABEL_GO_BACK_TO_REAL + 3]  , ax 
	mov	[SPValueInRealMode], sp
	
	; 初始化 16 位代码段描述符
	mov	ax, cs
	movzx	eax, ax
	shl	eax, 4
	add	eax, LABEL_SEG_CODE16
	mov	word [LABEL_DESC_CODE16 + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_CODE16 + 4], al
	mov	byte [LABEL_DESC_CODE16 + 7], ah

xor eax, eax
mov ax, cs
shl eax, 4
add eax, LABEL_SEG_CODE32
mov word [LABEL_DESC_CODE32 + 2], ax
shr eax, 16
mov byte [LABEL_DESC_CODE32 + 4], al
mov byte [LABEL_DESC_CODE32 + 7], ah

xor eax , eax 
mov ax , ds 
shl eax , 4 
add eax , LABEL_DATA
mov word [LABEL_DESC_DATA + 2], ax
shr eax, 16
mov byte [LABEL_DESC_DATA + 4], al
mov byte [LABEL_DESC_DATA + 7], ah
	; 初始化测试调用门的代码段描述符
	xor	eax, eax
	mov	ax, cs
	shl	eax, 4
	add	eax, LABEL_SEG_CODE_DEST
	mov	word [LABEL_DESC_CODE_DEST + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_CODE_DEST + 4], al
	mov	byte [LABEL_DESC_CODE_DEST + 7], ah

	; 初始化堆栈段描述符
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_STACK
	mov	word [LABEL_DESC_STACK + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_STACK + 4], al
	mov	byte [LABEL_DESC_STACK + 7], ah

	; 初始化 LDT 在 GDT 中的描述符
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_LDT
	mov	word [LABEL_DESC_LDT + 2], ax
	shr	eax, 16
	mov	byte [LABEL_DESC_LDT + 4], al
	mov	byte [LABEL_DESC_LDT + 7], ah

	; 初始化 LDT 中的描述符
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, LABEL_CODE_A
	mov	word [LABEL_LDT_DESC_CODEA + 2], ax
	shr	eax, 16
	mov	byte [LABEL_LDT_DESC_CODEA + 4], al
	mov	byte [LABEL_LDT_DESC_CODEA + 7], ah
	
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LABEL_REAL_ENTRY:		; 从保护模式跳回到实模式就到了这里
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov	ss, ax

	mov	sp, [SPValueInRealMode]

	in	al, 92h		; `.
	and	al, 11111101b	;  | 关闭 A20 地址线
	out	92h, al		; /

	sti			; 开中断

	mov	ax, 4c00h	; `.
	int	21h		; /  回到 DOS
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
	
	mov	ax, SelectorStack
	mov	ss, ax			; 堆栈段选择子

	mov	esp, TopOfStack
	
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
.2:	;显示完毕
	call	DispReturn
	call 	TestRead
	call 	TestWrite
	call 	TestRead
	; 到此停止
    ;	jmp	SelectorCode16:0
	call DispReturn
	; 测试调用门（无特权级变换），将打印字母 'C'
	call	SelectorCallGateTest:0

	;LOAD LDT
	mov ax  , SelectorLDT
	lldt ax 
	jmp SelectorLDTCodeA:0	;跳入局部任务
; ------------------------------------------------------------------------
TestRead:
	xor	esi, esi
	mov	ecx, 8
.loop:
	mov	al, [es:esi]
	call	DispAL
	inc	esi
	loop	.loop

	call	DispReturn

	ret
; TestRead 结束-----------------------------------------------------------
; ------------------------------------------------------------------------
TestWrite:
	push	esi
	push	edi
	xor	esi, esi
	xor	edi, edi
	mov	esi, OffsetStrTest	; 源数据偏移
	cld
.1:
	lodsb
	test	al, al
	jz	.2
	mov	[es:edi], al
	inc	edi
	jmp	.1
.2:

	pop	edi
	pop	esi

	ret
; TestWrite 结束----------------------------------------------------------


; ------------------------------------------------------------------------
; 显示 AL 中的数字
; 默认地:
;	数字已经存在 AL 中
;	edi 始终指向要显示的下一个字符的位置
; 被改变的寄存器:
;	ax, edi
; ------------------------------------------------------------------------
DispAL:
	push	ecx
	push	edx

	mov	ah, 0Ch			; 0000: 黑底    1100: 红字
	mov	dl, al
	shr	al, 4
	mov	ecx, 2
.begin:
	and	al, 01111b
	cmp	al, 9
	ja	.1
	add	al, '0'
	jmp	.2
.1:
	sub	al, 0Ah
	add	al, 'A'
.2:
	mov	[gs:edi], ax
	add	edi, 2

	mov	al, dl
	loop	.begin
	add	edi, 2

	pop	edx
	pop	ecx

	ret
; DispAL 结束-------------------------------------------------------------
; ------------------------------------------------------------------------
DispReturn:
	push	eax
	push	ebx
	mov	eax, edi
	mov	bl, 160
	div	bl
	and	eax, 0FFh
	inc	eax
	mov	bl, 160
	mul	bl
	mov	edi, eax
	pop	ebx
	pop	eax

	ret
; DispReturn 结束---------------------------------------------------------	
SegCode32Len equ $ - LABEL_SEG_CODE32
; END of [SECTION .s32]

[SECTION .sdest] ; 调用门目标段
[BITS 32]
LABEL_SEG_CODE_DEST:
	;jmp	$
	mov	ax, SelectorVideo
	mov	gs, ax			; 视频段选择子(目的)

	mov	edi, (80 * 12 + 0) * 2	; 屏幕第 12 行, 第 0 列。
	mov	ah, 0Ch			; 0000: 黑底    1100: 红字
	mov	al, 'C'
	mov	[gs:edi], ax

	retf

SegCodeDestLen	equ	$ - LABEL_SEG_CODE_DEST
; END of [SECTION .sdest]

; 16 位代码段. 由 32 位代码段跳入, 跳出后到实模式
[SECTION .s16code]
ALIGN	32
[BITS	16]
LABEL_SEG_CODE16:
	; 跳回实模式:
	mov	ax, SelectorNormal
	mov	ds, ax
	mov	es, ax
	mov	fs, ax
	mov	gs, ax
	mov	ss, ax

	mov	eax, cr0
	and	al, 11111110b
	mov	cr0, eax

LABEL_GO_BACK_TO_REAL:
	jmp	0:LABEL_REAL_ENTRY	; 段地址会在程序开始处被设置成正确的值

Code16Len	equ	$ - LABEL_SEG_CODE16
; END of [SECTION .s16code]
;LDT
[SECTION .ldt]
ALIGN 32
LABEL_LDT:
;                            段基址       段界限      属性
LABEL_LDT_DESC_CODEA: Descriptor 0, CodeALen - 1, DA_C + DA_32 ; Code, 32 位

LDTLen		equ	$ - LABEL_LDT

; LDT 选择子
SelectorLDTCodeA	equ	LABEL_LDT_DESC_CODEA	- LABEL_LDT + SA_TIL
; END of [SECTION .ldt]

; CodeA (LDT, 32 位代码段)
[SECTION .la]
ALIGN	32
[BITS	32]
LABEL_CODE_A:
	mov	ax, SelectorVideo
	mov	gs, ax			; 视频段选择子(目的)

	mov	edi, (80 * 13 + 0) * 2	; 屏幕第 10 行, 第 0 列。
	mov	ah, 0Ch			; 0000: 黑底    1100: 红字
	mov	al, 'L'
	mov	[gs:edi], ax

	; 准备经由16位代码段跳回实模式
	jmp	SelectorCode16:0
CodeALen	equ	$ - LABEL_CODE_A
; END of [SECTION .la]