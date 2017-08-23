#(ld 的‘-s’选项意为“strip all”)
default:
	@nasm -f elf hello.asm -o hello.o
	@ld -melf_i386 -s hello.o -o hello
clean:
	@rm -f *.o  hello
