assume cs:code  , ss:stack

stack segment
	db 16 dup (0)
stack ends

code segment

time_style: db 'yy/mm/dd HH:MM:SS', 0
time_cmos : db 9 , 8 , 7 , 4 , 2 ,0 
	
start:
	mov ax , stack
	mov ss , ax 
	mov sp , 16

	call show_clock
	;call clear_screen

testA:
	mov al , 0
	mov dh , 10
	mov dl , 20
	call get_time

	mov al ,2
	add dl , 3 
	call get_time 

	mov al ,4
	add dl , 3 
	call get_time 

	mov al ,7
	add dl , 3 
	call get_time

	mov al ,8
	add dl , 3 
	call get_time

	mov al ,9
	add dl , 3 
	call get_time    

	jmp testA

	mov ax, 4c00H
	int 21H


;=======================show_clock
show_clock:

	mov ax , cs 
	mov ds , ax 
	mov si , offset time_style 


testB:
	call show_time_style
	call get_date
	jmp testB

	ret

get_date:
	push ax 
	push cx
	push ds  
	push si
	push di
	
	mov di , 0
	mov si , offset time_cmos 
	mov cx , 6
get_date_loop:
	mov al , ds:[si]
	out 70h , al
	in al , 71h

	mov ah , al 
	shr ah , 1
	shr ah , 1
	shr ah , 1
	shr ah , 1

	and al , 00001111b

	add ah , 30H
	add al , 30H

	mov byte ptr ds:[di] , ah 
	mov byte ptr ds:[di+1] , al
	add di , 3 
	inc si 
	loop get_date_loop
	pop di 
	pop si 
	pop ds 
	pop cx 
	pop ax 
	ret

;=======================show_time_style
;ds:si 指向首地址
show_time_style:
	push ax 
	push dx 
	push si 
	push di 

	mov ax , 0B800H
	mov es , ax 
	mov di , 160*12+30*2 
show_time_style_loop:
	mov dl , ds:[si]
	cmp dl , 0 
	je  showTimeStyleRet
	mov byte ptr es:[di]  , dl
	add di , 2 
	inc si 
	jmp show_time_style_loop

showTimeStyleRet:
	pop di 
	pop si 
	pop dx 
	pop ax 
	ret

;=======================get_time
;al , 对应的端口
;显示的行号dh , dl 列号

get_time:
		push ax 
		push cx
		push bx 
		push dx 
		push es
		push di 
		
		;单元信息 秒:0 分:2 时:4 日:7 月:8 年:9
		out 70h , al
		in al , 71h

		;BCD 码 0    1    2    3    4    5    6    7    8    9
		;       0000 0001 0010 0011 0100 0101 0110 0111 1000 1001
		mov ah , al 
		mov cl , 4
		shr ah , cl 

		and al , 00001111b

		add ah , 30H
		add al , 30H
		mov bx , 0B800h
		mov es , bx 

		;160*4  + 160*8
		mov di , 0 
		call get_row
		call get_col

		mov byte ptr es:[di] ,ah 
		mov byte ptr es:[di+2] , al
		pop di
		pop es 
		pop dx
		pop bx		
		pop cx 
		pop ax 
		ret
get_row:
	push ax 
	mov al , 160
	mul dh 
	mov di ,ax 
	pop ax 
	ret

get_col:
	push ax 
	mov al , 2
	mul dl 
	add di ,ax 
	pop ax 
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