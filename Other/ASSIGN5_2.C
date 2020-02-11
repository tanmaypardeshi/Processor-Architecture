/*=====================================================================
 Assignment 5   (using intdosx,intdos)
 Title :	    Delete a file, Create a directory  
 Problem Statement: Write menu driven program in C using int86,int86x,intdos,intdosx
					functions for implementing following operations on file.
					1. To delete a file
					2. To create a directory
 

===================================================================== */

#include<dos.h>
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

char dirname[50];
char filename[20];
union REGS i,o;
struct SREGS s;

void CRDIR()
{
	printf("\nEnter the directory name:\n");
	scanf("%s",dirname);

	i.h.ah=0x39;//load the function to create directory
	i.x.dx=FP_OFF(dirname);
	s.ds=FP_SEG(dirname);

	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nERROR IN CREATING DIRECTORY\n");
		else
		printf("\nDIRECTORY IS CREATED\n");
}
void DELFILE()
{
	printf("\nEnter the filename to delete:\n");
	scanf("%s",filename);

	i.h.ah=0x41;//del file
	i.x.dx=FP_OFF(filename);

	intdos(&i,&o);
	if(o.x.cflag)
		printf("\nERROR!!!\n");
	else
		printf("\n\FILE IS DELETED!!!");
}

int main()
{
	void CRDIR();
	void DELFILE();

	char *file;
	char *dir;
	int ch,t;
	clrscr();

	do{
		printf("\n\nFile Operations\n1.Create a directory\n2.Delete a file\n3.Exit\n\nEnter your choice:=>");
		scanf("%d",&ch);
		switch(ch)
		{
			case 1:CRDIR();
				break;
			case 2:DELFILE();
				break;
			case 3: exit(1);

		default:printf("\nInvalid choice\n");
		}
		printf("\nDo you want to continue?(1/0)");
		scanf("%d",&t);
	}while(t==1);

	getch();
	return 0;
}
