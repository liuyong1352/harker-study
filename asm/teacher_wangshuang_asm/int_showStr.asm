assume cs:code ,ds:data , ss:stack

data segment
	   ;0123456789ABCDEF
	db 'welcome to masm !' , 0
data ends 

stack segment
	db 16 dup (0)
stack ends

code segment

start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 16

	call clear_screen
	call cpy_new_int7C
	call set_new_int7C
	
	call show_string

	mov ax ,4c00h
	int 21h


;===============================
show_string:
	mov dh , 15
	mov dl , 20 
	mov cl , 2
	mov ax , data
	mov ds , ax
	mov si , 0 
	int 7ch

	ret

;===============================
new_int7C_start:
	
	push ax 
	push dx 
	push cx 
	push ds 
	push es
	push si
	push di 

	
	mov ax , 0B800H
	mov es , ax 
	mov di , 0 

	call get_row
	call get_col

s:	mov dl , ds:[si]
	cmp dl , 0  
	je s_ret
	mov dh , cl 
	mov es:[di] , dx 
	add di , 2
	inc si 
	jmp s

s_ret:
	pop di 
	pop si 
	pop es
	pop ds
	pop cx 
	pop dx 
	pop ax 
	iret

get_row:
	mov ah , 0
	mov al , 160 
	mul dh 
	add di , ax 
	ret

get_col:
	mov ah , 0 
	mov al , 2 
	mul dl 
	add di , ax 
	ret


new_int7C_end: nop 



;===============================
set_new_int7C:
	mov ax , 0 
	mov es , ax 
	mov word ptr es:[7CH * 4] , 200H
	mov word ptr es:[7CH*4 + 2] , 0 
	ret

;===============================
cpy_new_int7C:
	mov ax  , cs
	mov ds , ax 
	mov si , OFFSET new_int7C_start

	mov ax , 0
	mov es , ax 
	mov di , 200H

	mov cx , OFFSET new_int7C_end - OFFSET new_int7C_start 
	cld 
	rep movsb
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