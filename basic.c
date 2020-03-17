#define DESKTOP 0
#define DEBUG 0

#if DESKTOP == 1
#include <stdio.h>
#include <string.h>
#else
#include "stdio.h"
#include "sprintf.h"
#include "string.h"
#include "consts.h"
#include "graphics.h"
#include "files.h"
#include "keyboard.h"
#endif

#define kVersion "v0.20"

// size of our program ram
#define kRamSize   64*1024 
#if DESKTOP == 1
char program[kRamSize];
#else
char *program = (char *)0x20000;
char *buffer = (char *)(0x20000 + kRamSize + 1024);
#endif

unsigned char *program_start;
unsigned char *program_end;
int linenum;

unsigned char jump_buff[8];

unsigned char* txtpos;
char expression_error;
unsigned char *list_line, *tmptxtpos;
unsigned char *current_line;
char *stack_limit;
char *stack; // Software stack for things that should go on the CPU stack
unsigned char *variables_begin;
char *bsp;
char *tempsp;
char table_index;

#define STACK_GOSUB_FLAG 'G'
#define STACK_FOR_FLAG 'F'

struct stack_for_frame {
	char frame_type;
	char for_var;
	int terminal;
	int step;
	char *current_line;
	char *txtpos;
};

struct stack_gosub_frame {
	char frame_type;
	char *current_line;
	char *txtpos;
};

typedef unsigned LINENUM;
typedef int VAR;

VAR expression(void);
int direct();

#define STACK_SIZE (sizeof(struct stack_for_frame)*10)
#define VAR_SIZE sizeof(VAR) // Size of variables in bytes
#define CR	'\r'
#define NL	'\n'
#define LF      0x0a
#define TAB	'\t'
#define BELL	'\b'
#define SPACE   ' '
#define SQUOTE  '\''
#define DQUOTE  '\"'
#define CTRLC	0x03
#define CTRLH	0x08
#define CTRLS	0x13
#define CTRLX	0x18

// Keyword table and constants - the last character has 0x80 added to it
const char keywords[] = {
  'M','E','M'             ,0x01,			// MEM
  'B','Y','E'             ,0x01,			// BYE
  'E','X','I','T'         ,0x01,			// EXIT
  'P','R','I','N','T'     ,0x01,			// PRINT
  '?'					  					,0x01,			// ?
  'L','I','S','T'         ,0x01,  		// LIST
  'R','U','N'             ,0x01,			// RUN
  'N','E','W'             ,0x01,			// NEW
  'L','E','T'             ,0x01,			// LET
  'I','F'                 ,0x01,			// IF
  'G','O','T','O'         ,0x01,			// GOTO
  'F','O','R'             ,0x01,			// FOR
  'N','E','X','T'         ,0x01,			// NEXT
  'R','E','T','U','R','N' ,0x01,			// RETURN
  'G','O','S','U','B'     ,0x01,			// GOSUB
  'E','N','D'             ,0x01,			// END
  'S','T','O','P'         ,0x01,			// STOP
  'I','N','P','U','T'     ,0x01,			// INPUT
  'C','L','S'             ,0x01,			// CLS
  'E','D','I', 'T'        ,0x01,			// EDIT
  'L','O','A','D'         ,0x01,			// LOAD
  'S','A','V','E'         ,0x01,			// SAVE
  'D','I','R'			        ,0x01,			// DIR
  'M','O','D','E'	        ,0x01,			// MODE
  'P','L','O','T'			    ,0x01,			// PLOT
  'L','I','N','E'			    ,0x01,			// LINE
  'C','I','R','C','L','E' ,0x01,			// CIRCLE
  'D','R','A','W'			    ,0x01,			// DRAW
  'H','E','L','P'     		,0x01,			// HELP
  'D','E','L','A','Y'   	,0x01,			// DELAY
  'C','U','R','S','O','R'	,0x01,			// CURSOR
  'P','O','K','E'         ,0x01,			// POKE
  'E','X','E','C'	        ,0x01,			// EXEC
  'S','Y','S'			        ,0x01,			// SYS
/*
  'R','E','M'             ,0x01,			// REM
  'R','S','E','E','D'     ,0x01,			// RSEED
  'P','O','K','E'         ,0x01,			// POKE
  'F','I','L','E','S'     ,0x01,			// FILES
  '\''                    ,0x01,			// '
*/
  0
};
// by moving the command list to an enum, we can easily remove sections 
// above and below simultaneously to selectively obliterate functionality.
enum {
	KW_MEM = 0,
	KW_BYE,
	KW_EXIT,
	KW_PRINT,
	KW_QMARK,
	KW_LIST,
	KW_RUN,
	KW_NEW,
	KW_LET,
	KW_IF,
	KW_GOTO,
	KW_FOR,
	KW_NEXT,
	KW_RETURN,
	KW_GOSUB,
	KW_END,
	KW_STOP,
	KW_INPUT,
	KW_CLS,
	KW_EDIT,
  KW_LOAD,
  KW_SAVE,
  KW_DIR,
  KW_MODE,
  KW_PLOT,
  KW_LINE,
  KW_CIRCLE,
  KW_DRAW,
  KW_HELP,
  KW_DELAY,
  KW_CURSOR,
  KW_POKE,
  KW_EXEC,
  KW_SYS,
	/*
	  KW_REM,
	  KW_FILES,
	  KW_QUOTE,
	  KW_RSEED,
	*/  KW_DEFAULT /* always the final one*/
};

