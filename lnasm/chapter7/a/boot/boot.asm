org  07c00h			; Boot 状态, Bios 将把 Boot Sector 加载到 0:7C00 处并开始执行
;======================================================================
BaseOfStack			equ	07c00h	; 堆栈基地址(栈底, 从这个位置向低地址生长)
;======================================================================
%include "load.inc"
	jmp short LABEL_START		; Start to boot.
	nop				; 这个 nop 不可少
%include "fat12hdr.inc"

LABEL_START:
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov ss, ax 
	mov sp , BaseOfStack

	;clear screen
	mov ax  , 0600h ;AH=6 ,AL=0h
	mov bx  , 0700h ; 黑底白字（bl =07H)
	mov cx , 0		; 左上角：（0,0）
	mov dx , 0184fh
	int 10h	

	mov dh , 0 
	call DispStr  
;==================================
;软驱复位
	xor ah , ah 
	xor dl , dl  
	int 13h 	
;下面在A盘的根目录寻找 LOADER.BIN
	mov word [wSectorNo] , SectorNoOfRootDirectory
LABEL_SEARCH_IN_ROOT_DIR_BEGIN:
	cmp word [wRootDirSizeForLoop] , 0 
	jz LABEL_NO_LOADERBIN
	dec word [wRootDirSizeForLoop] 
	mov ax , BaseOfLoader 
	mov es , ax				;es <- BaseOfLoader
	mov bx , OffsetOfLoader ;bx <- OffsetOfLoader 
	; es:bx => 09000:0100  90100H
	mov ax , [wSectorNo]
	mov cl , 1 
	call ReadSector
	
	mov si , LoaderFileName  ; ds:si -> "LOADER   BIN"
	mov di , OffsetOfLoader  ; es:di -> es:bx -> BaseOfLoader:0100
	cld
	mov dx , 10h  ;一个扇区 512 一个dir root 占 32 ， 512/32 => 10h                      
LABEL_SEARCH_FOR_LOADERBIN:
	cmp dx , 0  ; 循环次数的控制
	jz LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR ;循环结束 没找到
	dec dx 
	mov cx , 11 ;文件名称11个字节
LABEL_CMP_FILENAME:
	cmp cx , 0 
	jz LABEL_FILENAME_FOUND 	;如果比较了11个字节都相等 ， 表示找到
	dec cx 
	lodsb			;ds:si -> al 并且 si自动加1
	cmp al , byte [es:di] 
	jz LABEL_GO_ON
	jmp LABEL_DIFFERENT ;只要发现不一样的字符表明本 DirectoryEntry 
						;不是我们要找的 LOADER.BIN	

LABEL_GO_ON:
	inc di 
	jmp LABEL_CMP_FILENAME ;继续循环判断下一个字符
	
LABEL_DIFFERENT:  ;next dir entry
	and di , 0FFE0H 	; di & FFEO 为了让它指向本条目的开头
	add di , 20h 		; 一个条目32字节 di+=20h 循环下一个目录条目
	mov si , LoaderFileName 
	jmp LABEL_SEARCH_FOR_LOADERBIN
LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR:
	add word [wSectorNo] , 1 
	jmp LABEL_SEARCH_IN_ROOT_DIR_BEGIN
LABEL_NO_LOADERBIN:
	mov dh , 2
	call DispStr
	jmp $
LABEL_FILENAME_FOUND:
	mov ax , RootDirSectors 
	and di , 0FFE0H ; di -> 当前条目的开始
	add di , 01AH   ; di -> 首 Sector
	mov cx , word [es:di]  ; 
	push cx		; save sector the number in fat  
	add cx , ax 
	add cx , DeltaSectorNo
	mov ax , BaseOfLoader
	mov es , ax 
	mov bx , OffsetOfLoader
	mov ax , cx 
LABEL_GOON_LOADING_FILE:
	push ax 
	push bx 
	mov ah ,0Eh 
	mov al , '.'
	mov bl , 0Fh
	int 10h
	pop bx 
	pop ax 
	
	mov cl , 1
	call ReadSector	  
	pop	ax			; 取出此 Sector 在 FAT 中的序号
	call GetFATEntry
	cmp ax ,0FFFh
	jz LABEL_FILE_LOADED
	push ax 
	mov dx , RootDirSectors
	add ax , dx 
	add ax , DeltaSectorNo
	add bx , [BPB_BytsPerSec]
	jmp LABEL_GOON_LOADING_FILE 
LABEL_FILE_LOADED:
	mov dh , 1 ; "Ready ."
	call DispStr ; 显示字符串
; *************************************************************************************************
	jmp	BaseOfLoader:OffsetOfLoader	; 这一句正式跳转到已加载到内存中的 LOADER.BIN 的开始处
						; 开始执行 LOADER.BIN 的代码
						; Boot Sector 的使命到此结束
; **************************************************************************************************

;==================================
;变量
;----------------------------------------------------------------------------
wRootDirSizeForLoop dw RootDirSectors ; Root Directory 占用的扇区数
	;在循环中 递减至零
wSectorNo		dw 0 ; 要读取的扇区号
bOdd			db 0 ;奇数还是偶数
;============================================================================
;字符串
;----------------------------------------------------------------------------
LoaderFileName  db "LOADER  BIN",0 ;LOADER.BIN 之文件名

