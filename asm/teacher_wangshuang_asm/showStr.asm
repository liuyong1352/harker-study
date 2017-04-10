assume cs:code ,ds:data , ss:stack

data segment
	   ;0123456789ABCDEF
	db 'Welcom to masm!' , 0
data ends 


stack segment
	db 128 dup (0)
stack ends

code segment

start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 128
	
	mov dh , 8 
	mov dl , 30 
	mov cl , 4

	mov ax , data
	mov ds , ax 
	mov si , 0 

	call clear_screen

	call show_str

	mov ax ,4c00h
	int 21h





;=======================show string =====================
; dh = 行号 （0-24） dl = 列号 （0 - 79 ） 
; cl = 颜色 ， ds:si 指向字符串的首地址 
; 返回无 
show_str :
	
	push ax 
	push dx
	push cx 
	
	push ds
	push es
	
	
	push si
	push di
	 

	;cal row 
	mov di , 0 
	mov al , 160
	mul dh 				; result in ax 
	mov di , ax 

	;cal col 
	mov al , 2 
	mul dl 
	add di , ax 

	;cal color
	mov dh , cl 

	mov ax , 0B800H
	mov es , ax 


show_str_inter:
	
	mov cx , 0  
	mov cl , ds:[si]
	
	jcxz showStrRet
	mov dl ,cl 
	
	mov es:[di] , dx 
	add di , 2
	inc si 
	jmp show_str_inter
	
showStrRet: 



	pop di 
	pop si
	
	pop es
	pop ds
	pop cx 
	pop dx 
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