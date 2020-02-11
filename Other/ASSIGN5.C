#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<dos.h>
#define SIZE 50

union REGS in,out;

//function declaration
void createdir();

void main()
{
	int choice;

	clrscr();

	while(1)
	{
		printf("\nC programming using DOS functions\n");
		printf("1. Delete file\n");
		printf("2. Create directory\n");
		printf("3. Copy file\n");
		printf("4. Exit program\n");
		printf("\nEnter your choice:- ");
		scanf("%d", &choice);

		switch(choice)
		{
			case 1:
				createdir();
				break;
			case 2:
		  //		deletefile();
				break;
			case 3:
			case 4:
				exit(0);
		}
	}
	getch();
}


void createdir()
{
	char dirname[50];
	flushall();
	printf("Enter directory name:- ");
	gets(dirname);

	in.x.dx=(int)&dirname;
	in.h.ah=0x39;

	if(!out.x.cflag)
		printf("Directory created successfully\n");
	else
		printf("Directory could not be created\n");
}