const unsigned char func_tab[] = {
  'P','E','E','K'				, 0x01,
  'A','B','S'						, 0x01,
  'A','R','E','A','D'		, 0x01,
  'D','R','E','A','D'		, 0x01,
  'R','N','D'						, 0x01,
  'K','E','Y'			     	, 0x01,
  'I','S','K','E','Y'   , 0x01,
  0
};
#define FUNC_PEEK    0
#define FUNC_ABS     1
#define FUNC_AREAD   2
#define FUNC_DREAD   3
#define FUNC_RND     4
#define FUNC_KEY     5
#define FUNC_ISKEY	 6
#define FUNC_UNKNOWN 10

const char to_tab[] = {
  'T','O', 0x01,
  0
};

const char step_tab[] = {
  'S','T','E','P', 0x01,
  0
};

const char relop_tab[] = {
  '>','='			,0x01,
  '<','>'			,0x01,
  '>'					,0x01,
  '='					,0x01,
  '<','='			,0x01,
  '<'					,0x01,
  '!','='			,0x01,
  'A','N','D' ,0x01,
  'O','R'		  ,0x01,
  0
};

#define RELOP_GE		0
#define RELOP_NE		1
#define RELOP_GT		2
#define RELOP_EQ		3
#define RELOP_LE		4
#define RELOP_LT		5
#define RELOP_NE_BANG		6
#define RELOP_AND		7
#define RELOP_OR		8
#define RELOP_UNKNOWN	9

void exec_help()
{
	printf("END\n");
	printf("MEM\n");
	printf("LET I = 5\n");
	printf("I = 5\n");
	printf("INPUT A\n");
	printf("PRINT A\n");
	printf("? A\n");
	printf("FOR I = 1 TO 10 STEP 2\n");
	printf("NEXT I\n");
	printf("IF I = 5 GOTO 100\n");
	printf("GOTO 100\n");
	printf("GOSUB 100\n");
	printf("RETURN\n");
	printf("LOAD P1.BAS\n");
	printf("SAVE P2.BAS\n");
	printf("MODE 0 (MODE 1, MODE 2)\n");
	printf("PLOT 100, 100, color\n");
	printf("LINE 100, 100, 200, 200, color\n");
	printf("CIRCLE 100, 100, 50, color\n");
	printf("DRAW 100, 100, color, 'TEXT'\n");
	printf("A = KEY()\n");
	printf("A = ISKEY()\n");
	printf("DELAY 1000\n");
	printf("CURSOR 10, 10\n");
	printf("EXEC TEST.BIN\n");
	printf("SYS 0\n");
}

void outchar(int c)
{
#if DESKTOP == 1
	printf("%c", c);
#else
	put_char(c);
#endif
}

void getln(int prompt)
{
	int l;
	txtpos = program_end + sizeof(LINENUM);

	txtpos[0] = 0;

	outchar(prompt);
	gets(txtpos);

	l = strlen(txtpos);
	if (l % 2 == 0)
		strcat(txtpos, " ");

	strcat(txtpos, "\n");
}

void toUppercaseBuffer()
{
	char *c = txtpos;
	char quote = 0;

	while (*c != NL)
	{
		// Are we in a quoted string?
		if (*c == quote)
			quote = 0;
		else if (*c == '"' || *c == '\'')
			quote = *c;
		else if (quote == 0 && *c >= 'a' && *c <= 'z')
			*c = *c + 'A' - 'a';
		c++;
	}
}

void ignore_blanks()
{
	while (*txtpos == SPACE || *txtpos == TAB)
		txtpos++;
}

void printmsgNoNL(const char *msg)
{
	while (*msg != 0)
	{
		outchar(*msg);
		msg++;
	}
}

void line_terminator(void)
{
	outchar(NL);
	//outchar(CR);
}

void printmsg(char *msg)
{
	printmsgNoNL(msg);
	line_terminator();
}

void printnum(int num)
{
	int digits = 0;

	if (num < 0)
	{
		num = -num;
		outchar('-');
	}
#if DESKTOP == 1
	printf("%d", num);
#else
	print_num(num);
#endif
}

void qhow()
{
	printmsg("how?");
}

void qwhat()
{
	printmsg("what?");
}

void qsorry()
{
	printmsg("sorry!");
}

void scantable(const char *table)
{
	int i = 0;
	table_index = 0;
	while (1)
	{
		// Run out of table entries?
		if (*table == 0)
		{
			return;
		}

		// Do we match this character?
		if (txtpos[i] == *table)
		{
#if DEBUG == 1
			printf("scantable: char at %d is %c, table_index is: %d\n", i, txtpos[i], table_index);
#endif
			i++;
			table++;
		}
		else
		{
			// do we match the last character of keyword (with 0x80 added)? If so, return
			if (*table == 0x01)
			{
				txtpos += i;  // Advance the pointer to following the keyword
				ignore_blanks(txtpos);
				return;
			}

			// Forward to the end of this keyword
			while (*table != 0x01)
			{
				table++;
			}

			// Now move on to the first character of the next word, and reset the position index
			table++;
			table_index++;
			ignore_blanks(txtpos);
			i = 0;
		}
	}
}

char print_quoted_string()
{
	int i = 0;
	char delim = *txtpos;
	if (delim != '"' && delim != '\'')
		return 0;
	txtpos++;

	// Check we have a closing delimiter
	while (txtpos[i] != delim)
	{
		if (txtpos[i] == NL)
			return 0;
		i++;
	}

	// Print the characters
	while (*txtpos != delim)
	{
		outchar(*txtpos);
		txtpos++;
	}
	txtpos++; // Skip over the last delimiter

	return 1;
}

