assume cs:code ,ds:data , ss:stack

data segment
	dw 0 , 0 
data ends

stack segment
	db 16 dup (0)
stack ends


code segment

start:
	mov ax , stack
	mov ss , ax 
	mov sp , 16

	call clear_screen

	mov ax ,data
	mov ds ,ax 

	mov ax, 0
	mov es, ax

	;保存九号中断
	push es:[9*4] ;ip
	pop ds:[0]
	push es:[9*4 + 2]  ;cs
	pop ds:[2]

	;安装新的九号中断
	cli
	mov word ptr es:[9*4] , offset int9
	mov es:[9*4 + 2] , cs
	sti

	mov ax , 0b800h
	mov es , ax 
	mov al , 'a'
	mov ah , 02h
s:	mov es:[160*12+40*2] , ax
	call delay
	inc al 
	cmp al , 'z'
	jna s




	mov ax , 4c00h
	int 21h

;=======================int9
int9:
	push ax 
	push bx
	push es
	
	in al , 60h
	pushf
	pushf
	pop bx
	and bh ,11111100b
	push bx
	popf 
	call dword ptr ds:[0]
	cmp al , 1
	jne int9Ret
	mov ax , 08b00h
	mov es , ax 
	inc byte ptr es:[160*12+40*2 + 1] 
int9Ret:
	 
	pop es
	pop bx 
	pop ax 
	ret

;=======================delay
delay:
	push ax 
	push dx 

	mov dx , 08h
	mov ax , 0 
delay_begin:
	sub ax , 1
	sbb dx , 0
	cmp ax ,0 
	jne delay_begin
	cmp dx , 0 
	jne delay_begin
	pop dx 
	pop ax 
	ret

;=======================clear screen
clear_screen:
	push es 
	push cx 
	push di 
	push ax 
	mov ax , 0B800H
	mov es , ax 
	mov cx , 2000
	mov di , 0 

clearScreen:
	mov word ptr es:[di] , 07H
	add di , 2
	loop clearScreen

	pop ax 
	pop di 
	pop cx 
	pop es
	ret 

code ends 

end start