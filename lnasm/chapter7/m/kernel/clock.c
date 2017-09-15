#include "all.h"

void init_clock()
{
	 /* 初始化 8253 PIT */
	out_byte(TIMER_MODE, RATE_GENERATOR);
	out_byte(TIMER0, (u8) (TIMER_FREQ/HZ) );
	out_byte(TIMER0, (u8) ((TIMER_FREQ/HZ) >> 8));

	put_irq_handler(CLOCK_IRQ , clock_handler);
	enable_irq(CLOCK_IRQ);
	
}

void clock_handler(int irq)
{
	
	ticks++ ; 
	p_proc_ready->ticks-- ; 
	if(k_reenter != 0 ) {
		return ;
	}
	if(p_proc_ready->ticks > 0 ){
		return ;
	}
	schedule() ; 
}

void milli_delay(int milli_sec)
{
	int t = get_ticks() ; 
	while( ((get_ticks() - t) *1000/HZ) < milli_sec) {} 
}
