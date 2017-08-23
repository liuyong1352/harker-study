org	0100h

jmp  LABEL_START

; 下面是 FAT12 磁盘的头, 之所以包含它是因为下面用到了磁盘的一些信息
%include	"fat12hdr.inc"
LABEL_START:

mov	ax, 0B800h
mov	gs, ax
mov	ah, 0Fh				; 0000: 黑底    1111: 白字
mov	al, 'L'
mov	[gs:((80 * 0 + 39) * 2)], ax	; 屏幕第 0 行, 第 39 列。

jmp	$				; 到此停住
times 	2048-($-$$)	db	0	; 填充剩下的空间，使生成的二进制代码恰好为512字节