MessageLength		equ 9 
BootMessage:		db	"Booting  " ; 9字节，不够则用空格补齐. 序号0
Message1:			db  "Ready.   "
Message2:			db  "No Loader" 
;==================================
; show a string , dh  is pointer
DispStr:
	mov ax , MessageLength
	mul dh 
	add ax , BootMessage
	mov bp , ax 
	mov ax , ds 
	mov es , ax 
	mov	cx, MessageLength	; CX = 串长度
	mov	ax, 01301h		; AH = 13,  AL = 01h
	mov	bx, 0007h		; 页号为0(BH = 0) 黑底红字(BL = 0Ch,高亮)
	mov	dl, 0
	int	10h			; int 10h
	ret

;========================================
; 函数名称：ReadSector
;----------------------------------------
; function:
; 	从第ax个Sector开始 ，将cl个sector 读入es:bx中
;========================================
ReadSector:
	; ---------------------------------------------------------------------
	; 怎样由扇区号求扇区在磁盘中的位置 (扇区号 -> 柱面号, 起始扇区, 磁头号)
	; -----------------------------------------------------------------------
	; 设扇区号为 x
	;                           ┌ 柱面号 = y >> 1
	;       x           ┌ 商 y ┤
	; -------------- => ┤      └ 磁头号 = y & 1
	;  每磁道扇区数     │
	;                   └ 余 z => 起始扇区号 = z + 1
	push bp 
	mov	bp ,sp 
	;提升堆栈
	sub sp ,2  ; 开辟两个字节的堆栈区保存要读的扇区数： byte [bp-2]
	
	mov byte [bp - 2] , cl 
	push bx ;save bx	
	mov bl , [BPB_SecPerTrk] ;bl:除数
	div bl 			; y 在al , z在ah中
	inc ah			; z++ 
	mov cl , ah     ; cl <- 起始扇区号
	mov dh , al		; dh <- y
	shr al , 1		; y>>1 (y/BPB_NumHeads)
	mov ch , al     ; ch <- 柱面号
	and dh , 1      ; dh & 1 = 磁头号
	pop bx 			;恢复bx
	; 至此, "柱面号, 起始扇区, 磁头号" 全部得到
	mov	dl, [BS_DrvNum]		; 驱动器号 (0 表示 A 盘)
.GoOnReading:
	mov ah , 2 ;读
	mov al , byte [bp - 2 ] ; 读 al 个扇区
	int 13h
	jc .GoOnReading 		; 如果读取错误 CF 会被置为 1,
	; 这时就不停地读, 直到正确为止
	;平衡堆栈
	add esp , 2
	pop bp 
	ret
;----------------------------------------------------------------------------
; 函数名: GetFATEntry
;----------------------------------------------------------------------------
; 作用:
;	找到序号为 ax 的 Sector 在 FAT 中的条目, 结果放在 ax 中
;	需要注意的是, 中间需要读 FAT 的扇区到 es:bx 处, 所以函数一开始保存了 es 和 bx
GetFATEntry:
	push	es
	push	bx
	push	ax
	mov	ax, BaseOfLoader	; ┓
	sub	ax, 0100h		; ┣ 在 BaseOfLoader 后面留出 4K 空间用于存放 FAT
	mov	es, ax			; ┛
	pop	ax
	mov	byte [bOdd], 0
	mov	bx, 3
	mul	bx			; dx:ax = ax * 3
	mov	bx, 2
	div	bx			; dx:ax / 2  ==>  ax <- 商, dx <- 余数
	cmp	dx, 0
	jz	LABEL_EVEN
	mov	byte [bOdd], 1
LABEL_EVEN:;偶数
	xor	dx, dx			; 现在 ax 中是 FATEntry 在 FAT 中的偏移量. 下面来计算 FATEntry 在哪个扇区中(FAT占用不止一个扇区)
	mov	bx, [BPB_BytsPerSec]
	div	bx			; dx:ax / BPB_BytsPerSec  ==>	ax <- 商   (FATEntry 所在的扇区相对于 FAT 来说的扇区号)
					;				dx <- 余数 (FATEntry 在扇区内的偏移)。
	push	dx
	mov	bx, 0			; bx <- 0	于是, es:bx = (BaseOfLoader - 100):00 = (BaseOfLoader - 100) * 10h
	add	ax, SectorNoOfFAT1	; 此句执行之后的 ax 就是 FATEntry 所在的扇区号
	mov	cl, 2
	call	ReadSector		; 读取 FATEntry 所在的扇区, 一次读两个, 避免在边界发生错误, 因为一个 FATEntry 可能跨越两个扇区
	pop	dx
	add	bx, dx
	mov	ax, [es:bx]
	cmp	byte [bOdd], 1
	jnz	LABEL_EVEN_2
	shr	ax, 4
LABEL_EVEN_2:
	and	ax, 0FFFh

LABEL_GET_FAT_ENRY_OK:

	pop	bx
	pop	es
	ret
;----------------------------------------------------------------------------
times 	510-($-$$)	db	0	; 填充剩下的空间，使生成的二进制代码恰好为512字节
dw 	0xaa55				; 结束标志
