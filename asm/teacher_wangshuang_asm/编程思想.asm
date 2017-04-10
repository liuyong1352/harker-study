assume cs:code  , ss:stack

stack segment
	db 16 dup (0)
stack ends

code segment

string1: db 'welcome to masm1 !' , 0
string2: db 'welcome to masm2 !' , 0
string3: db 'welcome to masm3 !' , 0
string4: db 'welcome to masm4 !' , 0
string_add:  dw offset string1
			 dw	offset string2
			 dw	offset string3
			 dw offset string4
row:	db 2, 4, 6, 8
start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 16

	call clear_screen
	call show_prose

	mov ax ,4c00h
	int 21h
;=======================show_prose
show_prose:
	
	mov ax , cs
	mov ds , ax 

	mov bx , offset string_add
	mov di , offset row

	mov cx , 4
	
s:	
	mov si , ds:[bx]
	mov dh , ds:[di]
	call show_string
	add bx , 2
	inc di
	 
	loop s
	ret

;=======================show_string
;dh = 行号 
show_string:
	push ax 
	push bx 
	push dx 
	push es 
	push si 
	push di

	call get_row

	mov ax , 0B800H
	mov es , ax 
	
showString:
	mov dh , 07H
	mov dl , ds:[si]
	cmp dl , 0
	je showStringRet
	mov es:[di] , dx 
	add di , 2
	inc si
	jmp showString
showStringRet:

	pop di 
	pop si 
	pop es 
	pop dx
	pop bx 
	pop ax 
	ret

get_row:
	mov al , 160 
	mul dh 
	mov di , ax 
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