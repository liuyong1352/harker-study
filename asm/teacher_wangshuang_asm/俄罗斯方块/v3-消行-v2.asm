assume cs:code ,ds:data , ss:stack

data segment
			              
SCREEN_LOCATION dw 160*3
	   				  ;0123456789ABCDEF
SCREEN      db 18 dup('1000000000000001') 
		    db        '1111111111111111' 
SCREEN_ROW 		dw 19
SCREEN_COL 		dw 16
SCREEN_BOTTOM_Y dw 160*21 
IS_FIRST        dw 1 

NEXT_ROW   		dw 160
CUT_COL     	dw 14

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

IS_ALLOW_MOVE    dw 1
BLOCK_HIGH       dw 4000

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
next_block:
	call init_block_loction
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

	mov BLOCK_HIGH , 4000

	ret

;===============================
init_block_loction:

	mov bx ,offset BLOCK_SQUARE  
	mov si ,bx 
	mov bx ,BLOCK_LOCATION

	mov IS_ALLOW_MOVE , 1 

	ret 
;===============================
draw_block_with_color:
	mov ax , 3302H
	call draw_block_inner
	ret
;===============================
draw_block:
	mov ax , 2201H
	call draw_block_inner
	ret
;===============================
draw_block_inner:
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
	mov es:[bx] , ax 
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
	cmp byte ptr es:[bx] , 1
	jne clearBlockCol_next
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
;===============================
new_int9:
	push ax 
	call clear_buf
	in al , 60H
	pushf 
	call dword ptr cs:[200H] 

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
	iret ; pop ax  popf pop cs pop ip 

;==========================
isDown:
	call onMoveDown
	cmp IS_ALLOW_MOVE  , 1
	je isDownRet
	pop ax
	popf 
	add sp , 4
	;pop ax  popf pop cs pop ip 模拟中断返回
    jmp next_block ;  
isDownRet:
	jmp newInt9Ret

;==========================
isRight:

	mov al , 0 
	call isCanMoveRight
	cmp al , 0 
	je newInt9Ret

	call clear_old_block
	add  bx , 2
	call draw_block
	jmp newInt9Ret

moveRightInBlock:


isCanMoveRight:
	
	push bx 
	push cx 

	add bx , BLOCK_COL
	add bx , BLOCK_COL
	sub bx , 2
	
	mov cx , BLOCK_ROW
moveRightRow:
	
	push cx 
	push bx 
	mov cx ,BLOCK_COL
moveRightCOL:
	cmp byte ptr es:[bx ] , 1
	jne  moveRightCOL_next
	cmp byte ptr es:[bx + 2] , '0'
	jne canNotMoveRightRet
	jmp moveRightNextRow
moveRightCOL_next:
	sub bx , 2
	loop moveRightCOL
	
moveRightNextRow:
	pop bx 
	pop cx 
	add bx , NEXT_ROW
	loop moveRightRow
	mov al , 1 
	jmp isCanMoveRightRet

canNotMoveRightRet:
	mov al , 0
	add sp , 4	

isCanMoveRightRet:
	pop cx 
	pop bx 
	ret
;==========================

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
onMoveDown:
	call canMoveDown
	cmp al , 1
	jne onMoveToBottom 
	jmp onMoveDownRet
onMoveToBottom:
	call draw_block_with_color
	mov IS_ALLOW_MOVE , 0
	call set_BLOCK_HIGH
	call clear_rows
	ret 	
onMoveDownRet:
	call clear_old_block 
	add bx , NEXT_ROW 
	call draw_block	
	ret
;=============================
set_BLOCK_HIGH:
	call get_row
	cmp ax , BLOCK_HIGH 
	ja setBlockHighRet
	mov BLOCK_HIGH ,ax 
setBlockHighRet:
	ret

;=============================
get_row:	
	push bx
get_row_loop: 
	cmp byte ptr es:[bx] , '1'
	je  getRow
	sub bx , 2
	jmp get_row_loop
	;mov ax , BLOCK_HIGH
