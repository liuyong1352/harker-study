#include "all.h"


void schedule()
{
	PROCESS* p ;
	int greatest_ticks = 0 ;
	while(!greatest_ticks){
		for(p = proc_table ; p  < proc_table + NR_TASKS + NR_PROCS ; p++ ){
			if(p->ticks > greatest_ticks){
				greatest_ticks = p->ticks ;
				p_proc_ready = p ;
			}
		}
		if(!greatest_ticks){
			for(p = proc_table ; p  < proc_table + NR_TASKS + NR_PROCS ; p++ ){
				p->ticks = p->priority;
			}	
		} 
	}
}

int sys_get_ticks()
{
	return ticks;
}
