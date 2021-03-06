#define GLOBAL_VARIABLES_HERE
#include "all.h"

PROCESS			proc_table[NR_TASKS];
char 			task_stack[STACK_SIZE_TOTAL] ;
irq_handler		irq_table[NR_IRQ];
system_call		sys_call_table[NR_SYS_CALL] = {sys_get_ticks} ; 

TASK			task_table[NR_TASKS] = {
	{TestA , STACK_SIZE_TESTA , "TestA"},
	{TestB , STACK_SIZE_TESTB , "TestB"},
	{task_tty , STACK_SIZE_TTY , "tty"},
	{TestC , STACK_SIZE_TESTC , "TestC"}
} ;

TTY tty_table[NR_CONSOLES] ;
CONSOLE console_table[NR_CONSOLES];

