#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<dos.h>
#define SIZE 50

union REGS in,out;
struct SREGS s;

//function declaration
void createdir();
void deletefile();
void copyfile();

void main()
{
	int choice;

	clrscr();

	while(1)
	{
		printf("\nC programming using DOS functions\n");

		printf("1. Create directory\n");
		printf("2. Delete file\n");
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
				deletefile();
				break;
			case 3:
				copyfile();
				break;
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

	intdos(&in,&out);

	if(!out.x.cflag)
		printf("Directory created successfully\n");
	else
		printf("Directory could not be created\n");
}


void deletefile()
{
	char filename[50];
	flushall();
	printf("\nEnter the filename to delete:-");
	gets(filename);

	in.h.ah=0x41;
	in.x.dx=FP_OFF(filename);

	intdos(&in,&out);

	if(!out.x.cflag)
		printf("\nFile deleted successfully\n");
	else
		printf("\nError\n");
}

void copyfile()
{
	char far(filename1[128]);
	char far(filename2[128]);
	char far(buffer[256]);
	int h1,h2;
	
	flushall();
	printf("\nEnter name of the file to be copied:- ");
	gets(filename1);
	in.h.ah=0X3D;
	in.x.dx=FP_OFF(filename1);
	s.ds=FP_SEG(filename1);
	in.h.al=0X00;
	intdosx(&in,&out,&s);
	h1=out.x.ax;
	if(!out.x.cflag)
		printf("\n\n Reading file: - %s",filename1);
	else
		printf("\nNot reading file:- %s", filename1);

	printf("\n\nEnter new filename to be created:- ");
	gets(filename2);
	in.h.ah=0X3C;
	in.x.dx=FP_OFF(filename2);
	in.x.cx=0X00;
	intdosx(&in,&out,&s);
	
	if(out.x.cflag==0)
		printf("\nCreated file: -%s",filename2);
	
	in.h.ah=0X3D;
	in.x.dx=FP_OFF(filename2);
	s.ds=FP_SEG(filename2);
	in.h.al=0X01;

	intdosx(&in,&out,&s);
	h2=out.x.ax;
	if(!out.x.cflag)
		printf("\nFile %s opened in write mode",filename2);
	
	in.h.ah=0X3F;
	in.x.bx=h1;
	in.x.cx=0XFF;
	in.x.dx=FP_OFF(buffer);
	s.ds=FP_SEG(buffer);
	intdosx(&in,&out,&s);
	if(!out.x.cflag)
	{
		printf("\nReading file %s",filename1);
		printf("\nBytes read:- %u",out.x.ax);
	}
	
	
	in.h.ah=0X40;
	in.x.bx=h2;
	in.x.cx=0XFF;
	in.x.dx=FP_OFF(buffer);
	s.ds=FP_SEG(buffer);
	intdosx(&in,&out,&s);
	if(!out.x.cflag)
	{
		printf("\nWriting file %s",filename1);
		printf("\nBytes written:- %u",out.x.ax);
	}
	in.h.ah=0X3E;
	in.x.bx=h1;
	intdos(&in,&out);
	in.h.ah=0X3E;
	in.x.bx=h2;
	intdos(&in,&out);
}
