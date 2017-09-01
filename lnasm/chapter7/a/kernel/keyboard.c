#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"

void keyboard_handler(int irq)
{
//	in_byte(0x60) ;
//	disp_str("*");
	u8 scan_code = in_byte(0x60);
	disp_int(scan_code);	
}


void init_keyboard()
{
	put_irq_handler(KEYBOARD_IRQ , keyboard_handler);
	enable_irq(KEYBOARD_IRQ);
}
