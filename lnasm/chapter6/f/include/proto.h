void	out_byte(u16 port, u8 value);
u8	in_byte(u16 port);
void	disp_str(char * info);
void	disp_color_str(char * info, int color);
void	disp_int(int num);
void	init_8259A();
void	init_prot();

u32	seg2phys(u16 seg);

void restart();
void delay(int time);
void TestA();
void TestB();
void TestC();
