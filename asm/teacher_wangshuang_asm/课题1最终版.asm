assume cs:code ,ds:data , ss:stack

data segment
	   ;0123456789ABCDEF
	db '1975' , '1976' , '1977' , '1978', '1979'
    db '1980', '1981', '1982', '1983', '1984', '1985', '1986', '1987', '1988', '1989'
    db '1990', '1991', '1992', '1993', '1994', '1995'
    ;以上是表示21年的21个字符串
    dd 16 , 22, 382 ,1356,2390,8000,16000 ,24486 ,50065 ,97479 ,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ;以上是表示21年公司总收入的21个dword型数据
    dw 3,7,9,13,28,38,130,220,476 , 778 ,1001, 1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800 

	;以上是21年公司催员人数的21个word型数据
data ends 

table segment
			  ;0123456789ABCDEF
	db 21 dup('year summ ne ?? ')
table ends 

string segment
	db 10 dup('0')  
string ends 

stack segment
	db 128 dup (0)
stack ends

code segment

start:
	
	mov ax ,stack
	mov ss, ax 
	mov sp , 128
	
	call clear_screen
	call input_table
	call output_table

	mov ax ,4c00h
	int 21h

;========================================================
output_table:
	
	call show_year
	call show_summ
	call show_ne
	call show_avr

	ret 

;========================================================
show_avr:
	
	push ax 
	push bx 
	push cx 
	push dx 
	push ds
	push es
	push si 
	push di 

	mov ax , table
	mov es , ax 
	mov di , 13

	mov cx , 21
	mov bl , 2 
show_avr_loop:

	mov ax , string 
	mov ds , ax 
	mov si , 0

	mov ax , es:[di]
	;mov dx , es:[di + 2] 
	mov dx , 0 
	 
	call dtoc

	call reverse_str

	
	mov dh ,bl
	call show_avr_inter
	add di , 16
	inc bl
	loop show_avr_loop

	pop di 
	pop si
	pop es
	pop ds
	pop dx  
	pop cx
	pop bx  
	pop ax 

	ret

show_avr_inter:
	push dx
	push cx 
	push ax  
	push ds 
	push si 

	mov dl , 10+5+7 + 7
	mov cl ,  4
	mov ax , string
	mov ds , ax 
	mov si , 0 
	call show_str

	pop si 
	pop ds 
	pop ax 
	pop cx 
	pop dx 
	ret

;========================================================
show_ne:
	
	push ax 
	push bx 
	push cx 
	push dx 
	push ds
	push es
	push si 
	push di 

	mov ax , table
	mov es , ax 
	mov di , 10

	mov cx , 21
	mov bl , 2 
show_ne_loop:

	mov ax , string 
	mov ds , ax 
	mov si , 0

	mov ax , es:[di]
	;mov dx , es:[di + 2] 
	mov dx , 0 
	 
	call dtoc

	call reverse_str

	
	mov dh ,bl
	call show_ne_inter
	add di , 16
	inc bl
	loop show_ne_loop

	pop di 
	pop si
	pop es
	pop ds
	pop dx  
	pop cx
	pop bx  
	pop ax 

	ret

show_ne_inter:
	push dx
	push cx 
	push ax  
	push ds 
	push si 

	mov dl , 10+5+7
	mov cl ,  4
	mov ax , string
	mov ds , ax 
	mov si , 0 
	call show_str

	pop si 
	pop ds 
	pop ax 
	pop cx 
	pop dx 
	ret




;========================================================
show_summ:
	
	push ax 
	push bx 
	push cx 
	push dx 
	push ds
	push es
	push si 
	push di 

	mov ax , table
	mov es , ax 
	mov di , 5

	mov cx , 14
	mov bl , 2 
show_summ_loop:

	mov ax , string 
	mov ds , ax 
	mov si , 0

	mov ax , es:[di]
	mov dx , es:[di + 2] 
	 
	call dtoc

	call reverse_str

	
	mov dh ,bl
	call show_summ_inter
	add di , 16
	inc bl
	loop show_summ_loop

	pop di 
	pop si
	pop es
	pop ds
	pop dx  
	pop cx
	pop bx  
	pop ax 

	ret

