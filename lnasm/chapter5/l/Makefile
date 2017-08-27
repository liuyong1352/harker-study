##################################################
# Makefile
##################################################
BOOT:=boot.asm
LDR:=loader.asm
KERNEL:=kernel.asm
BOOT_BIN:=$(subst .asm,.bin ,$(BOOT))
LDR_BIN:=$(subst .asm,.bin,$(LDR))
KERNEL_BIN:=$(subst .asm,.bin,$(KERNEL))

IMG:=x.img
FLOPPY:=mnt

.PHONY : everything

everything : $(BOOT_BIN) $(LDR_BIN) $(KERNEL_BIN) 
	@rm -rf $(FLOPPY) $(IMG)
	@mkdir $(FLOPPY)
	make img
	@mount -o loop $(IMG) $(FLOPPY)
	@cp $(LDR_BIN) $(FLOPPY) -v
	@cp $(KERNEL_BIN) $(FLOPPY) -v
	@umount $(FLOPPY)

img:
	@dd if=/dev/zero of=$(IMG) bs=512 count=2880
	@dd if=$(BOOT_BIN)  of=$(IMG) bs=512 count=1 conv=notrunc

$(BOOT_BIN) : $(BOOT)
	nasm $< -o $@

$(LDR_BIN) : $(LDR)
	nasm $< -o $@
$(KERNEL_BIN) : $(KERNEL)
	nasm -f elf -o $(subst .asm,.o,$(KERNEL)) $<
	nasm -f elf -o klib.o klib.asm
	gcc -m32 -c -fno-builtin -o start.o start.c
	nasm -f elf -o string.o string.asm
	ld -melf_i386 -Ttext 0x30400  -s -o $@ $(subst .asm,.o, $(KERNEL)) klib.o start.o string.o
clean:
	@rm -rf *.bin *.o $(FLOPPY) $(IMG) 
run: everything 
	qemu-system-i386 -vga std -display sdl  -m 32M -drive file=x.img,format=raw,index=0,if=floppy
