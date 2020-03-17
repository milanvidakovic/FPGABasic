#include "sprintf.h"
#include "consts.h"
#include "keyboard.h"
#include "graphics.h"
#include "string.h"
#include "fpga.h"

int current_video_mode;
char *VIDEO = (char *)0x401;

int *PORT_KEYBOARD = (int *)(0x80000000 + 680); // port of the data
int *PORT_MILLIS   = (int *)(0x80000000 + 690); // current number of milliseconds counted so far

short int *PS2_HANDLER_INSTR 					= (short int *)24	; // address of the IRQ#2 handler address (raw PS/2 keyboard handler)
int *PS2_HANDLER_ADDR				 					= (int *)26	; // address of the IRQ#2 handler address (raw PS/2 keyboard handler)
short int *KEY_PRESSED_HANDLER_INSTR	= (short int *)32	; // address of the key pressed handler address (invoked from the IRQ2_ADDR handler)
int *KEY_PRESSED_HANDLER_ADDR					= (int *)34	; // address of the key pressed handler address (invoked from the IRQ2_ADDR handler)
short int *KEY_RELEASED_HANDLER_INSTR	= (short int *)40	; // address of the key released handler address (invoked from the IRQ2_ADDR handler)
int *KEY_RELEASED_HANDLER_ADDR				= (int *)42	; // address of the key released handler address (invoked from the IRQ2_ADDR handler)
short int *VIRTUAL_KEY_ADDR						= (short int*)48	; // address where the virtual key is placed

int gets_finished = 0;
int shift_pressed = 0;
int key_is_pressed = 0;
int ctrl_c = 0;
int do_reset = 0;
int seed = 5;

char printf_dst[10000];

#define HISTORY_MAX 4
char _history[HISTORY_MAX][256];
int _history_idx = 0;
int _history_size = 0;

void cls() 
{
	int i;
	int *v;
	
	v = (int *)1024;
	
	for (i = 0; i < 9600; i++)
	{
			v[i] = 0;
	}
	VIDEO = (char *)0x401;	
}

void xy(int x, int y)
{
		VIDEO = (char *)(1024 + (y * 160) + (x * 2) - 1);
}

/*
void scroll_up() 
{
	int i;
	int j;
	int *v;
	
	v = 1024;
	
	for (i = 0; i < 59; i++)
	{
		for (j = 0; j < 40; j++)
		{
			v[i*40 + j] = v[(i+1)*40 + j];
		}
	}
	for (j = 0; j < 40; j++)
	{
		v[59*40 + j] = 0;
	}
}
*/

void blank_line(int v)
{
	int i, j;
	char * vid;
	
	vid = (char *)v;
	
	i = v;
	i -= 1024;
	i = i % 160;
	i = i / 2;
	i = i - 2;
	if (i < 0)
		j = 160 + i  - 2;
	else
		j = 160 - i - 2;
	for (; i < j; i++)
	{
		vid[i] = 0;
	}
}

void put_char(int c)
{
	int i, j;
	if (c == 10 || c == 13) 
	{
		i = (int)VIDEO;
		i = (i - 1024) / 160;
		i++;
		if (i == 60)
		{
			scroll_up();
			i = 59;
		}
		VIDEO = (char *)(1024 + (i * 160) - 1);
	} else {
		i = (int)VIDEO;
		i = (i - 1024) / 160;
		if (i == 59) {
			j = (int)VIDEO;
			j = (j - 10463) / 2;
			if (j == 80)
			{
				scroll_up();
				VIDEO = (char*)10463;
			}
		}
	}
	*VIDEO = c + 0xFF00;
	VIDEO += 2;
}

int putchar(int c)
{
	put_char(c);
	return c;
}

void print_str(char *s)
{
	int i;
	
	for (i = 0; i < 1000; i++) 
	{
		if (*s == 0)
			break;
		put_char(*s);
		s++;
	}
}

int puts(char *s)
{
	print_str(s);
	put_char(10);
}

void print_numz(int n) 
{
	int i;
	int d;
	char s[16] = {'0', '0', '0','0','0', '0', '0', '0', '0', '0', 0, 0, 0, 0, 0, 0};
	
	for (i = 0; i < 5; i++) {
		d = n % 10;
		n = n / 10;
		s[5 - i] += d;
		if (n == 0)
			break;
	}
	print_str(s);
}

