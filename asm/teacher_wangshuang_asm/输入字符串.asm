assume cs:code ,ds:data , ss:stack

data segment
	db 10 dup(0)
data ends

stack segment
	db 16 dup (0)
stack ends


code segment

start:
	mov ax , stack
	mov ss , ax 
	mov sp , 16

	mov bx , data
	mov ds , bx 

	mov si , 0 
s0:	
	mov ah , 0
	int 16h
	cmp al , 20h
	jb  nochar

	mov ah , 0 
	call charstack

	jmp s0
	

nochar:
	cmp ah ,0eh ;退格键
	je backspace
	
	mov ax , 4c00h
	int 21h

backspace:
	mov ah , 1
	call charstack
	
	jmp s0

;====================charstack
charstack:
	

	push bx 
	push cx
	push es
	push si
	push di 

	jmp charstack_start
	table 	dw push_char ,pop_char
	top 	dw 0 
charstack_start:
	mov bx ,0
	mov bl , ah
	add bx ,bx 
	jmp word ptr table[bx]

;====================push_char
push_char:
	
	call show_str
	inc top 
	jmp sret 
pop_char:
	
	mov al , ' '
	call show_str
	
	cmp top , 0 
	je sret
	
	dec top
	jmp sret

sret:
	pop di
	pop si
	pop es
	pop cx
	pop bx
	ret
	
;====================show_str
; al  
show_str:
	
	push bx 
	push es
	push di


	mov bx , 0b800h
	mov es , bx 
	mov bx , 0 

	mov di , top
	shl di , 1
	add di , 160*12 + 40*2
	
	mov byte ptr es:[di] , al
	pop di
	pop es
	pop bx
	ret


code ends 

end start