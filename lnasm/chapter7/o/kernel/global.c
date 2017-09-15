#define GLOBAL_VARIABLES_HERE
#include "all.h"

char 			task_stack[STACK_SIZE_TOTAL] ;
irq_handler		irq_table[NR_IRQ];
system_call		sys_call_table[NR_SYS_CALL] = {sys_get_ticks , sys_write} ; 

TASK			task_table[NR_TASKS] = {
	{task_tty , STACK_SIZE_TTY , "tty"}
} ;

TASK	user_proc_table[NR_PROCS] = {
	{TestA , STACK_SIZE_TESTA , "TestA"},
	{TestB , STACK_SIZE_TESTB , "TestB"},
	{TestC , STACK_SIZE_TESTC , "TestC"}
} ;

PROCESS			proc_table[NR_TASKS + NR_PROCS];

TTY tty_table[NR_CONSOLES] ;
CONSOLE console_table[NR_CONSOLES];

