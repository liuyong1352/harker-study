
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
	
;==================================
;软驱复位
	xor ah , ah 
	xor dl , dl  
	int 13h 	
;==================================
	Call	DispStr			; 调用显示字符串例程
	jmp	$			; 无限循环
DispStr:
	mov	ax, BootMessage
	mov	bp, ax			; ES:BP = 串地址
	mov	cx, 16			; CX = 串长度
	mov	ax, 01301h		; AH = 13,  AL = 01h
	mov	bx, 000ch		; 页号为0(BH = 0) 黑底红字(BL = 0Ch,高亮)
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

BootMessage:		db	"Hello, OS world!"
times 	510-($-$$)	db	0	; 填充剩下的空间，使生成的二进制代码恰好为512字节
dw 	0xaa55				; 结束标志
