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


	call cpy_new_int7c
	call set_new_int7c
	


	mov ah , 1
	mov al , 4
	int 7ch

	call delay

	mov cx ,10
	mov ah ,3
s0:
	
	int 7ch
	call delay
	loop s0

	mov ah ,2
	mov al ,02h
	int 7ch 

	call delay

	mov ah , 0 
	int 7ch

	mov ax , 4c00h
	int 21h

;===============================set_new_int7c
set_new_int7c:
	push ax 
	push es 
	mov ax , 0
	mov es , ax 

	cli
	mov word ptr es:[7cH * 4] , 7e00H
	mov word ptr es:[7ch*4 + 2] , 0 
	sti
	pop es
	pop ax 
	ret

;===============================cpy_new_int7c
cpy_new_int7c:
	push ax
	push cx
	push ds 
	push es
	push si 
	push di  

	mov ax , cs 
	mov ds , ax 

	mov ax , 0
	mov es , ax 
	mov si , offset new_int7c
	mov di , 7e00H

	mov cx , offset new_int7c_end - offset new_int7c
	cld
	rep movsb

	pop di
	pop si 
	pop es
	pop ds
	pop cx 
	pop ax
	
	ret

;===============================new_int7c
new_int7c: 
	jmp new_int7c_start 

;============================================
;============================================
TABLE dw offset clear_screen    	 -  offset new_int7c + 7e00H 
	  dw offset set_front_color 	 -  offset new_int7c + 7e00H
	  dw offset set_background_color -  offset new_int7c + 7e00H
	  dw offset set_scroller         -  offset new_int7c + 7e00H   
;============================================
;============================================

new_int7c_start:
	
	push bx 
	push es 

	mov bx , 0
	mov es , bx

	mov bl , ah
	add bx , bx 
	add bx , offset TABLE - offset new_int7c + 7e00H 

	call word ptr es:[bx] 
	
	pop es
	pop bx
	 
	iret
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
	
	push ax 
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
	pop ax
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

new_int7c_end:nop


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
set_screen_end:nop
code ends 

end start