getRow:
	add bx ,2 
	;cmp bx , BLOCK_HIGH
	;jnb getRowRet
	mov ax , bx 
getRowRet:
	pop bx
	ret

;=============================
clear_rows:
	push bx
	push cx  
	call get_row
	mov bx , ax 
	;mov word ptr es:[bx] , 5535H 
	mov cx , BLOCK_ROW
clear_rows_loop:
	call isCanClearCurRow
	cmp al , 1
	jne clear_rows_next
	call clear_cur_row
	jne clear_rows_next
	call transfer_down
	;call redrawn
clear_rows_next:
	add bx , NEXT_ROW
	loop clear_rows_loop
	
clear_rows_ret:
	pop cx 
	pop bx 
	ret
;=============================
isCanClearCurRow:
	push bx
	push cx 
	xor al  , al 
	mov cx ,CUT_COL
isCanClearCurRowNext:
	cmp byte ptr es:[bx] , 2
	jne isCanClearCurRowret
	add bx , 2
	loop isCanClearCurRowNext
	inc al
isCanClearCurRowret:
	pop cx  
	pop bx 
	ret
;=============================
clear_cur_row:
	push bx
clear_cur_row_next_col:
	cmp byte ptr es:[bx] , '1'
	je clear_cur_row_ret
	mov word ptr es:[bx] , 0030H
	add bx , 2
	jmp clear_cur_row_next_col
clear_cur_row_ret: 
	pop bx 
	ret
;==================================
transfer_down:
	
	push cx 
	push bx 
	call get_row_num 
	mov cx , ax
transfer_down_loop: 
	call redrawn 
	sub bx , NEXT_ROW
	loop transfer_down_loop
	call clear_top_row
	pop bx 
	pop cx  
	ret
;==================================
clear_top_row:
	push bx
	mov bx , BLOCK_HIGH 
	call clear_cur_row
	add bx , NEXT_ROW
	mov BLOCK_HIGH , bx
	pop bx  
	ret
;==================================
get_row_num:
	push dx
	push bx
	mov dx , 0  
	mov ax , bx  
	mov bx , BLOCK_HIGH 
	sub ax , bx
	mov bx , NEXT_ROW 
	div bx
	pop bx 
	pop dx  
	ret
;==================================
redrawn: 


	cmp bx , SCREEN_BOTTOM_Y
	ja redrawnRet

	push ax  
	push bx
	push cx
	push ds 
	push si
	push di 

	mov ax , NEXT_ROW  ;relate ds
	mov cx , CUT_COL   ;relate ds
	mov di , bx 
	sub bx , ax 
	mov si , bx 

	mov bx , es 
	mov ds , bx 
	
	cld 
	rep movsw

	pop di
	pop si
	pop ds
	pop cx 
	pop bx
	pop ax 
	 
redrawnRet:
	push di 
	mov di , SCREEN_BOTTOM_Y 
	mov  word ptr es:[di + 17*2 ] , 2201H
	mov di , BLOCK_HIGH
	mov  word ptr es:[di + 17*2 ] , 2201H 
	pop di
	ret
;=============================
canMoveDown:
	push bx
	push cx 

	add bx , NEXT_ROW
	add bx , NEXT_ROW
	add bx , NEXT_ROW

	mov cx , BLOCK_COL  
down_next_col:
	push cx 
	push bx
	mov cx , BLOCK_ROW
down_next_row:
	cmp byte ptr es:[bx] , 1
	jne down_next_row_continue
	cmp byte ptr es:[bx + 160] ,'0'
	je  down_next_col_continue
	cmp byte ptr es:[bx - 160] ,'0'
	jne canNotMoveDown
	jmp down_next_col_continue
down_next_row_continue:
	sub bx , NEXT_ROW
	loop down_next_row 

down_next_col_continue:

	pop bx 
	pop cx 
	add bx , 2
	loop down_next_col
	mov al , 1
	jmp canMoveDownRET

canNotMoveDown:
	add sp , 4
	mov al , 0 	
	
canMoveDownRET:
	pop cx  
	pop bx 
	ret
;==========================================
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