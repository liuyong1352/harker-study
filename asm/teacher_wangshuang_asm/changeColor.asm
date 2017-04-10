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

	call cpy_new_int9
	call install_new_int9
testA:
	mov ax , 0
	jmp testA 

	mov ax , 4c00h
	int 21h
;=======================install_new_int9
install_new_int9:
	
	push ax 
	push es

	mov ax , 0
	mov es , ax


	push es:[9*4] ;ip
	pop es:[200h] 
	push es:[9*4+2] ;cs
	pop es:[202h]

	cli 
	mov word ptr es:[9*4] , 204h
	mov word ptr es:[9*4+2] ,0
	sti 

	pop es 
	pop ax 

	ret
;=======================cpy_new_int9
cpy_new_int9:
	push ax 
	push cx 
	push ds 
	push es 
	push si
	push di 

	mov ax ,cs
	mov ds , ax 
	mov ax , 0
	mov es , ax 
	mov si , offset new_int9
	mov di , 204h
	mov cx , offset new_int9_end - offset new_int9 
	cld 
	rep movsb
	pop di 
	pop si
	pop es
	pop ds
	pop cx 
	pop ax 
	ret

;=======================new_int9
new_int9:
	push ax 
	push bx
	push cx 
	push es
	
	in al , 60h
	pushf
	call dword ptr cs:[200h]
	cmp al , 3bh ;F1扫描码为3bh

	jne int9Ret
	mov ax , 0B800h
	mov es , ax 
	mov bx , 1
	mov cx , 2000
s:	inc byte ptr es:[bx] 
	add bx , 2
	loop s 
int9Ret:
	pop es
	pop cx 
	pop bx 
	pop ax 
	iret
new_int9_end:nop






code ends 

end start