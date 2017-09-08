#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"
#include "keyboard.h"

void task_tty()
{
	while(1){
		keyboard_read();
	}
}


void in_process(u32 key)
{
	char output[2] = {0 , 0 } ;
	if(!(key & FLAG_EXT)){
		output[0] = key & 0xFF ;
		disp_str(output);
	}
}
