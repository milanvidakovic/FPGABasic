#include <stdio.h>
//#include <files.h>
#include <string.h>

#define H_MAX 4
char _history[H_MAX][256];
int n[10];

int main() 
{
	char s[1000];
	char *d = "tekst";
	int i, j, k;

	init_stdio();
	cls();

	n[3] = 5;
	n[-3] = 6;
	printf("%d, %d\n", n[3], n[-3]);
	delay(2000);
	printf("2\n");
	printf("Starting counting (10 million)...\n");
	i = get_millis();
	for (j = 0; j < 10000000; j++) 
		;
	k = get_millis();
	printf("start time:\t%d\n", i);
	printf("end time:\t%d\n", k);
	printf("delta: %d, %d\n", k - i, (k - i)/1000);
	/*
	init_stdio();
	strcpy(_history[0], d);
	printf("This is _history[0]: %s\n", _history[0]);
	printf("This is original: %s\n", d);
	gets(s);
	printf("Received: %s", s);
	*/
	return 0;
	/*
	init_files();
	ls_files(s);
	printf(s);
	printf("%d\n", i);
	for (j = 0; j < 20; j++)
	{
		i = read_file(s, "test.bas");
		printf("%d\n", i);
		printf(s);
		s[0] = 0;
		i = read_file(s, "PERA");
		printf("%d\n", i);
		printf(s);
		ls_files(s);
		printf(s);
		printf("\n%d\n", j);
		
		printf("dalje (y/n)");
		s[0] = 0;
		gets(s);
		if (s[0] == 'n')
			break;

	}	
	*/
	/*
	printf("test2: %d\n", i);
	s[0] = 0;
	gets(s);
	printf("%s\n", s);
	*/
}