int check_no_arg_func() 
{
	ignore_blanks(txtpos);
	if (*txtpos != '(')
		return 1;
	txtpos++;
	ignore_blanks(txtpos);
	if (*txtpos != ')')
		return 1;
	txtpos++;
	return 0;
}

VAR expr4(void)
{
	unsigned char f = table_index;
	// fix provided by Jurg Wullschleger wullschleger@gmail.com
	// fixes whitespace and unary operations
	ignore_blanks();

#if DEBUG == 1
	printf("expr4: txtpos: %s\n", txtpos);
#endif

	if (*txtpos == '-') {
		txtpos++;
		return -expr4();
	}
	// end fix

	if (*txtpos == '0')
	{
		txtpos++;
		return 0;
	}

	if (*txtpos >= '1' && *txtpos <= '9')
	{
		VAR a = 0;
		do {
			a = a * 10 + *txtpos - '0';
			txtpos++;
		} while (*txtpos >= '0' && *txtpos <= '9');
#if DEBUG == 1
		printf("expr4, found value, and it is: %d\n", a);
#endif
		return a;
	}

#if DEBUG == 1
	printf("expr4, first char: %c\n", txtpos[0]);
#endif
	// Is it a function or variable reference?
	if (txtpos[0] >= 'A' && txtpos[0] <= 'Z')
	{
		VAR val;
		// Is it a variable reference (single alpha)
		if (txtpos[1] < 'A' || txtpos[1] > 'Z')
		{
			// val = (VAR *)variables_begin + *txtpos - 'A';
#if DEBUG == 1
			printf("expr4, var_begin: %d\n", variables_begin);
#endif
			val = ((VAR *)variables_begin)[*txtpos - 'A'];
			txtpos++;
			return val;
		}

		// Is it a function with no parameters, or with a single parameter
		scantable(func_tab);

#if DEBUG == 1
printf("expr4: table_index is: %d\n", table_index);
#endif

		if (table_index == FUNC_UNKNOWN)
			goto expr4_error;
		// functions with no parameters
		switch(table_index)
		{
		case FUNC_KEY:
			if (check_no_arg_func())
				goto expr4_error;
			return getc();
		case FUNC_ISKEY:
			if (check_no_arg_func())
				goto expr4_error;
			return is_key_pressed();
		}
		
		f = table_index;

		if (*txtpos != '(')
			goto expr4_error;

		txtpos++;
		val = expression();

#if DEBUG == 2		
		printf("expr4: val is: %d\n", val);
#endif

		if (*txtpos != ')')
			goto expr4_error;

		txtpos++;

		switch (f)
		{
			case FUNC_PEEK:
				return buffer[val];
			case FUNC_ABS:
				if (val < 0)
					return -val;
				return val;
			case FUNC_RND:
				return(rand() % val);
		}
	}

	if (*txtpos == '(')
	{
		VAR a;
		txtpos++;
		a = expression();
		if (*txtpos != ')')
			goto expr4_error;

		txtpos++;
		return a;
	}

expr4_error:
	expression_error = 1;
	return 0;

}

/***************************************************************************/
VAR expr3(void)
{
	VAR a, b;

	a = expr4();

	ignore_blanks(); // fix for eg:  100 a = a + 1

	while (1)
	{
		if (*txtpos == '*')
		{
			txtpos++;
			b = expr4();
			a *= b;
		}
		else if (*txtpos == '/')
		{
			txtpos++;
			b = expr4();
			if (b != 0)
				a /= b;
			else
				expression_error = 1;
		}
		else
			return a;
	}
}

/***************************************************************************/
VAR expr2(void)
{
	VAR a, b;

	if (*txtpos == '-' || *txtpos == '+')
		a = 0;
	else
		a = expr3();

	while (1)
	{
		if (*txtpos == '-')
		{
			txtpos++;
			b = expr3();
			a -= b;
		}
		else if (*txtpos == '+')
		{
			txtpos++;
			b = expr3();
			a += b;
		}
		else
			return a;
	}
}
/***************************************************************************/
VAR expression(void)
{
	VAR a, b;

	a = expr2();

#if DEBUG == 1
	printf("expression: found value is: %d, and expression_error is: %d\n", a, expression_error);
#endif

	// Check if we have an error
	if (expression_error)	return a;

	scantable(relop_tab);

#if DEBUG == 1
	printf("expression: table_index: %d\n", table_index);
#endif

	if (table_index == RELOP_UNKNOWN)
		return a;

	switch (table_index)
	{
	case RELOP_GE:
		b = expr2();
		if (a >= b) return 1;
		break;
	case RELOP_NE:
	case RELOP_NE_BANG:
		b = expr2();
		if (a != b) return 1;
		break;
	case RELOP_GT:
		b = expr2();
		if (a > b) return 1;
		break;
	case RELOP_EQ:
		b = expr2();
		if (a == b) return 1;
		break;
	case RELOP_LE:
		b = expr2();
		if (a <= b) return 1;
		break;
	case RELOP_LT:
		b = expr2();
		if (a < b) return 1;
		break;
	case RELOP_AND:
		b = expr2();
		if (a && b) return 1;
		break;
	case RELOP_OR:
		b = expr2();
		if (a || b) return 1;
		break;
	}
	return 0;
}

