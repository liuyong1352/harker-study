
##################################################
# Makefile
##################################################
# It must have the same value with 'KernelEntryPointPhyAddr' in load.inc!
ENTRYPOINT	= 0x30400

# Offset of entry point in kernel file
# It depends on ENTRYPOINT
ENTRYOFFSET	=   0x400

# Programs, flags, etc.
ASM		= nasm
DASM		= ndisasm
CC		= gcc
LD		= ld
ASMBFLAGS	= -I boot/include/
ASMKFLAGS	= -I include/ -f elf
CFLAGS		= -I include/ -m32 -c -fno-builtin -fno-stack-protector
LDFLAGS		= -s -Ttext $(ENTRYPOINT)
DASMFLAGS	= -u -o $(ENTRYPOINT) -e $(ENTRYOFFSET)

BOOT	= boot/boot.bin boot/loader.bin
KERNEL	= kernel.bin
OBJS		= kernel/kernel.o kernel/start.o kernel/global.o lib/kliba.o lib/string.o lib/klib.o kernel/protect.o\
	kernel/i8259.o kernel/main.o
INCS	= include/type.h include/const.h include/protect.h include/string.h include/proc.h include/proto.h\
	include/global.h
DASMOUTPUT	= kernel.bin.asm

IMG:=x.img
FLOPPY:=mnt

# All Phony Targets
.PHONY : everything final image clean realclean disasm all buildimg

# Default starting position
everything : $(BOOT) $(KERNEL)
	make buildimg
	
boot/boot.bin : boot/boot.asm boot/include/load.inc boot/include/fat12hdr.inc boot/include/lib.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<
boot/loader.bin : boot/loader.asm boot/include/load.inc  boot/include/lib.inc\
			boot/include/fat12hdr.inc boot/include/pm.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

$(ORANGESKERNEL) : $(OBJS)
	$(LD) $(LDFLAGS) -o $(ORANGESKERNEL) $(OBJS)

kernel/kernel.o : kernel/kernel.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

kernel/start.o : kernel/start.c $(INCS)
	$(CC) $(CFLAGS) -o $@ $<
kernel/i8259.o : kernel/i8259.c $(INCS)
	$(CC) $(CFLAGS) -o $@ $<
kernel/global.o : kernel/global.c $(INCS)
	$(CC) $(CFLAGS) -o $@ $<
kernel/protect.o : kernel/protect.c $(INCS)
	$(CC) $(CFLAGS) -o $@ $<
kernel/main.o: kernel/main.c $(INCS)
	$(CC) $(CFLAGS) -o $@ $<

lib/kliba.o : lib/kliba.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<
lib/string.o : lib/string.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<
lib/klib.o : lib/klib.c
	$(CC) $(CFLAGS) -o $@ $<
$(KERNEL):$(OBJS)
	$(LD) $(LDFLAGS) -melf_i386  -o $@ $(OBJS) 
img:boot/boot.bin
	@dd if=/dev/zero of=$(IMG) bs=512 count=2880
	@dd if=boot/boot.bin  of=$(IMG) bs=512 count=1 conv=notrunc
buildimg : 
	@rm -rf $(FLOPPY) $(IMG)
	@mkdir -v $(FLOPPY)
	make img 
	@mount -o loop $(IMG) $(FLOPPY)
	@cp -fv boot/loader.bin $(FLOPPY) 
	@cp -fv $(KERNEL)  $(FLOPPY)
	@umount $(FLOPPY)
disasm :
	$(DASM) $(DASMFLAGS) $(KERNEL) > $(DASMOUTPUT)
clean:
	@rm -rf $(OBJS)  $(FLOPPY) $(BOOT) $(KERNEL) $(IMG) 
run: everything 
	qemu-system-i386 -vga std -display sdl  -m 32M -drive file=x.img,format=raw,index=0,if=floppy
