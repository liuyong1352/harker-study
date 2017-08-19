
;%define	_BOOT_DEBUG_	; 做 Boot Sector 时一定将此行注释掉!将此行打开后用 nasm Boot.asm -o Boot.com 做成一个.COM文件易于调试

%ifdef	_BOOT_DEBUG_
	org  0100h			; 调试状态, 做成 .COM 文件, 可调试
%else
	org  07c00h			; Boot 状态, Bios 将把 Boot Sector 加载到 0:7C00 处并开始执行
%endif
;======================================================================
BaseOfStack			equ	07c00h	; 堆栈基地址(栈底, 从这个位置向低地址生长)
BaseOfLoader		equ	09000h	; LOADER.BIN 被加载到的位置 ----  段地址
OffsetOfLoader 		equ 0100h	; LOADER.BIN 被加载带的位置 ----  偏移地址
RootDirSectors		equ 14 		; 根目录占用空间
SectorNoOfRootDirectory	equ	19	; Root Directory 的第一个扇区号
DeltaSectorNo		equ	17	; DeltaSectorNo = BPB_RsvdSecCnt + (BPB_NumFATs * FATSz) - 2
					; 文件的开始Sector号 = DirEntry中的开始Sector号 + 根目录占用Sector数目 + DeltaSectorNo
;======================================================================
	jmp short LABEL_START		; Start to boot.
	nop				; 这个 nop 不可少

	; 下面是 FAT12 磁盘的头
	BS_OEMName	DB 'ForrestY'	; OEM String, 必须 8 个字节
	BPB_BytsPerSec	DW 512		; 每扇区字节数
	BPB_SecPerClus	DB 1		; 每簇多少扇区
	BPB_RsvdSecCnt	DW 1		; Boot 记录占用多少扇区
	BPB_NumFATs	DB 2		; 共有多少 FAT 表
	BPB_RootEntCnt	DW 224		; 根目录文件数最大值
	BPB_TotSec16	DW 2880		; 逻辑扇区总数
	BPB_Media	DB 0xF0		; 媒体描述符
	BPB_FATSz16	DW 9		; 每FAT扇区数
	BPB_SecPerTrk	DW 18		; 每磁道扇区数
	BPB_NumHeads	DW 2		; 磁头数(面数)
	BPB_HiddSec	DD 0		; 隐藏扇区数
	BPB_TotSec32	DD 0		; wTotalSectorCount为0时这个值记录扇区数
	BS_DrvNum	DB 0		; 中断 13 的驱动器号
	BS_Reserved1	DB 0		; 未使用
	BS_BootSig	DB 29h		; 扩展引导标记 (29h)
	BS_VolID	DD 0		; 卷序列号
	BS_VolLab	DB 'OrangeS0.02'; 卷标, 必须 11 个字节
	BS_FileSysType	DB 'FAT12   '	; 文件系统类型, 必须 8个字节  

LABEL_START:
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	mov ss, ax 
	mov sp , BaseOfStack

	;clear screen
	mov ax  , 0600h
	mov bx  , 0700h
	mov cx , 0
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
LABEL_FILE_LOADED:
	jmp BaseOfLoader:OffsetOfLoader

;==================================
;变量
wRootDirSizeForLoop dw RootDirSectors ; Root Directory 占用的扇区数
	;在循环中 递减至零
wSectorNo		dw 0 ; 要读取的扇区号
LoaderFileName  db "LOADER  BIN",0 ;LOADER.BIN 之文件名

MessageLength		equ 9 
BootMessage:		db	"Booting " ; 9字节，不够则用空格补齐. 序号0
Message1:			db  " "
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

times 	510-($-$$)	db	0	; 填充剩下的空间，使生成的二进制代码恰好为512字节
dw 	0xaa55				; 结束标志