void exec_print()
{
	if (*txtpos == NL)
	{
		return;
	}

	while (1)
	{
		ignore_blanks(txtpos);
		if (print_quoted_string())
		{
			ignore_blanks(txtpos);
		}
		else if (*txtpos == '"' || *txtpos == '\'')
		{
			qwhat();
			return;
		}
		else
		{
			VAR e;
			expression_error = 0;
			e = expression();
			if (expression_error)
			{
				qwhat();
				return;
			}
			printnum(e);
		}

		// At this point we have three options, a comma or a new line
		if (*txtpos == ',')
			txtpos++;	// Skip the comma and move onto the next
		else if (txtpos[0] == ';' && (txtpos[1] == NL || txtpos[1] == ':' || txtpos[1] == ' '))
		{
			txtpos++; // This has to be the end of the print - no newline
			break;
		}
		else if (*txtpos == NL || *txtpos == ':')
		{
			line_terminator();	// The end of the print statement
			break;
		}
		else
		{
			qwhat();
			return;
		}
	}

}

void assignment()
{
	VAR value;
	VAR *var;

	if (*txtpos < 'A' || *txtpos > 'Z')
	{
		qhow();
		return;
	}
#if DEBUG == 1
	printf("assignment, var_begin: %d\n", variables_begin);
#endif	
	var = (VAR *)variables_begin + *txtpos - 'A';

#if DEBUG == 1
	printf("assignment, current var value is %d\n", *var);
#endif

	txtpos++;

	ignore_blanks();

	if (*txtpos != '=')
	{
		qwhat();
		return;
	}
	txtpos++;
	ignore_blanks();
	expression_error = 0;
	value = expression();
	ignore_blanks();

#if DEBUG == 1
	printf("assignment, var value is %d, and expression_error is: %d\n", value, expression_error);
	printf("assignment, txtpos is: %s\n", txtpos);
#endif

	if (expression_error)
	{
		qwhat();
		return;
	}
	// Check that we are at the end of the statement
	if (*txtpos != NL && *txtpos != ':')
	{
		qwhat();
		return;
	}
	*var = value;

#if DEBUG == 1
	printf("assignment, returning var value is %d\n", *var);
#endif

}

void printline()
{
	LINENUM line_num;

	line_num = *((LINENUM *)(list_line));
	list_line += sizeof(LINENUM) + sizeof(char);

	// Output the line */
	printnum(line_num);
	outchar(' ');
	while (*list_line != NL)
	{
		outchar(*list_line);
		list_line++;
	}
	list_line++;
	line_terminator();
}

VAR testnum()
{
	VAR num = 0;
	ignore_blanks(txtpos);

#if DEBUG == 1
	printf("testnum: txtpos is: %s\n", txtpos);
#endif

	while (*txtpos >= '0' && *txtpos <= '9')
	{
		// Trap overflows
		if (num >= 0xFFFFFFFF / 10)
		{
			num = 0xFFFFFFFF;
			break;
		}

		num = num * 10 + *txtpos - '0';
		txtpos++;
	}
	return	num;
}

unsigned char *findline(void)
{
	unsigned char *line = program_start;
	while (1)
	{
		if (line == program_end)
			return line;

		if (((LINENUM *)line)[0] >= linenum)
			return line;

		// Add the line length onto the current address, to get to the next line;
		line += line[sizeof(LINENUM)];
	}
}

void exec_list()
{
	int i, j;
	
	linenum = testnum(); // Retuns 0 if no line found.

	// Should be EOL
	if (txtpos[0] != NL)
	{
		qwhat();
		return;
	}

	// Find the line
	list_line = findline();
	i = 0;
	while (list_line < program_end)
	{
		printline();
		i++;
		if (i == 29)
		{
			j = getc();
			i = 0;
			if (j == VK_ESC)
				break;
		}
	}
}

void exec_run()
{
	int res;

	while (current_line < program_end) // Out of lines to run
	{
		txtpos = current_line + sizeof(LINENUM) + sizeof(char);

		do {
			res = direct();
			if (res == 1)
				return;
			ignore_blanks();
			if (*txtpos == NL || *txtpos != ':')
				break;
			txtpos++;
			ignore_blanks();
		} while (1);

		if (res < 2)
			current_line += current_line[sizeof(LINENUM)];

#if DEBUG == 1		
		printf("current_line: %d\n", current_line);
#endif
	}
}

void exec_if()
{
	VAR condition;
	int res;

	expression_error = 0;
	condition = expression();
	if (expression_error || *txtpos == NL)
	{
		qhow();
		return;
	}
	if (condition != 0)
	{
		do {
			res = direct();
			if (res == 1)
				return;
			if (res == 2)
			{
				txtpos = current_line + sizeof(LINENUM) + sizeof(char);
				continue;
			}
			ignore_blanks();
			if (*txtpos == NL || *txtpos != ':')
				break;
			txtpos++;
			ignore_blanks();
		} while (1);
	}
	return;
}

void exec_for()
{
	unsigned char var;
	int initial, step, terminal;
	ignore_blanks();
	if (*txtpos < 'A' || *txtpos > 'Z')
	{
		qwhat();
		return;
	}
	var = *txtpos;
	txtpos++;
	ignore_blanks();
	if (*txtpos != '=')
	{
		qwhat();
		return;
	}
	txtpos++;
	ignore_blanks();

	expression_error = 0;
	initial = expression();
	if (expression_error)
	{
		qwhat();
		return;
	}

	scantable(to_tab);
	if (table_index != 0)
	{
		qwhat();
		return;
	}

	terminal = expression();
	if (expression_error)
	{
		qwhat();
		return;
	}

	scantable(step_tab);
	if (table_index == 0)
	{
		step = expression();
		if (expression_error)
		{
			qwhat();
			return;
		}
	}
	else
		step = 1;

	ignore_blanks();
	if (*txtpos != NL && *txtpos != ':')
	{
		qwhat();
		return;
	}

	if (!expression_error && ((*txtpos == NL) || (*txtpos == ':')))
	{
		struct stack_for_frame *f;
		if (bsp + sizeof(struct stack_for_frame) < stack_limit)
		{
			qsorry();
			return;
		}

		bsp -= sizeof(struct stack_for_frame);
		f = (struct stack_for_frame *)bsp;
		((VAR *)variables_begin)[var - 'A'] = initial;
		f->frame_type = STACK_FOR_FLAG;
		f->for_var = var;
		f->terminal = terminal;
		f->step = step;
		f->txtpos = txtpos;
		f->current_line = current_line;

#if DEBUG == 3
		printf("inside for: bsp: %d\n", bsp);
#endif

		return;
	}
	qhow();
}

