assume cs:code ,ds:data , ss:stack

data segment
	   ;0123456789ABCDEF
	db 'conversation' , 0
data ends 

stack segment
	db 16 dup (0)
stack ends

code segment

start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 16

	call cpy_new_int7C
	call set_new_int7C
	
	mov ax , data
	mov ds , ax 
	mov si , 0 

	mov ax , 0B800H
	mov es , ax 
	mov di , 160*12 + 20*2 
s: 	cmp byte ptr ds:[si] , 0 
	je ok
	mov al , ds:[si] 
	mov es:[di] ,al
	inc si 
	add di , 2
	mov bx , offset s - offset ok

	int 7CH

ok:	mov ax ,4c00h
	int 21h

new_int7C_start:
	push bp 
	mov bp  , sp 
	add ss:[bp + 2] , bx 
	pop bp 
	iret
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

code ends 

end start