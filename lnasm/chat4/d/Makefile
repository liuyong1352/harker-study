##############################################
# xxd -l 512 x.img 显示头512个字节
# 查看root dir  19 × 512 = 0x2600 
# xxd -u -a -g 1 -c 16 -s +0x2600 -l 512 x.img
# 查看数据区 （19 + 14 ） × 512 = 0x 4400 
# xxd -u -a -g 1 -c 16 -s +0x4400 -l 0x11 x.img
# xxd -u -a -g 1 -c 16 -s +0x200 -l 512 x.img  查看Fat1表
#############################################

#############################################
default:
	@make clean
	@make mkdosfs
	@make run
init:
	@mkdir mnt
	@nasm boot.asm -o boot.bin
	@nasm loader.asm -o loader.bin
mkdosfs: init 
	@dd if=/dev/zero of=x.img bs=512 count=2880
#	@mkdosfs x.img
	@dd if=boot.bin  of=x.img bs=512 count=1 conv=notrunc
	@mount -o loop x.img mnt
	@cp *.txt mnt
	@cp loader.bin mnt 
	@umount mnt
header:
	@xxd -l 512 x.img
clean:
	@rm -rf *.bin  *.img mnt 
run: x.img
	qemu-system-i386 -vga std -display sdl  -m 32M -drive file=x.img,format=raw,index=0,if=floppy
