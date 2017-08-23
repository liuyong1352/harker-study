#(ld 的‘-s’选项意为“strip all”)
#####################################
#xxd -u -a -g 1 -c 16 -l 80 foobar
# readelf -a foobar
#####################################
default:
	@nasm -f elf foo.asm -o foo.o
	@gcc -m32 -c -o bar.o bar.c
	@ld -melf_i386 -s foo.o bar.o  -o foobar
clean:
	@rm -f *.o  foobar
