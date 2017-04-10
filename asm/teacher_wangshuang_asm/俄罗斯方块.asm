assume cs:code ,ds:data , ss:stack

data segment
	db 10 dup(0)
data ends

stack segment
	db 16 dup (0)
stack ends


code segment

start:
	mov ax , 0
	mov es , ax 
	mov bx , 200h
	mov al , 1
	mov ch , 0 
	mov cl , 1
	mov dl , 0 
	mov dh , 0
	mov ah , 2
	int 13h
	
	mov ax , 4c00h
	int 21h

code ends 

end start