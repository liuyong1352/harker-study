#define GLOBAL_VARIABLES_HERE

#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "proc.h"
#include "global.h"

PROCESS			proc_table[NR_TASKS];
char 			task_stack[STACK_SIZE_TOTAL] ;
