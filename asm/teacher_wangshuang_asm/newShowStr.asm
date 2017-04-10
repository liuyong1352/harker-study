assume cs:code ,ds:data , ss:stack

data segment
	   ;0123456789ABCDEF
	db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends 

stack segment
	db 128 dup (0)
stack ends

code segment

start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 128
	
	call clear_screen
	
	mov ax ,data
	mov ds ,ax 
	mov si , 0 

	mov dh , 10 
	mov dl , 10
	mov cl ,2

	call show_str

	call letterc

	mov dh , 11
	call show_str

	mov ax ,4c00h
	int 21h



;=======================letterc==========================
letterc :
	
	push ax 
	push dx

	push si
	push di  

	mov ax , data
	mov es , ax 
	

letterc_loop:
	mov dl , ds:[si]
	cmp dl , 0 
	je letterc_ret

	;al >= 'a'  and al <= 'z' 
	cmp dl , 'a'
	jb letterc_loop_continue
	cmp dl , 'z'
	ja letterc_loop_continue

	and byte ptr ds:[si] , 11011111b
letterc_loop_continue:	 
	
	inc si
	jmp  letterc_loop 

	

letterc_ret:
	
	pop di 
	pop si
	pop dx 
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
	
	mov dl , ds:[si] 
	cmp dl , 0  
	je showStrRet
	
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