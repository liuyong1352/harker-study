assume cs:code ,ds:data , ss:stack

;

data segment
	   ;0123456789ABCDEF
	db 'welcome to masm!'
	db 00000010b
	db 00100100b
	db 01110001b
data ends 


stack segment
	db 128 dup(0)
stack ends

code segment

start:
	
	mov ax , stack
	mov ss , ax 
	mov sp , 128

	jmp showMasm

next:
	mov ax , 4C00H
	int 21H

showMasm:
	mov ax , data
	mov ds , ax 
	mov si , 0 

	mov ax , 0B800H
	mov es , ax 
	mov di , 160*12 + 30*2

	mov bx , 0 

	mov cx , 3
s0:
	
	push cx
	push di 
	push si 
	mov cx , 16 
s:
	mov dx , 0 
	mov dl , ds:[si]
	mov dh , ds:[bx + 16] 

	mov es:[di] , dx  ;0277

	inc si 
	add di , 2 

	loop s
	pop si 
	pop di 
	pop cx 

	inc bx d
	add di , 160

	loop s0	

	jmp next



code ends 

end start