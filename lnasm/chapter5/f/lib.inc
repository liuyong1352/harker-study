; ------------------------------------------------------------------------
; 显示一个字符串
; void DispStr(char* s) ; 
; ------------------------------------------------------------------------
DispStr:
	push ebp 
	mov  ebp , esp 
	push	ebx
	push	esi
	push	edi
	
	mov esi , [ebp + 8]  ; pszInfo  s指针的值
	mov edi , [dwDispPos] 
	mov ah  , 0Fh
.1:
	lodsb 
	test al , al 
	jz .2
	cmp	al, 0Ah	; 是回车吗?
	jnz .3
	push eax
	;(位置/160 + 1 ) * 160
	mov eax , edi 
	mov bl , 160
	div bl 
	and eax , 0FFh
	inc eax 
	mov bl , 160
	mul bl 
	mov edi , eax 
	pop eax 
	jmp .1
	
.3:
	mov [gs:edi] , ax 
	add edi , 2 
	jmp .1 
.2:
	mov [dwDispPos] , edi 
	pop edi 
	pop esi 
	pop ebx 

	pop ebp 
	ret 
