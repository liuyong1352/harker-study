#define GLOBAL_VARIABLES_HERE

#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "proc.h"
#include "global.h"

PROCESS			proc_table[NR_TASKS];
char 			task_stack[STACK_SIZE_TOTAL] ;
irq_handler		irq_table[NR_IRQ];
system_call		sys_call_table[NR_SYS_CALL] = {sys_get_ticks} ; 

TASK			task_table[NR_TASKS] = {
	{TestA , STACK_SIZE_TESTA , "TestA"},
	{TestB , STACK_SIZE_TESTB , "TestB"},
	{TestC , STACK_SIZE_TESTC , "TestC"}
} ;
