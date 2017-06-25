boot:
	nasm boot.asm -o boot.bin
	dd if=/dev/zero of=zImg.img bs=512 count=2880
	dd if=boot.bin of=zImg.img bs=512 count=1 conv=notrunc
	#bochs -q -f bochsrc.bxrc
	qemu-system-i386 -vga std -display sdl  -m 512M -drive file=zImg.img,format=raw,index=0,if=floppy 
pmtest: 
	nasm pmtest.asm -o pmtest.com
	mount -o loop bochs/a.img bochs/mntfloopy
	cp pmtest.com bochs/mntfloopy 
	umount bochs/mntfloopy			
pmtest2: 
	nasm pmtest2.asm -o pmtest2.com
	nasm pmtest21.asm -o pmtest21.com
	mount -o loop bochs/a.img bochs/mntfloopy
	cp pmtest2.com bochs/mntfloopy 
	cp pmtest21.com bochs/mntfloopy 
	umount bochs/mntfloopy			
pmtest22: 
	nasm pmtest22.asm -o pmtest22.com
	mount -o loop bochs/a.img bochs/mntfloopy
	cp pmtest22.com bochs/mntfloopy 
	umount bochs/mntfloopy			
clean:
	@rm  -rf *.img *.o *.bin *.com
