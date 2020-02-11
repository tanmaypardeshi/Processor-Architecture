/*=====================================================================
 Assignment 5
 Title :            Copy a file
 Problem Statement: Write menu driven program in C using int86,int86x,intdos,intdosx
					functions for implementing following operations on file.
					* To copy a file

===================================================================== */

#include<stdio.h>
#include<conio.h>
#include<dos.h>

void main()
{
	union REGS i,o;
	struct SREGS sr;
	char far(fname1[128]);
	char far(fname2[128]);
	char far(buffer[256]);
	int h1,h2;
	clrscr();

	//*******************opening file 1 for reading content******
	printf("\nEnter File1 Name to be copied:");
	gets(fname1);
	i.h.ah=0X3D;
	i.x.dx=FP_OFF(fname1);
	sr.ds=FP_SEG(fname1);
	i.h.al=0X00;
	intdosx(&i,&o,&sr);
	h1=o.x.ax;
	if(o.x.cflag==0)
	{
		printf("\n\n\t %s File1 reading!!!",fname1);
	}
	else
	{
		printf("\nFile1 not reading!!!");
	}
	//*********************creating file 2********************
	printf("\n\nEnter new File2 name to be created:");
	gets(fname2);
	i.h.ah=0X3C;
	i.x.dx=fname2;
	i.x.cx=0X00;
	intdosx(&i,&o,&sr);
	if(o.x.cflag==0)
	{
		printf("\n\t%s File2 created!!!",fname2);
	}
	//*********************open file 2 in write mode**********
	i.h.ah=0X3D;
	i.x.dx=FP_OFF(fname2);
	sr.ds=FP_SEG(fname2);
	i.h.al=0X01;

	intdosx(&i,&o,&sr);
	h2=o.x.ax;
	if(o.x.cflag==0)
	{
		printf("\n\t%s File2 has opened in write mode",fname2);
	}
	//**************************reading data from file 1*******
	i.h.ah=0X3F;
	i.x.bx=h1;
	i.x.cx=0XFF;
	i.x.dx=FP_OFF(buffer);
	sr.ds=FP_SEG(buffer);
	intdosx(&i,&o,&sr);
	if(o.x.cflag==0)
	{
		printf("\n\t%s File1 reading!!!",fname1);
		printf("\n\t%u No of bytes reading",o.x.ax);
	}
	//**************************writing data to file 2*******
	i.h.ah=0X40;
	i.x.bx=h2;
	i.x.cx=0XFF;
	i.x.dx=FP_OFF(buffer);
	sr.ds=FP_SEG(buffer);
	intdosx(&i,&o,&sr);
	if(o.x.cflag==0)
	{
		printf("\n\t%s File1 writing!!!",fname1);
		printf("\n\t%u No of bytes writing",o.x.ax);
	}
	i.h.ah=0X3E;
	i.x.bx=h1;
	intdos(&i,&o);
	i.h.ah=0X3E;
	i.x.bx=h2;
	intdos(&i,&o);
	getch();
}