show_summ_inter:
	push dx
	push cx 
	push ax  
	push ds 
	push si 

	mov dl , 10+5
	mov cl ,  4
	mov ax , string
	mov ds , ax 
	mov si , 0 
	call show_str

	pop si 
	pop ds 
	pop ax 
	pop cx 
	pop dx 
	ret

;========================================================
;ds:si 指向字符串
reverse_str:
	
	push cx 
	push ds 
	push si
	push di 

	mov di , 0 
reverse_str_loop:
	mov cx , 0 
	mov cl , ds:[si]
	jcxz reverse_str_pop  
	push cx 
	inc si
	inc di 
	jmp reverse_str_loop

reverse_str_pop:
	mov cx , di
	sub si , di 
reverse_str_pop_loop:
	pop ax 
	mov ds:[si] , al 
	inc si 
	loop reverse_str_pop_loop	
	
	pop di 
	pop si
	pop ds
	pop cx 
	ret

;========================================================
show_sum:
	
	push ax 
	push cx 
	push dx 
	push es
	push di 


	mov ax , table
	mov ds , ax 
	mov si , 5

	mov ax , string
	mov es , ax 
	mov di , 9 

	mov ax , ds:[si]
	mov dx , ds:[si + 2]

	call calNumber

	
	mov dh , 2
	mov dl , 15
	mov cl , 2
	mov ax , string
	mov ds,ax
	mov si, 0 
	call show_str
	

	pop di 
	pop es
	pop dx  
	pop cx 
	pop ax 

	ret 

;========================================================
calNumber:
	
	mov cx , dx
	jcxz _shortDiv 

_shortDiv:
	call shortDiv

	ret



shortDiv:
	mov bx , 10
	div bx 

	mov cx , ax
	jcxz shortDivRet
	add dl , 30
	mov es:[di] , dl
	mov dx , 0 
	dec di

shortDivRet:
	
	add al , 30
	mov es:[di] , al

	ret 

;========================================================
show_year:
	
	push ax 
	push cx 
	push ds 
	push es
	push si
	push di 

	mov ax ,data
	mov ds , ax 
	mov si , 0  

	mov ax , 0B800H
	mov es , ax 
	mov di , 160*2 + 10*2 

	mov cx , 21
l1:
	push cx 
	push di 
	mov cx , 4

l0:	mov al , ds:[si]
	mov ah , 04h
	mov es:[di] , ax

	inc si 
	add di , 2 
	loop l0
	
	pop di 
	pop cx 

	add di , 160  
	loop l1

	pop di
	pop si
	pop es
	pop ds
	pop cx 
	pop ax 
	ret 

;========================================================
input_table:
	
	push ax
	push bx 
	push cx 
	push dx  
	push ds 
	push es
	push si 
	push di 

	mov cx , 21

	;data from 
	mov ax , data
	mov ds , ax 
	mov si , 0 

	mov ax , table 
	mov es , ax 
	mov di , 0 

input_table_loop:	
	
    ;year
	mov ax , ds:[si]
	mov es:[di] , ax 
	mov ax , ds:[si + 2]
	mov es:[di + 2] , ax

	;income 
	mov ax , ds:[si+ 84]
	mov es:[di + 5] ,ax 
	 
	mov dx , ds:[si + 86] 
	mov es:[di + 7] ,dx

	;number
	push ds:[bx + 168]
	pop  es:[di + 10]

	div word ptr ds:[bx + 168]

	mov es:[di + 13] , ax

	add si , 4
	add bx , 2
	add di , 16

	loop input_table_loop

	pop di
	pop si 
	pop es
	pop ds
	pop dx  
	pop cx
	pop bx 
	pop ax
	ret


;========================================================
;ax = 低位   dx = 高位 ds:si指向字符串的首地址
;返回值，si 
dtoc:
	push ax 
	push bx 
	push cx 
	push dx 
	push si
 	
 	mov bx , 10
 	
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