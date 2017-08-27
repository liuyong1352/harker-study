/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            const.h
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                                    Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#ifndef	_CONST_H_
#define	_CONST_H_

/* EXTERN is defined as extern except in global.c */
#define EXTERN extern

/* 函数类型 */
#define	PUBLIC		/* PUBLIC is the opposite of PRIVATE */
#define	PRIVATE	static	/* PRIVATE x limits the scope of x */

/* GDT 和 IDT 中描述符的个数 */
#define	GDT_SIZE	128


#endif