void print_num(int n) 
{
	int i, j;
	int d;
	char s[16];
	char r[16];
	
	for (i = 0; i < 9; i++) 
	{
		d = n % 10;
		n = n / 10;
		s[i] = d + '0';
		if (n == 0)
			break;
	}
	s[i + 1] = 0;
	
	for (j = 0; j < i+1; j++)
	{
		r[i - j] = s[j];
	}
	r[i + 1] = 0;
	
	print_str(r);
}

int printf(char* fmt, ...)
{
		va_list args;
    va_start(args, fmt);
    vsprintf(printf_dst,fmt,args);
    print_str(printf_dst);
}

void key_pressed() 
{
	int i;
	asm 
	(
		"push r0\npush r1\npush r2\n"
	);

	i = *VIRTUAL_KEY_ADDR;
	
	key_is_pressed = 1;
	
	if (i < 255) 
	{
		if ((ctrl_c == 1) && (i == 'C'))
		{
			current_video_mode = 0;
			video_mode(0);
			ctrl_c = 2;
		}
		
		gets_finished = 1;
	} 
	else 
	{
		switch(i)
		{
			case VK_LEFT_CONTROL:
			case VK_RIGHT_CONTROL: 
				ctrl_c = 1;
				break;
			case VK_LEFT_ALT:
			case VK_RIGHT_ALT: 
				if (ctrl_c == 1)
					do_reset = 1;
				break;
			case VK_LEFT_SHIFT:
			case VK_RIGHT_SHIFT: 
				shift_pressed = 1;			
				break;
			case VK_BACKSPACE:
			case VK_LEFT_ARROW:
			case VK_RIGHT_ARROW:
			case VK_UP_ARROW:
			case VK_DOWN_ARROW:
			case VK_HOME:
			case VK_END:
			case VK_ESC:
			case VK_DELETE:
				if (i == VK_DELETE && do_reset == 1)
				{
					cls();
					reset();
				}
				gets_finished = 1;
				break;
		}
	}
	asm 
	(
		"pop r2\npop r1\npop r0\nmov.w sp,r13\npop r13\niret"
	);
}

void key_released()
{
	int i;
	asm 
	(
		"push r0\npush r1\npush r2\npush r3\npush r4\npush r5\npush r6\npush r7\npush r8\npush r9\npush r10\npush r11\npush r12\npush r13\n"
	);
	
	//key_is_pressed = 0;
	
	i = *VIRTUAL_KEY_ADDR;
	if ((i == VK_LEFT_SHIFT) || (i == VK_RIGHT_SHIFT)) 
	{
		shift_pressed = 0;
	}
	else if ((i == VK_LEFT_CONTROL) || (i == VK_RIGHT_CONTROL)) 
	{
		ctrl_c = 0;
		do_reset = 0;
	}

	asm 
	(
		"pop r13\npop r12\npop r11\npop r10\npop r9\npop r8\npop r7\npop r6\npop r5\npop r4\npop r3\npop r2\npop r1\npop r0\nmov.w sp,r13\npop r13\niret"
	);
}

