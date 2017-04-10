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

	

	mov ah , 1
	mov al , 04H
	call set_screen

	call delay

	mov cx ,10
s0:
	mov ah , 3
	call set_screen

	call delay
	loop s0

	mov ah , 2
	mov al , 02H
	call set_screen


	call delay

	

	mov ah , 0
	call set_screen

	call delay

	mov ax , 4c00h
	int 21h

;===============================setScreen
set_screen:
	jmp set_screen_start
table dw  clear_screen , set_front_color ,set_background_color ,set_scroller
set_screen_start:
	push bx 
	cmp ah , 3
	ja  set_screen_Ret
	mov bl , ah
	mov bh , 0
	add bx , bx 
	call word ptr cs:table[bx]
set_screen_Ret:
	pop bx 
	ret

;===========================clear_screen
clear_screen:
	push bx 
	push cx 
	push es

	mov bx , 0B800H
	mov es , bx 
	mov cx , 2000

	mov bx , 0
clear_screen_loop:
	
	mov byte ptr es:[bx] ,' '
	add bx , 2
	loop clear_screen_loop
	pop es 
	pop cx
	pop bx 
	ret

;==============================set_front_color
set_front_color:
	
	push bx 
	push cx 
	push es

	mov bx , 0B800H
	mov es , bx 
	mov cx , 2000

	mov bx , 1

set_front_color_loop:
	and byte ptr es:[bx] , 11111000b
	or  es:[bx] ,al 
	add bx , 2
	loop set_front_color_loop
	pop es 
	pop cx
	pop bx 
	ret

;==============================set_background_color
set_background_color:
	
	push bx 
	push cx 
	push es

	mov cl , 4
	shl al , cl

	mov bx , 0B800H
	mov es , bx 
	mov cx , 2000

	mov bx , 1
;10001111b
set_background_color_loop:
	and byte ptr es:[bx] , 10001111b
	or  es:[bx] , al
	add bx , 2
	loop set_background_color_loop
	pop es 
	pop cx
	pop bx 
	ret
;=======================================set_scroller
set_scroller:
	push bx 
	push cx 
	push ds 
	push es
	push si
	push di
	mov bx , 0b800h
	mov es , bx 
	mov ds , bx 

	mov cx , 24
	mov si , 160
	mov di , 0 
	
	cld 
set_scroller_loop:
	push cx
	
	mov cx , 160
	rep movsb 
	
	pop cx 
	
	
	loop set_scroller_loop
	pop di
	pop si
	pop es 
	pop ds
	pop cx
	pop bx

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

code ends 

end start