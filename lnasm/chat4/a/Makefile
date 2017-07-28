##############################################
# xxd -l 512 x.img 显示头512个字节
# xxd -u -a -g 1 -c 16 -s +0x2600 -l 512 x.img
# xxd -u -a -g 1 -c 16 -s +0x4400 -l 0x11 x.img
# xxd -u -a -g 1 -c 16 -s +0x200 -l 512 x.img  查看Fat1表
#############################################
default:
	@make clean
	@make mkdosfs
init:
	@mkdir mnt
	@nasm boot.asm -o a.img
mkdosfs: init
	@dd if=/dev/zero of=x.img bs=512 count=2880
#	@mkdosfs x.img
	@dd if=a.img  of=x.img bs=512 count=1 conv=notrunc
	@mount -o loop x.img mnt
	@cp RIVER.TXT mnt 
	@cp FLOWER.TXT mnt
	@umount mnt
header:
	@xxd -l 512 x.img
clean:
	@rm -rf *.img mnt
help:
	@echo "=================================="
	@echo "make header "	