int vk_to_char(int vk)
{
	if (vk == 32)
		return vk;
	if ((vk >= 65) && (vk <= 90)) 
	{
		if (shift_pressed)
			return vk;
		else
			return vk + 32;
	} else
	{
		switch (vk)
		{
			case VK_0: if (!shift_pressed) return 48; else return 41;// 0, )!
			case VK_1: if (!shift_pressed) return 49; else return 33;// 1, !
			case VK_2: if (!shift_pressed) return 50; else return 64;// 2, @
			case VK_3: if (!shift_pressed) return 51; else return 35;// 3, #
			case VK_4: if (!shift_pressed) return 52; else return 36;// 4, $
			case VK_5: if (!shift_pressed) return 53; else return 37;// 5, %
			case VK_6: if (!shift_pressed) return 54; else return 94;// 6, ^
			case VK_7: if (!shift_pressed) return 55; else return 38;// 7, &
			case VK_8: if (!shift_pressed) return 56; else return 42;// 8, *
			case VK_9: if (!shift_pressed) return 57; else return 40;// 9, (
			
			case VK_BACK_QUOTE: if (!shift_pressed) return 96; else return 126;	// `, ~
			case VK_MINUS:			if (!shift_pressed) return 45; else return 95;				// -, _
			case VK_EQUALS:	 		if (!shift_pressed) return  61; else return 43;				// =, +
		
			case VK_BRACE_LEFT: if (!shift_pressed) return 91; else return 123	; //[, {
			case VK_BRACE_RIGHT:if (!shift_pressed) return 93; else return 125;	// ], }
			case VK_SEMICOLON: 	if (!shift_pressed) return 59; else return 58; 		//;, :
			case VK_QUOTE: 			if (!shift_pressed) return 39; else return 34	;				//', "
			case VK_BACK_SLASH:	if (!shift_pressed) return 92; else return 124;	//\, |
			case VK_COMMA: 			if (!shift_pressed) return 44; else return 60;				// ,, <
			case VK_FULL_STOP: 	if (!shift_pressed) return 46; else return 62;		// ., >
			case VK_LESS_THAN: 	if (!shift_pressed) return 60; else return 62;		// <, >
			case VK_SLASH: 			if (!shift_pressed) return 47; else return 63;				// /, ?
			default:
				return 0;

		}
	}
}

void toggle_cursor()
{
	char i;
	i = *(VIDEO - 1);
	i = i ^ 0x77; 
	*(VIDEO - 1) = i;
}

int is_key_pressed()
{
	if (key_is_pressed) {
		key_is_pressed = 0;
		return *VIRTUAL_KEY_ADDR;
	}
	return 0;
}

int getc()
{
	*VIRTUAL_KEY_ADDR = 0;
	key_is_pressed = 0;
	while (1) 
	{
		if (key_is_pressed == 1) 
		{
			key_is_pressed = 0;
			// return virtual key code
			return *VIRTUAL_KEY_ADDR;
		}
	}
}