int exec_return()
{
	int i;
	char var;
#if DEBUG == 3
	printf("inside return: bsp: %d, limit: %d\n", bsp, program + kRamSize - 1);
#endif
	// Now walk up the stack frames and find the frame we want, if present
	tempsp = bsp;
	while (tempsp < program + kRamSize - 1)
	{

#if DEBUG == 3
		printf("return: tempsp: %d\n", tempsp[0]);
#endif
		switch (tempsp[0])
		{
		case STACK_GOSUB_FLAG:
			if (table_index == KW_RETURN)
			{
				struct stack_gosub_frame *f = (struct stack_gosub_frame *)tempsp;
				current_line = f->current_line;
				txtpos = f->txtpos;
				bsp += sizeof(struct stack_gosub_frame);
				return 0;
			}
			// This is not the loop you are looking for... so Walk back up the stack
			tempsp += sizeof(struct stack_gosub_frame);
			break;
		case STACK_FOR_FLAG:
			// Flag, Var, Final, Step
			if (table_index == KW_NEXT)
			{
				struct stack_for_frame *f = (struct stack_for_frame *)tempsp;
				// Is the the variable we are looking for?
				var = txtpos[-1];
				i = -2;
				while (var == ' ') 
				{
					var = txtpos[i];
					i--;
				}
				if (var == f->for_var)
				{
					VAR *varaddr = ((VAR *)variables_begin) + var - 'A';
					*varaddr = *varaddr + f->step;
					// Use a different test depending on the sign of the step increment
					if ((f->step > 0 && *varaddr <= f->terminal) || (f->step < 0 && *varaddr >= f->terminal))
					{
						// We have to loop so don't pop the stack
						txtpos = f->txtpos;
						current_line = f->current_line;
						return 0;
					}
					// We've run to the end of the loop. drop out of the loop, popping the stack
					bsp = tempsp + sizeof(struct stack_for_frame);
					return 0;
				}
			}
			// This is not the loop you are looking for... so Walk back up the stack
			tempsp += sizeof(struct stack_for_frame);
			break;
		default:
			printmsg("Stack is stuffed!\n");
			return 1;
		}
	}
	// Didn't find the variable we've been looking for
	qhow();
	return 1;
}

void exec_next()
{
	// Find the variable name
	ignore_blanks();
#if DEBUG == 3
	printf("next: txtpos: %c\n", *txtpos);
#endif
	if (*txtpos < 'A' || *txtpos > 'Z')
	{
#if DEBUG == 3
		printf("ERROR in next, txtpos is %c\n", *txtpos);
#endif
		qhow();
		return;
	}
	txtpos++;
	ignore_blanks();
	if (*txtpos != ':' && *txtpos != NL)
	{
		qwhat();
	}
	exec_return();
}

void exec_gosub()
{
	expression_error = 0;
	linenum = expression();
	if (!expression_error && *txtpos == NL)
	{
		struct stack_gosub_frame *f;
		if (bsp + sizeof(struct stack_gosub_frame) < stack_limit)
		{
			qsorry();
			return;
		}

		bsp -= sizeof(struct stack_gosub_frame);
		f = (struct stack_gosub_frame *)bsp;
		f->frame_type = STACK_GOSUB_FLAG;
		f->txtpos = txtpos;
		f->current_line = current_line;
		current_line = findline();
		exec_run();
		return;
	}
	qhow();

}

void exec_input()
{
	unsigned char var;
	int value;
	
	ignore_blanks();

	if (*txtpos < 'A' || *txtpos > 'Z')
	{
		qwhat();
		return;
	}
	
	var = *txtpos;
	txtpos++;
	ignore_blanks();

	if (*txtpos != NL && *txtpos != ':')
	{
		qwhat();
		return;
	}

	while (1)
	{
		tmptxtpos = txtpos;
		getln('?');
		toUppercaseBuffer();
		txtpos = program_end + sizeof(VAR);
		ignore_blanks();
		expression_error = 0;
		value = expression();
		if (!expression_error)
			break;
	}
	((VAR *)variables_begin)[var - 'A'] = value;
	txtpos = tmptxtpos;
}

int exec_edit()
{
	unsigned char *line;
	int i;
	int j;

	ignore_blanks();
	expression_error = 0;
	linenum = expression();
	if (expression_error)
	{
		qhow();
		return 0;
	}
	line = findline();
	if (line == program_end)
	{
		qhow();
		return 0;
	}
	
	txtpos = program_end + sizeof(LINENUM);
	txtpos[0] = 0;
	sprintf(txtpos, "%d ", linenum);
	j = strlen(txtpos);
	for (i = sizeof(VAR) + 1; i < line[sizeof(VAR)] - 1; i++)
	{
		//outchar(line[i] + 0xFF00);
		txtpos[j++] = line[i];
	}
	txtpos[j] = 0;
	outchar('#');
	gets(txtpos);

	i = strlen(txtpos);
	if (i % 2 == 0)
		strcat(txtpos, " ");

	strcat(txtpos, "\n");
	
	return 3;
}

