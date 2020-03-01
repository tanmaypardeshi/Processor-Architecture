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
	char far(filename[20]), far(newfile[20]);
	int h1, h2, bytes;
	char far(buffer[512]);

	printf("\nEnter the name of the file to be copied :\n");
	scanf("%s",filename);

	in.h.ah = 0x3D;	//open file in read mode
	in.x.dx = FP_OFF(filename);
	s.ds = FP_SEG(filename);
	in.h.al = 0x00;
	int86x(0x21, &in, &out, &s);
	h1 = out.x.ax;

	if(out.x.cflag)
		printf("\nError! File could not be read.\n",filename);
	
	printf("\nEnter a name for the new file :\n");
	scanf("%s",newfile);

	in.h.ah = 0x3C;
	in.x.dx = FP_OFF(newfile);
	in.x.cx = 0x00;
	int86(0x21, &in, &out);

	if(!out.x.cflag)
		printf("\nNew file created!\n");
		
	in.h.ah = 0x3D;	//open file in write mode
	in.x.dx = FP_OFF(newfile);
	in.h.al = 0x01;
	int86(0x21, &in, &out);
	h2 = out.x.ax;
	
	
	in.h.ah = 0x3F;	//read file
	in.x.bx = h1;
	in.x.cx = 0xFF;
	in.x.dx = FP_OFF(buffer);
	s.ds = FP_SEG(buffer);
	int86x(0x21, &in, &out, &s);
	bytes = out.x.ax;
	
	if(!out.x.cflag)
	{
		printf("\nReading file....\n");
		printf("\nReading %u bytes..\n",out.x.ax);
	}
	
	in.h.ah = 0x40;	//write to file
	in.x.bx = h2;
	in.x.cx = bytes;
	in.x.dx = FP_OFF(buffer);
	s.ds = FP_SEG(buffer);
	int86x(0x21, &in, &out, &s);
	
	
	if(out.x.cflag)
		printf("\nError copying file!\n");
	else
	{
		printf("\Writing %u bytes..\n",out.x.ax);
		printf("\nFile copied successfully!\n");
	}

	in.h.ah = 0x3E;	//close file
	in.x.dx = h1;
	int86(0x21, &in, &out);
	
	in.h.ah = 0x3E;	//close file
	in.x.dx = h2;
	int86(0x21, &in, &out);
}
