assume cs:code ,ds:data , ss:stack

data segment
	   ;0123456789ABCDEF
	db 'word' , 0
	db 'unix' , 0 
	db 'wind' , 0
	db 'good' , 0 
data ends 


stack segment
	db 128 dup (0)
stack ends

code segment

start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 128

	mov ax , data
	mov ds , ax 
	mov bx , 0 

	call clear_screen

	mov cx , 4
	mov di , 160*10 + 40*2
	mov si , 0 
s:
	call show_str
	call capital
	add di , 160	
	call show_str
	add di , 160
	add si , 5
	
	loop s	

	mov ax ,4c00h
	int 21h





;=======================show string
show_str :
	
	push ax 
	push ds
	push es
	
	push cx 
	push si
	push di  

	mov ax , 0B800H
	mov es , ax 


show_str_inter:
	mov ax , 0 
	mov cx , 0  
	mov cl , ds:[si]
	
	jcxz showStrRet
	mov al ,cl 
	mov ah ,01H
	mov es:[di] , ax 
	add di , 2
	inc si 
	jmp show_str_inter
	
showStrRet: 
	pop di 
	pop si
	pop cx 
	pop es
	pop ds
	pop ax 
	ret


;===============================================
capital:
	push cx 
	push ds 
	push si 
	 
capital_inter:	

	mov cl , ds:[si] 
	mov ch , 0 
	jcxz capital_ret  
	and byte ptr ds:[si] , 11011111b
	inc si 
	jmp capital_inter

	
capital_ret:
	pop si
	pop ds  
	pop cx 
	
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
	mov word ptr es:[di] , 00H
	add di , 2
	loop clearScreen

	pop ax 
	pop di 
	pop cx 
	pop es
	ret 




code ends 

end start