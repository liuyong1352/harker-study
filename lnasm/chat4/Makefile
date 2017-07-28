##################################################
#	Makefile 
##################################################
SRC:=boot.asm
BIN:=$(subst .asm,.bin,$(SRC))

default:
	@make run

$(BIN) : $(SRC)
	nasm $< -o $@

.PHONY : img

img:$(BIN)
	@dd if=/dev/zero of=a.img bs=512 count=2880
	@dd if=$(BIN) of=a.img bs=512 count=1 conv=notrunc
run: img
	#bochs -q -f bochsrc.bxrc
	qemu-system-i386 -vga std -display sdl  -m 32M -drive file=a.img,format=raw,index=0,if=floppy
clean:
	@rm  -rf *.img *.o *.bin *.com 
