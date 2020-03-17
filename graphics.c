#include "graphics.h"
// ######################## GRAPHICS SECTION ##########################

void video_mode(int m)
{
	asm(
	"ld.w r0, [r13 + (8)]\n mov.w r1, 2147483648\n add.w r1, IO_PORT_VIDEO_MODE\n	st.s [r1], r0"
	);	
}

void pixel(int x, int y, int color)
{
	switch(current_video_mode)
	{
		case 0:
			return;
		case 1:
			asm (
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (16)]\n call pixel320"
			);
			return;
		case 2:
			asm (
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (16)]\n call pixel640"
			);
			return;
	}
}

void line(int x1, int y1, int x2, int y2, int color)
{
	switch(current_video_mode)
	{
		case 0:
			return;
		case 1:
			//printf("line: x1=%d, y1=%d, y2=%d, Y2=%d, color=%d\n", x1, y1, x2, y2, color);
			
			asm(
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (24)]\n ld.w r3, [r13 + (16)]\n ld.w r4, [r13 + (20)]\ncall line320"
			);
			
			return;
		case 2:
			asm(
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (24)]\n ld.w r3, [r13 + (16)]\n ld.w r4, [r13 + (20)]\ncall line640"
			);
			return;
	}
}

void circle(int x, int y, int r, int color)
{
	switch(current_video_mode)
	{
		case 0:
			return;
		case 1:
			//printf("circle: x=%d, y=%d, r=%d, color: %d\n", x, y, r, color);
						
			asm(
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (20)]\n ld.w r3, [r13 + (16)]\n call circle320"
			);
			return;
		case 2:
			asm(
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (20)]\n ld.w r3, [r13 + (16)]\n call circle640"
			);
			return;
	}
}

void draw(int x, int y, int color, char *text)
{
	switch(current_video_mode)
	{
		case 0:
			return;
		case 1:
			//printf("draw: x1=%d, y1=%d, color=%d, text: %s\n", x, y, color, text);
			
			asm(
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (20)]\n ld.w r3, [r13 + (16)]\n call draw_text320"
			);
			
			return;
		case 2:
			asm(
			"ld.w r0, [r13 + (8)]\n ld.w r1, [r13 + (12)]\n ld.w r2, [r13 + (20)]\n call draw_text640"
			);
			return;
	}
}

