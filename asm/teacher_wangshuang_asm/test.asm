assume cs:code  , ss:stack

stack segment
	db 16 dup (0)
stack ends

code segment


	
start:
	mov ax , stack
	mov ss , ax 
	mov sp , 16

	call clear_screen

	call init_reg

testA:
	call get_block_type
	call delay   
	call clear_screen
	jmp testA

	mov ax, 4c00H
	int 21H


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

;===============================
get_block_type:
	push ax 
	push bx 
	mov al , 0 
	out 70h , al
	in al , 71h
	
	and al , 00001111b
	mov ah , 0 

	mov bl , 3 
	div bl 
	 
	mov bh , 0
	mov bl , ah 
	mov es:[ bx + 160*10 + 20*2] , 5501H  

	pop bx 
	pop ax 

	ret
;===============================
init_reg:
	mov bx , 0b800h
	mov es , bx 
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