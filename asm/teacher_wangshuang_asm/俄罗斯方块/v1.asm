assume cs:code ,ds:data , ss:stack

data segment
			              
SCREEN_LOCATION dw 160*3
	   				  ;0123456789ABCDEF
SCREEN      db 18 dup('1000000000000001') 
		    db        '1111111111111111' 
SCREEN_ROW 	dw 19
SCREEN_COL 	dw 16

NEXT_ROW   	dw 160


BLOCK_SQUARE 	db '1100'
				db '1100'
				db '0000'
				db '0000'

BLOCK_ROW 		dw 4
BLOCK_COL   	dw 4
BLOCK_LOCATION 	dw 160*3 + 7*2

BLOCK_DISPLAY   dw 2201H

BLOCK_X         dw 0 
BLOCK_Y         dw 0

data ends

stack segment
	db 128 dup (0)
stack ends


code segment

start:
	
	mov ax , stack
	mov ss , ax 
	mov sp , 128
	

	call cpy_Tetris
	call save_old_int9
	call set_new_int9

	mov bx ,0
	push bx 
	mov bx , 07E00H
	push bx 
	retf

	mov ax , 4c00h
	int 21h

Tetris:	
	call init_reg
	call clear_screen
	call init_screen
	call init_block_loction
	mov ax , BLOCK_DISPLAY
	call draw_block

TestA:
	mov ax , 1000H
	jmp TestA

	mov ax , 4c00h
	int 21h	
;===============================
init_reg:
	mov bx , data
	mov ds , bx

	mov bx , 0b800h
	mov es , bx 
	ret

;===============================
init_block_loction:

	mov bx ,offset BLOCK_SQUARE  
	mov si ,bx 
	mov bx ,BLOCK_LOCATION

	ret 

;===============================
draw_block:
	
	push bx
	push cx  
	push dx 
	push si 
	
	mov cx , BLOCK_ROW
	
drawBlock0:
	push cx 
	push bx 
	mov cx , BLOCK_COL
drawBlock:
	mov dx , 0 
	mov dl , ds:[si]
	cmp dl , '1' 
	jne drawBlock_next
	mov es:[bx] , 2201H 
drawBlock_next:	
	add bx , 2
	inc si
	loop drawBlock
	pop bx 
	add bx , NEXT_ROW
	pop cx
	loop  drawBlock0

	pop si 
	pop dx 
	pop cx 
	pop bx
	
	ret
;===============================
clear_old_block:
	push cx 
	push bx 
	mov cx , BLOCK_ROW
clearBlockROW:
	push cx 
	push bx 
	mov cx , BLOCK_COL 
clearBlockCol:
	cmp byte ptr es:[bx] , '0'
	je clearBlockCol_next
	mov word ptr es:[bx] , 0030H
clearBlockCol_next:
	add bx , 2	
	loop clearBlockCol
	pop bx
	pop cx 
	add bx , NEXT_ROW

	loop clearBlockROW

	pop bx 
	pop cx 
	ret
;===============================
init_screen:
	push ax 
	push cx 
	push dx 
	push si
	push di 

	mov si , offset SCREEN 

	mov di , SCREEN_LOCATION
	mov cx , SCREEN_ROW
draw_screen:
	push cx 
	push di
	mov cx  , SCREEN_COL
	 
draw_screen_inter_loop:
	mov dx , 0 
	mov dl , ds:[si]
	cmp dl , '1'
	jne draw_screen_next
	or dh , 00010001B
draw_screen_next:
	mov es:[di] , dx 
	add di, 2
	inc si 
	loop draw_screen_inter_loop
	pop di 
	pop cx
	add di , NEXT_ROW 
	loop draw_screen

	pop di
	pop si 
	pop dx
	pop cx
	pop ax 

	ret
;===============================
clear_screen:
	
	mov cx , 2000
	mov bx , 0
	mov dx , 0700H
clear_screen_loop:
	mov es:[bx] , dx
	add bx , 2
	loop clear_screen_loop
	ret
new_int9:
	push ax 
	call clear_buf
	in al , 60H
	pushf 
	call dword ptr cs:[200H] 

	cmp al ,48H
	je  isUp

	cmp al ,50H
	je  isDown
	cmp al ,4BH
	je  isLeft

	cmp al ,4DH
	je  isRight

	cmp al , 3BH  
	jne newInt9Ret

	mov ah , 0
	int 16h

	
	call change_color

newInt9Ret:
	pop ax
	iret

;==========================
isUp:
	mov byte ptr es:[160*2 + 20*2] , 'U'
	jmp newInt9Ret

;==========================
isDown:
	
	add bx , NEXT_ROW 
	;call clear_old_block
	mov byte ptr es:[160*4 + 20*2] , 'D'
	call draw_block
	
	jmp newInt9Ret
;==========================
isLeft:
	push cx 
	mov cx , BLOCK_ROW
	push bx 
moveLeft:
	
	cmp byte ptr es:[bx] , 1
	jne mNextRow
	cmp byte ptr es:[bx - 2 ] , '0'
	jne notMoveLeft
mNextRow:	
	add  bx , NEXT_ROW
	loop moveLeft

	pop bx
	call clear_old_block
	sub  bx , 2
	call draw_block
	jmp mLeftRet
notMoveLeft:
	add sp , 2

mLeftRet:	
	pop cx 
	jmp newInt9Ret
;==========================
isRight:
	mov byte ptr es:[160*3 + 21*2] , 'R'
	jmp newInt9Ret
;==========================
change_color:
	push bx 
	push cx 
	
	mov bx , 1
	mov cx , 2000
change_color_loop:
	
	inc byte ptr es:[bx] 
	add bx , 2
	loop  change_color_loop
	
	pop cx
	pop bx 
	ret
;==========================
clear_buf:
	mov ah , 1
	int 16H
	jz clearBufRet
	mov ah , 0
	int 16H
	jmp clear_buf
clearBufRet:
	ret

Tetris_end:	nop 
;==========================
save_old_int9:
	mov bx ,0
	mov es , bx
	mov di , 200H

	push es:[9*4] 
	pop es:[di+0]
	push es:[9*4 + 2]
	pop es:[di + 2]
 
	ret
set_new_int9:
	mov bx , 0 
	mov es , bx 

	cli 
	mov word ptr es:[9*4] ,OFFSET new_int9 - OFFSET Tetris +  7E00H;ip
	mov word ptr es:[9*4 + 2] , 0
	sti 

	ret
;==========================
cpy_Tetris:
	push bx 
	push cx
	push ds 
	push es
	push si 
	push di

	mov bx , cs 
	mov ds , bx 
	mov si , OFFSET Tetris 

	mov bx , 0
	mov es , bx
	mov di , 7E00H 

	mov cx , OFFSET Tetris_end - OFFSET Tetris
	cld
	rep movsb

	pop di
	pop si
	pop es
	pop ds
	pop cx
	pop bx
	ret


code ends 

end start