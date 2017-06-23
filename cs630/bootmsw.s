	.code16
	.section .text
start: ljmp $0x07c0 , $main
msg:	.ascii "Welcome Gang zi"
len:	.word . - msg	#lenght of our message 
main:
	#setup segment-registers to address this segment's data
	mov %cs ,%ax
	mov %ax ,%ds
	mov %ax ,%es
	
	#display message at current page's cursor-location
	
	mov $0x0F , %ah			#get current video-page
	int $0x10				#request BIOS service
	
	mov $0x03 , %ah			#get cursor's location
	int $0x10				#request BIOS service
	
	lea msg , %bp			#point ES:BP to string
	mov len , %cx			#message-length in cx
	mov $0x0A ,%bl			#bright green on black
	mov $0x1301 , %ax 		#write_string to screen
	int $0x10				#request BIOS service

freeze: jmp freeze #spin here until reboot
#----------------------------------------------------------
	.org 510 				#boot-signature offset
	.byte 0x55 , 0xAA		#and signature's value
#----------------------------------------------------------
	.end					#nothing else to assemble