int sprintline(int i)
{
	LINENUM line_num;
	char s[10];

	line_num = *((LINENUM *)(list_line));
	list_line += sizeof(LINENUM) + sizeof(char);

	// Output the line */
	sprintf(s, "%d ", line_num);
	strcpy(&buffer[i], s);
	i += strlen(s);
	while (*list_line != NL)
	{
		buffer[i] = *list_line;
		list_line++;
		i++;
	}
	list_line++;
	buffer[i] = NL;
	i++;
	
	return i;
}

void exec_save()
{
	char s[32];
	int i, j, k, l;

	ignore_blanks();
	if (*txtpos < 'A' || *txtpos > 'Z')
	{
		qwhat();
		return;
	}	
	
	for (i = 0; txtpos[i] != NL; i++)
	{
		s[i] = txtpos[i];
	}
	s[i] = 0;

// Find the line
	list_line = findline();
	i = 0;
	while (list_line < program_end)
	{
		i = sprintline(i);
	}
	
	write_file(buffer, i, s);
	printf("OK saving file %s, length: %d\n", s, i);
}

void skip_to_end()
{
	txtpos = program_end + sizeof(LINENUM);

	// Find the end of the freshly entered line
	while (*txtpos != NL)
		txtpos++;

	// Move it to the end of program_memory
	{
		unsigned char *dest;
		dest = variables_begin - 1;
		while (1)
		{
			*dest = *txtpos;
			if (txtpos == program_end + sizeof(LINENUM))
				break;
			dest--;
			txtpos--;
		}
		txtpos = dest;
	}
}

void entered_with_line_num()
{
	unsigned char linelen;
	unsigned char *start;
	char *newEnd;
	int i, l, first_time;
	char k;
	char s[10];

	// Find the length of what is left, including the (yet-to-be-populated) line header
	linelen = 0;
	while (txtpos[linelen] != NL)
		linelen++;
	linelen++; // Include the NL in the line length
	linelen += sizeof(LINENUM) + sizeof(char); // Add space for the line number and line length

	// Now we have the number, add the line header.
	txtpos -= sizeof(LINENUM) + sizeof(char);
	
	// ugly odd address hack
	l = (int)txtpos;
	if (l % 2 == 1)
	{
		txtpos--;
		txtpos[sizeof(LINENUM) + sizeof(char)] = ' ';
		linelen++;
	}

	*((LINENUM *)txtpos) = linenum;
	txtpos[sizeof(LINENUM)] = linelen;


	// Merge it into the rest of the program
	start = findline();

	// If a line with that number exists, then remove it
	if (start != program_end && *((LINENUM *)start) == linenum)
	{
		unsigned char *dest, *from;
		unsigned tomove;

		from = start + start[sizeof(LINENUM)];
		dest = start;

		tomove = program_end - from;
		while (tomove > 0)
		{
			*dest = *from;
			from++;
			dest++;
			tomove--;
		}
		program_end = dest;
	}

	if (txtpos[sizeof(LINENUM) + sizeof(char)] == NL)
	{
		// If the line has no txt, it was just a delete
		return;
	}

	
	first_time = 1; // odd address hack
	// Make room for the new line, either all in one hit or lots of little shuffles
	while (linelen > 0)
	{
		unsigned int tomove;
		unsigned char *from, *dest;
		unsigned int space_to_make;

		space_to_make = txtpos - program_end;

		if (space_to_make > linelen)
			space_to_make = linelen;
		newEnd = program_end + space_to_make;
		tomove = program_end - start;


		// Source and destination - as these areas may overlap we need to move bottom up
		from = program_end;
		dest = newEnd;
		while (tomove > 0)
		{
			from--;
			dest--;
			*dest = *from;
			tomove--;
		}

		l = 0;
		//printf("txtpos: [%s]\n", &txtpos[5]);
//		printf("space_to_make: %d\n", space_to_make);
		if(first_time && (txtpos[sizeof(LINENUM) + sizeof(char)] == ' '))
		{
			// Ugly hack for the odd length, which is initially fixed by adding space at the
			// beginning of the line (just after the line number).
			// We need to move that space to the end of the line.
			k = txtpos[sizeof(LINENUM)];
			k -= sizeof(LINENUM) + sizeof(char); // actual length of line
			//printf("siftovati: %d\n", k);
			for (l = 0; l < k; l++)
			{
//			printf("%c", txtpos[sizeof(LINENUM) + sizeof(char) + l + 1]);
				txtpos[sizeof(LINENUM) + sizeof(char) + l] = txtpos[sizeof(LINENUM) + sizeof(char) + l + 1];
			}
			txtpos[k + sizeof(LINENUM) + sizeof(char) - 2] = 32;
			txtpos[k + sizeof(LINENUM) + sizeof(char) - 1] = NL;
		}

/*
		k = txtpos[sizeof(LINENUM)];
		i = *((LINENUM *)txtpos);
		sprintf(s, "%d", i);
		i = strlen(s);
		printf("broj: %d, space_to_make: %d, s: %s\n", i, space_to_make, s);
*/		
			
		// Copy over the bytes into the new space
		for (tomove = 0; tomove < space_to_make; tomove++)
		{
			*start = *txtpos;
				
			//printf("%d: %c (%d), ", tomove, *start, *start);
			txtpos++;
			start++;
			linelen--;
		}
/*
		start-=2;
		k = *start;
		printf("kraj-2: %d\n", k);
		start++;
		k = *start;
		printf("kraj-1: %d\n", k);
		start++;
*/
		program_end = newEnd;
		first_time = 0;  // odd address hack
	}

}

