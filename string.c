int strlen(char *c) 
{
	int res = 0;
	while(*(c++))
	{
		res++;
	}
	return res;
}

int strcmp(char* s1, char* s2)
{
  char c1, c2;
  do
  {
      c1 = *s1++;
      c2 = *s2++;
      if (c1 == '\0')
        return c1 - c2;
  } while (c1 == c2);
  return c1 - c2;
}

void* memcpy(void* dest, void* src, int len)
{
  char *d = dest;
  char *s = src;
  while (len--)
    *d++ = *s++;
  return dest;
}

char* strcpy (char* dest, char* src)
{
  return memcpy(dest, src, strlen (src) + 1);
}

char* strncpy(char *s1, char *s2, int n)
{
  return memcpy (s1, s2, n);
}

char* strstr(char* string, char* substring)
{
  char *a, *b;

  /* First scan quickly through the two strings looking for a
   * single-character match.  When it's found, then compare the
   * rest of the substring.
   */

  b = substring;
  if (*b == 0) 
  {
		return string;
  }
  for ( ; *string != 0; string += 1) 
  {
		if (*string != *b) {
    	continue;
		}
		a = string;
		while (1) 
		{
    	if (*b == 0) 
    	{
				return string;
    	}
    	if (*a++ != *b++) 
    	{
				break;
    	}
		}
		b = substring;
  }
  return (char *) 0;
}

char* strcat(char* dest, char* src)
{
  strcpy (dest + strlen (dest), src);
  return dest;
}
