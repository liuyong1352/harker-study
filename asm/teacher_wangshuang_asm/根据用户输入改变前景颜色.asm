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
choose_color:	
	mov ah , 0
	int 16h

	mov ah , 1
	cmp al ,'g'
	je green
	cmp al ,'r'
	je red
	cmp al , 'b'
	je blue
	jmp sret
red:
	shl ah , 1
green:
	shl ah , 1
blue:
	call change_color
	jmp choose_color
sret:
	mov ax , 4c00h
	int 21h
;========================change_color
;al is color
change_color:
	push ax
	push bx
	push cx
	push es
	mov bx , 0b800h
	mov es , bx
	mov bx , 1
	mov cx , 2000
change_color_loop:
	and byte ptr es:[bx] , 11111000b
	or  es:[bx] ,ah 
	add bx , 2
	loop change_color_loop
	pop es
	pop cx
	pop bx
	pop ax
	ret

code ends 

end start