void exec_load()
{
	char s[32];
	int i, j, k, l;
	
	ignore_blanks();
	if (*txtpos < 'A' || *txtpos > 'Z')
	{
		qwhat();
		return;
	}	
	
	//printf("address of txtpos: %d\n", txtpos);
	for (i = 0; txtpos[i] != NL && txtpos[i] != CR && i < 32; i++)
	{
		//printf("txtpos: %d ", txtpos[i]);
		s[i] = txtpos[i];
	}
	s[i] = 0;

#if DESKTOP == 0
	printf("Loading file: %s\n", s);
	i = read_file(buffer, s);
	if (i > 0)
	{
		program_end = program_start;
		printf("File size: %d\n", i);
		if (strstr(s, ".BIN") != (char *)0) 
		{
			printf("Loaded executable file. Run it using: SYS 0\n");
			return;
		} else if (strstr(s, ".BAS") == (char *)0) 
		{
			printf("Loaded successfuly at address 0 (reachable by PEEK and POKE).\n");
			return;
		}
		k = 0;
		for (j = 0; j <= i; j++)
		{
			if (buffer[j] == CR)
			{
				buffer[j] = NL;
			}
			if (buffer[j] == NL || buffer[j] == 0)
			{
				txtpos = program_end + sizeof(LINENUM);
				strncpy(txtpos, &buffer[k], j);
				txtpos[j - k] = NL;
				txtpos[j - k + 1] = 0;
				k = j + 1;
				l = strlen(txtpos);
				if (l % 2 == 0)
					strcat(txtpos, " ");
				toUppercaseBuffer();
				skip_to_end();
				linenum = testnum();
				if (linenum > 0)
				{
					//printf("[%s]", txtpos);
					//printf("linija: %d\n", linenum);
					ignore_blanks();
					entered_with_line_num();
				}
			}
		}
		printf("OK loading file %s\n", s);
	} 
	else 
	{
		printf("Error loading file %s\n", s);
	}
#else
	strcpy(s, "10 print 123\n20 print 432\0");
	i = strlen(s);
	k = 0;
	for (j = 0; j <= i; j++)
	{
		if (s[j] == NL || s[j] == 0)
		{
			txtpos = program_end + sizeof(LINENUM);
			strncpy(txtpos, &s[k], j);
			txtpos[j - k] = NL;
			txtpos[j - k + 1] = 0;
			k = j + 1;
			l = strlen(txtpos);
			if (l % 2 == 0)
				strcat(txtpos, " ");
			printmsg(txtpos);
			toUppercaseBuffer();
			skip_to_end();
			linenum = testnum();
			ignore_blanks();
			entered_with_line_num();
		}
	}

#endif
}

void exec_dir()
{
#if DESKTOP == 0
	ls_folders(buffer);
	printmsg(buffer);
	ls_files(buffer);
	printmsg(buffer);
#else
	printmsg("Not implemented yet.");
#endif
}

void exec_mode()
{
	VAR value;
	
	ignore_blanks();
	expression_error = 0;
	value = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	
	switch (value)
	{
		case 0:
			video_mode(0);
			current_video_mode = 0;
			break;
		case 1:
			video_mode(1);
			current_video_mode = 1;
			break;
		case 2:
			video_mode(2);
			current_video_mode = 2;
			break;
		default:
			video_mode(0);
			current_video_mode = 0;
			printf("Invalid video mode: %d\n", value);
	}
}

void exec_plot()
{
	VAR x, y, c;
	
	ignore_blanks();
	expression_error = 0;
	x = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	y = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	c = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	
	pixel(x, y, c);
}

void exec_line()
{
	VAR x1, y1, x2, y2, c;
	
	ignore_blanks();
	expression_error = 0;
	x1 = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	y1 = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	x2 = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	y2 = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
		
	ignore_blanks();
	expression_error = 0;
	c = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}

	line(x1, y1, x2, y2, c);
}

void exec_circle()
{
	VAR x, y, r, c;
	int i;
	
	ignore_blanks();
	expression_error = 0;
	x = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	y = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	r = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	c = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	
	circle(x, y, r, c);
}

void exec_draw()
{
	VAR x, y, c;
	int i;
	char s[100];
	
	ignore_blanks();
	expression_error = 0;
	x = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	y = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	c = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	if (*txtpos != '"' && *txtpos != '\'')
	{
		qwhat();
		return;
	}
	txtpos++;
	i = 0;
	while (*txtpos != NL && *txtpos != 0)
	{
		if (*txtpos == '"' || *txtpos == '\'')
		{
			s[i] = 0;
			break;
		}
		s[i] = *txtpos;
		i++;
		txtpos++;
	}
	draw(x, y, c, s);
}

void exec_mem() 
{
	printf("%d bytes free\n", variables_begin - program_end);
//	printf("program: %d\nbsp: %d\nvariables_begin: %d\nbuffer: %d\n", program, bsp, variables_begin, buffer);
//	printf("program_start: %d\nprogram_end: %d\nstack_limit: %d\n", program_start, program_end, stack_limit);
}

void exec_delay()
{
	VAR d;
	
	ignore_blanks();
	expression_error = 0;
	d = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	delay(d);
}

void exec_cursor()
{
	VAR x, y;
	
	ignore_blanks();
	expression_error = 0;
	x = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	y = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	
	xy(x, y);
}

void exec_poke()
{
	VAR addr, value;
	
	ignore_blanks();
	expression_error = 0;
	addr = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	ignore_blanks();
	if (*txtpos != ',')
	{
		qwhat();
		return;
	}
	else 
	{
		txtpos++;
	}
	ignore_blanks();
	expression_error = 0;
	value = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	
	buffer[addr] = value & 0XFF;
}

