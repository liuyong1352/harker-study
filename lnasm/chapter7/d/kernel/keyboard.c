#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"
#include "keyboard.h"
#include "keymap.h"

static u8	get_byte_from_kbuf();

static KB_INPUT kb_in ;

static	int	code_with_E0 = 0;
static	int	shift_l;	/* l shift state */
static	int	shift_r;	/* r shift state */
static	int	alt_l;		/* l alt state	 */
static	int	alt_r;		/* r left state	 */
static	int	ctrl_l;		/* l ctrl state	 */
static	int	ctrl_r;		/* l ctrl state	 */
static	int	caps_lock;	/* Caps Lock	 */
static	int	num_lock;	/* Num Lock	 */
static	int	scroll_lock;	/* Scroll Lock	 */
static	int	column;

void keyboard_handler(int irq)
{
	u8 scan_code = in_byte(KB_DATA);
	if(kb_in.count < KB_IN_BYTES) {
		*(kb_in.p_head) = scan_code ;
		kb_in.p_head++ ;
		if(kb_in.p_head == kb_in.buf + KB_IN_BYTES){
			kb_in.p_head = kb_in.buf ;
		}
		kb_in.count++ ;
	}
	
}

void keyboard_read()
{
	u8 scan_code ;
	char output[2];
	int make ;

	u32	key = 0;/* 用一个整型来表示一个键。比如，如果 Home 被按下，
			 * 则 key 值将为定义在 keyboard.h 中的 'HOME'。
			 */
	u32*	keyrow;	/* 指向 keymap[] 的某一行 */

	if(kb_in.count > 0 ){
		disable_int();
		scan_code = *(kb_in.p_tail) ; 
		kb_in.p_tail++ ;
		if(kb_in.p_tail == kb_in.buf + KB_IN_BYTES){
			kb_in.p_tail = kb_in.buf ;
		}
		kb_in.count-- ;
		enable_int();
		if(scan_code == 0xE1) {
		} 
		else if(scan_code == 0xE0){
			code_with_E0 = 1 ;
		} 
		else {
			make = ((scan_code & FLAG_BREAK) ? FALSE :TRUE);
			/* 先定位到 keymap 中的行 */
			keyrow = &keymap[(scan_code & 0x7F) * MAP_COLS];
			column	= 0 ;
			if (shift_l || shift_r) {
				column = 1;
			}
			if (code_with_E0) {
				column = 2; 
				code_with_E0 = 0;
			}
			key = keyrow[column];
			switch(key) {
			case SHIFT_L:
				shift_l = make;
				key = 0;
				break;
			case SHIFT_R:
				shift_r = make;
				key = 0;
				break;
			case CTRL_L:
				ctrl_l = make;
				key = 0;
				break;
			case CTRL_R:
				ctrl_r = make;
				key = 0;
				break;
			case ALT_L:
				alt_l = make;
				key = 0;
				break;
			case ALT_R:
				alt_l = make;
				key = 0;
				break;
			default:
				if (!make) {	/* 如果是 Break Code */
					key = 0;	/* 忽略之 */
				}
				break;
			}

			/* 如果 Key 不为0说明是可打印字符，否则不做处理 */
			if(key){
				output[0] = key;
				disp_str(output);
			}
		}
	}
	
}

void init_keyboard()
{
	kb_in.count = 0 ;
	kb_in.p_head = kb_in.p_tail = kb_in.buf ;
	put_irq_handler(KEYBOARD_IRQ , keyboard_handler);
	enable_irq(KEYBOARD_IRQ);
}

static u8	get_byte_from_kbuf()
{	
	u8 scan_code;

    while (kb_in.count <= 0) {}   /* 等待下一个字节到来 */

    disable_int();
    scan_code = *(kb_in.p_tail);
    kb_in.p_tail++;
    if (kb_in.p_tail == kb_in.buf + KB_IN_BYTES) {
    	kb_in.p_tail = kb_in.buf;
	}
    kb_in.count--;
    enable_int();
	return scan_code;
}
