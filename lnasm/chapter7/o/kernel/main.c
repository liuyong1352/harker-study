#include "all.h"

int kernel_main()
{
	disp_str("-----\"kernel_main\" begins-----\n");
	PROCESS* p_proc	= proc_table;
	TASK*	 p_task = task_table;
	u8	privilege ;
	u8	rpl ;
	int eflags ;
	
	char* 	 p_task_stack = task_stack + STACK_SIZE_TOTAL ; 
	u16	selector_ldt= SELECTOR_LDT_FIRST ; 
	int i = 0 ; 
	for(;i < NR_TASKS + NR_PROCS ; i++ )
	{
		if(i < NR_TASKS){
			p_task = task_table + i ; 
			privilege = PRIVILEGE_TASK;
			rpl	= RPL_TASK ;
			eflags = 0x1202 ; 
		} else {
			p_task = user_proc_table + (i - NR_TASKS) ;
			privilege = PRIVILEGE_USER ;
			rpl = RPL_USER ; 
			eflags = 0x202 ; 
		}
		strcpy(p_proc->p_name , p_task->name);		
		p_proc->pid = i ; 
		p_proc->ldt_sel	= selector_ldt;
		memcpy(&p_proc->ldts[0], &gdt[SELECTOR_KERNEL_CS>>3], sizeof(DESCRIPTOR));
		p_proc->ldts[0].attr1 = DA_C | (privilege << 5);	// change the DPL
		memcpy(&p_proc->ldts[1], &gdt[SELECTOR_KERNEL_DS>>3], sizeof(DESCRIPTOR));
		p_proc->ldts[1].attr1 = DA_DRW | (privilege << 5);	// change the DPL

		p_proc->regs.cs	= ((8*0) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
		p_proc->regs.ds	= ((8*1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
		p_proc->regs.es	= ((8*1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
		p_proc->regs.fs	= ((8*1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
		p_proc->regs.ss	= ((8*1) & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
		p_proc->regs.gs	= (SELECTOR_KERNEL_GS & SA_RPL_MASK) | rpl;
		p_proc->regs.eip= (u32)p_task->initial_eip;
		p_proc->regs.esp= (u32)p_task_stack;
		p_proc->regs.eflags = eflags;	// IF=1, IOPL=1, bit 2 is always 1.
		
		p_proc->nr_tty = 0 ; 
		p_task_stack -= p_task->stacksize ;
		p_proc++ ;
		p_task++ ;
		selector_ldt += 1 << 3 ; 
	}

	proc_table[0].ticks = proc_table[0].priority = 15 ;
	proc_table[1].ticks = proc_table[1].priority = 5 ;
	proc_table[2].ticks = proc_table[2].priority = 5 ;
	proc_table[3].ticks = proc_table[3].priority = 5 ;

	proc_table[1].nr_tty = 0 ; 	
	proc_table[2].nr_tty = 1 ; 	
	proc_table[3].nr_tty = 1 ; 	

	k_reenter = 0;
	ticks = 0 ; 
	p_proc_ready	= proc_table;

	init_clock();
//	init_keyboard();	

	
	restart();
	while(1){}
}

static int _DELAY = 2000 ; 

void TestA()
{
	int i = 0;
	while(1){
		printf("<Ticks:%x>" , get_ticks());
		milli_delay(_DELAY);
	}
}

void TestB()
{
	int i = 0x1000;
	while(1){

		printf("B");
		milli_delay(_DELAY);
	}
}

void TestC()
{
	int i = 0x2000;
	while(1){
		printf("C");
		milli_delay(_DELAY);
	}
}