char * gets(char *s) 
{
	int i, j, k, prev_video, start_video;
	int len;
	*VIRTUAL_KEY_ADDR = 0;
	shift_pressed = 0;
	
	start_video = (int)VIDEO;
	j = 0;
	len = strlen(s);
	if (len > 0)
	{
		prev_video = (int)VIDEO;
		print_str(s);
		j = len;
		//VIDEO = (char *)prev_video;
	}
	toggle_cursor();
	gets_finished = 0;
	while (1) 
	{
		if (gets_finished == 1) 
		{
			gets_finished = 0;
			i = *VIRTUAL_KEY_ADDR;
			switch(i)
			{
				case VK_ESC:
					toggle_cursor();
					blank_line(start_video);
					s[0] = 0;
					len = 0;
					j = 0;
					VIDEO = (char *)start_video;
					toggle_cursor();
					break;
				case VK_ENTER:
					toggle_cursor();
					s[len] = 0;
					VIDEO += (len - j) * 2;
					put_char(13);
					
					if (strlen(s) > 0)
					{
						if (_history_size = HISTORY_MAX)
						{
							for (k = 0; k < HISTORY_MAX - 1; k++)
							{
								strcpy(_history[k], _history[k + 1]);
							}
							_history_size = HISTORY_MAX - 1;
						}
						strcpy(_history[_history_size], s);
						_history_idx = _history_size;
						_history_size++;
						
					}
					/*
					for (k = 0; k < 4; k++) 
					{
						printf("%s\n", _history[k]);
					}
					*/
					return s;
				case VK_UP_ARROW:
					if (_history_size == 0)
						break;
					toggle_cursor();
					blank_line(start_video);
					VIDEO = (char *)start_video;
					
					s[0] = 0;
					strcpy(s, _history[_history_idx]);
					len = strlen(s);
					j = strlen(s);
					print_str(s);

					_history_idx--;
					if (_history_idx < 0)
						_history_idx = 0;
					
					//VIDEO = (char *)start_video;
					toggle_cursor();
					break;
				case VK_DOWN_ARROW:
					if (_history_size == 0)
						break;
					toggle_cursor();
					blank_line(start_video);
					VIDEO = (char *)start_video;
					
					s[0] = 0;
					strcpy(s, _history[_history_idx]);
					len = strlen(s);
					j = strlen(s);
					print_str(s);

					_history_idx++;
					if (_history_idx == _history_size)
						_history_idx = _history_size - 1;
					
					//VIDEO = (char *)start_video;
					toggle_cursor();
					break;
				case VK_LEFT_ARROW:
					if (j > 0)
					{
						toggle_cursor();
						j--;
						VIDEO -= 2;
						toggle_cursor();
					}
					break;
				case VK_RIGHT_ARROW:
					if (s[j] != 0)
					{
						toggle_cursor();
						j++;
						VIDEO += 2;
						toggle_cursor();
					}
					break;
				case VK_HOME:
					toggle_cursor();
					VIDEO -= j*2;
					j = 0;
					toggle_cursor();
					break;
				case VK_END:
					// TODO: scroll if going beyond 80,60)
					toggle_cursor();
					VIDEO += (len-j)*2;
					j = len;
					toggle_cursor();
					break;
				case VK_DELETE:
					if (j < len)
					{
						toggle_cursor();
						prev_video = (int)VIDEO;
						for (k = j; k < len; k++)
						{
							s[k] = s[k+1];
							put_char(s[k]);
						}
						len--;
						VIDEO = (char *)prev_video;
						toggle_cursor();
					}
					break;
				case VK_BACKSPACE:
					if (j > 0)
					{
						if (j == len)
						{
							j--;
							len--;
							s[j] = 0;
							toggle_cursor();
							VIDEO -= 2;						
							*VIDEO = 0;
							toggle_cursor();
						} else 
						{
							// delete not from the end, but in between the beginning and the end
							toggle_cursor();
							VIDEO -= 2;
							prev_video = (int)VIDEO;
							for (k = j; k <= len; k++)
							{
								s[k-1] = s[k];
								put_char(s[k-1]);
							}
							j--;
							len--;
							VIDEO = (char *)prev_video;
							toggle_cursor();
						}
					}
					break;
				default:
					if (j == len)
					{
						s[j] = vk_to_char(i);
						s[j+1] = 0;
						toggle_cursor();
						put_char(s[j]);
						toggle_cursor();
						j++;
						len++;
					} else 
					{
						toggle_cursor();
						prev_video = (int)VIDEO;
						for (k = len; k >= j; k--)
						{
							s[k+1] = s[k];
						}						
						s[j] = vk_to_char(i);
						for (k = j; k <= len; k++)
						{
							put_char(s[k]);
						}
						j++;
						len++;
						VIDEO = (char *)(prev_video + 2);
						// TODO: scroll if going beyond 80,60)
						toggle_cursor();
					}
			}
		}
	}
	return s;
}

int r_seed = 19987;
int r_a = 11035;
int r_c = 12345;
int r_m = 32768;
int rand()
{
	int x, y;
	r_a = *PORT_MILLIS & 0x7fffffff;
	x = r_a * r_seed;
	x += r_c;
	y = x / r_m;
	r_seed = x % r_m;
	if (r_seed < 0)
		r_seed = -r_seed;
	return r_seed;
}

void srand(int s)
{
	seed = s;
}

int should_break()
{
	if (ctrl_c == 2)
		return 1;
	return 0;
}

void delay(int millis)
{
	int e1 = 0, e2 = 0;	
	while(millis > 0)
	{
		e1 = *PORT_MILLIS & 0x7fffffff;
		do  {
			e2 = *PORT_MILLIS & 0x7fffffff;
		} while (e1 == e2);
		millis--;
	}
}

void init_stdio() 
{
	*PS2_HANDLER_INSTR 						= 1;
	*PS2_HANDLER_ADDR 						= (int)irq_triggered;
	*KEY_PRESSED_HANDLER_INSTR 		= 1;
	*KEY_PRESSED_HANDLER_ADDR 		= (int)&key_pressed;
	*KEY_RELEASED_HANDLER_INSTR 	= 1;
	*KEY_RELEASED_HANDLER_ADDR	 	= (int)&key_released;
	*VIRTUAL_KEY_ADDR = 0;
}

int get_millis()
{
	return *PORT_MILLIS & 0x7fffffff;
}
