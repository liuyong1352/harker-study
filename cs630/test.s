	.code16
	.section .text
#start:
	ljmp $0x07c0 , $0
#----------------------------------------------------------
	.org 510 				#boot-signature offset
	.byte 0x55 , 0xAA		#and signature's value
#----------------------------------------------------------
	.end					#nothing else to assemble
