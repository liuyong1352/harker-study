assume cs:code ,ds:data , ss:stack 

data segment
	   ;0123456789ABCDEF
	dw 1,2,23,4343,43434 

	;以上是21年公司催员人数的21个word型数据
data ends 

table segment
	db 21 dup('year summ ne ?? ')
table ends 


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

	mov si , 12 
	
	mov cx , 2 

	; dh = 行号 （0-24） dl = 列号 （0 - 79 ） 
	; cl = 颜色 ， ds:si 指向字符串的首地址
	mov dh , 20
	mov dl , 40


	mov cl , 4

s:  push cx 

	mov ax , ds:[bx]
	add bx , 2 
	call dtoc

	call show_str
	inc dh 
	pop cx 
	loop s

	mov ax ,4c00h
	int 21h


;========================================================
;ax = word 型数据 ds:si指向字符串的首地址
dtoc:
	push ax 
	push bx 
	push cx 
	push dx 
	push si
 	
 	mov bx , 10
 	mov dx , 0 
dtoc_l:

	div bx 
	mov cx , ax
	jcxz dtoc_ret
	add  dx , 30H
	mov ds:[si]  ,dl 
	mov dx , 0
	inc si

	jmp dtoc_l

dtoc_ret:
	
	add  dx , 30H
	mov ds:[si]  ,dl
	inc si

	mov byte ptr ds:[si] , 0 

	pop si
	pop dx 
	pop cx 
	pop bx
	pop ax 
	ret


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