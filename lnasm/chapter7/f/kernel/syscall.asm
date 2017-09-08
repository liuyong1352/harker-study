%include "sconst.inc"
NRget_ticks	equ 0
INT_VECTOR_SYS_CALL	equ 0x90

global get_ticks

bits 32
[section .text]
get_ticks:
	mov	eax ,	NRget_ticks
	int INT_VECTOR_SYS_CALL
	ret
