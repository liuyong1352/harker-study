#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "global.h"

PUBLIC void cstart()
{

	disp_str("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
		 "-----\"cstart\" begins-----\n");

	/* 将 LOADER 中的 GDT 复制到新的 GDT 中 */
	memcpy(&gdt,				   /* New GDT */
	       (void*)(*((u32*)(&gdt_ptr[2]))),    /* Base  of Old GDT */
	       *((u16*)(&gdt_ptr[0])) + 1	   /* Limit of Old GDT */
		);
	/* gdt_ptr[6] 共 6 个字节：0~15:Limit  16~47:Base。用作 sgdt/lgdt 的参数。*/
	u16* p_gdt_limit = (u16*)(&gdt_ptr[0]);
	u32* p_gdt_base  = (u32*)(&gdt_ptr[2]);
	*p_gdt_limit = GDT_SIZE * sizeof(DESCRIPTOR) - 1;
	*p_gdt_base  = (u32)&gdt;
	disp_color_str("-----\"cstart\" ends-----\nnum is----" , 0x74);
	disp_int(100);
}

