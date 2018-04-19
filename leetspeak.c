#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int	main(int argc, char **argv)
{
	int	i;
	char	*str;

	if (argc == 2)
	{
	i = strlen(argv[1]);
	str = (char*)malloc(sizeof(char) * i * 3);
	for (i = 0; argv[1][i]; i++)
	{
		if (argv[1][i] > 64 && argv[1][i] < 91)
			argv[1][i] += 32; 
		switch (argv[1][i])
		{
			case 'a':
				strcat(str,"4");
				break;
			case 'b':
				strcat(str,"8");
				break;
			case 'c':
				strcat(str,"(");
				break;
			case 'd':
				strcat(str,"|)");
				break;
			case 'e':
				strcat(str,"[-");
				break;
			case 'f':
				strcat(str,"/=");
				break;
			case 'g':
				strcat(str,"(_+");
				break;
			case 'h':
				strcat(str,":-:");
				break;
			case 'i':
				strcat(str,"!");
				break;
			case 'j':
				strcat(str,"_/");
				break;
			case 'k':
				strcat(str,"|<");
				break;
			case 'l':
				strcat(str,"[_");
				break;
			case 'm':
				strcat(str,"(||)");
				break;
			case 'n':
				strcat(str,"/|/");
				break;
			case 'o':
				strcat(str,"0");
				break;
			case 'p':
				strcat(str,"|o");
				break;
			case 'q':
				strcat(str,"°|");
				break;
			case 'r':
				strcat(str,"2");
				break;
			case 's':
				strcat(str,"$");
				break;
			case 't':
				strcat(str,"|¯");
				break;
			case 'u':
				strcat(str,"|_|");
				break;
			case 'v':
				strcat(str,"|/");
				break;
			case 'w':
				strcat(str,"|_|_/");
				break;
			case 'x':
				strcat(str,"><");
				break;
			case 'y':
				strcat(str,"`/");
				break;
			case 'z':
				strcat(str,"%");
				break;
			case' ':
				strcat(str,"*");
				break;
			default:
				break;
		}	
	}	
	printf("%s\n",str);
	}
	else 
		exit(EXIT_FAILURE);
	return EXIT_SUCCESS;
}
