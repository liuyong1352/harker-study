default:
	gcc -g -m32 -c bootmsw.s
	ld -melf_i386 -Tbootloader_x86.ld  bootmsw.o -o boot
	objcopy -R .pdr -R .comment -R.note -S -O binary boot boot.bin
	qemu-system-i386   -m 129M -fda boot.bin  -boot a
test:
	gcc -g -m32 -c test.s
	ld -melf_i386 -Tbootloader_x86.ld  test.o -o boot
	objcopy -R .pdr -R .comment -R.note -S -O binary boot boot.bin
	qemu-system-i386   -m 129M -fda boot.bin  -boot a
	
note:
	@cat NOTE.md

help:
	@echo "--------------------Assembly Course (CS630) Lab---------------------"
	@echo ""
	@echo "    :: Download ::"
	@echo ""
	@echo "    make update                  -- download the latest resources for the course"
	@echo ""
	@echo "    :: Configuration ::"
	@echo ""
	@echo "    ./configure src/helloworld.s -- configure the source want to compile"
	@echo "    ./configure src/rtc.s        -- configure the sources with real mode"
	@echo "    ./configure src/pmrtc.s      -- configure the sources with protected mode"
	@echo ""
	@echo "    :: Compile and Boot ::"
	@echo ""
	@echo "    make boot                    -- For Real mode"
	@echo "    make boot G=0                -- For Real mode, Curses based output, for ssh like console"
	@echo "    make boot D=1                -- For Real mode, for debugging with gdb"
	@echo "    make pmboot                  -- For Protected mode"
	@echo ""
	@echo "    :: Notes ::"
	@echo ""
	@echo "    make note"
	@echo ""
	@echo "--------------------------------------------------------------------"
clean:
	@rm *.o *.bin *.img