void exec_sys()
{
	VAR addr;
	char s[32];
	
	ignore_blanks();
	expression_error = 0;
	addr = expression();	
	if (expression_error)
	{
		qwhat();
		return;
	}
	printf("call %d\n", addr);
	addr += 197632;
	asm("ld.w r0, [r13 + (-4)]\ncallr r0\n");
	//asm("mov.w r1, jump_buff\nmov.w r0, 2\nst.s [r1], r0\nadd.w r1, 2\nld.w r0, [r13 + (-4)]\nst.w [r1], r0\nadd.w r1, 4\nmov.w r0, 128\nst.s [r1], r0\ncall jump_buff\n");
	init_stdio();
	init_files();
}

void exec_exec()
{
	char s[32];
	int i;
	
	ignore_blanks();
	if (*txtpos < 'A' || *txtpos > 'Z')
	{
		qwhat();
		return;
	}	
	
	//printf("address of txtpos: %d\n", txtpos);
	for (i = 0; txtpos[i] != NL && txtpos[i] != CR && i < 32; i++)
	{
		//printf("txtpos: %d ", txtpos[i]);
		s[i] = txtpos[i];
	}
	s[i] = 0;

	printf("Loading program: %s\n", s);
	i = read_file(buffer, s);
	if (i > 0) 
	{
		asm("call 197632\n");
		init_stdio();
		init_files();
	} 
	else 
	{
		printf("Error loading program %s\n", s);
	}
}

int direct()
{
#if DEBUG == 1
	printf("Vratio: %s", txtpos);
#endif
	if (*txtpos == NL)
		return 0;

	scantable(keywords);

#if DEBUG == 1
	printf("interpreter: table_index is: %d\n", table_index);
#endif
	
#if DESKTOP == 0
	if (should_break())
	{
		return 0;
	}
#endif
	
	switch (table_index)
	{
	case KW_MEM:
	{
		exec_mem();
		return 0;
	}
	case KW_BYE:
	case KW_EXIT:
		return 1;
	case KW_PRINT:
	case KW_QMARK:
		exec_print();
		break;
	case KW_LIST:
		exec_list();
		break;
	case KW_RUN:
		current_line = program_start;
		exec_run();
		break;
	case KW_NEW:
		program_end = program_start;
		break;
	case KW_LET:
		assignment();
		break;
	case KW_IF:
		exec_if();
		break;
	case KW_GOTO:
		expression_error = 0;
		linenum = expression();
		if (expression_error || *txtpos != NL)
			qhow();
		current_line = findline();
		return 2;
	case KW_FOR:
		exec_for();
		break;
	case KW_NEXT:
		exec_next();
		break;
	case KW_GOSUB:
		exec_gosub();
		break;
	case KW_RETURN:
		if (!exec_return())
			return 1;
		break;
	case KW_END:
	case KW_STOP:
		// This is the easy way to end - set the current line to the end of program attempt to run it
		if (txtpos[0] != NL)
		{
			qwhat();
		}
		else
			current_line = program_end;
		break;
	case KW_INPUT:
		exec_input();
		break;
	case KW_CLS:
#if DESKTOP == 0
		cls();
#endif
		break;
	case KW_EDIT:
		return exec_edit();
	case KW_LOAD:
		exec_load();
		break;
	case KW_SAVE:
		exec_save();
		break;
	case KW_DIR:
		exec_dir();
		break;
	case KW_MODE:
		exec_mode();
		break;
	case KW_PLOT:
		exec_plot();
		break;
	case KW_LINE:
		exec_line();
		break;
	case KW_CIRCLE:
		exec_circle();
		break;
	case KW_DRAW:
		exec_draw();
		break;
	case KW_HELP:
		exec_help();
		break;
	case KW_DELAY:
		exec_delay();
		break;
	case KW_CURSOR:
		exec_cursor();
		break;
	case KW_POKE:
		exec_poke();
		break;
	case KW_EXEC:
		exec_exec();
		break;
	case KW_SYS:
		exec_sys();
		break;
	case KW_DEFAULT:
		assignment();
		break;
	default:
		return 0;
	}
	return 0;
}


int main()
{
	int res;

	program_start = program;
	program_end = program_start;
	bsp = program + kRamSize;  // Needed for printnum
	stack_limit = program + kRamSize - STACK_SIZE;
	variables_begin = stack_limit - 28 * VAR_SIZE;
	
	current_line = 0;

#if DESKTOP == 0
	init_stdio();
	current_video_mode = 0;
	video_mode(0);
	cls();
	init_files();
#endif
	printf("TinyBasic %s\n", kVersion);
	exec_mem();
	
	res = 0;
	while (1)
	{
		if (res != 3)
		{
			getln('>');
			toUppercaseBuffer();
			skip_to_end();
		}
		else
		{
			res = 0;
			toUppercaseBuffer();
		}
		// Now see if we have a line number
		linenum = testnum();

		ignore_blanks();

		if (linenum == 0)
		{
			do {
				res = direct();
				if (res == 1)
					return 0;
				if (res == 2)
				{
					txtpos = current_line + sizeof(LINENUM) + sizeof(char);
					continue;
				}
				ignore_blanks();
				if (*txtpos == NL || *txtpos != ':')
					break;
				txtpos++;
				ignore_blanks();
			} while (1);
		}
		else if (linenum == 0xFFFF)
		{
			qhow();
		}
		else
		{
			entered_with_line_num();
		}
	}
}
