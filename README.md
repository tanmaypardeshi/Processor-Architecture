# Processor Architecture and Interfacing Assignemnts

## All Processor Architecture and Interfacing Assignments of SPPU Second Year IT Syllabus

### Contains examples of microprocessor(8086), microcontroller(8051) programs.

### Find the lab manual here: [Processor Architecture and Interfacing](PIL.pdf)

## Table of Contents for Assignments

| Program Name                     | Problem Statement                    |
| :-----------------------------:  | :--------------------------------    |
|[ASSIGN1.ASM](Assignments/ASSIGN1.ASM)|Write Assembly Language Program (ALP) to add array of N numbers stored in the memory.|
|[ASSIGN2.ASM](Assignments/ASSIGN2.ASM)|Write menu driven ALP to convert 4-digit Hex number into its equivalent BCD number and 5-digit BCD number into its equivalent HEX number. Make your program user friendly to accept the choice from user for i) HEX to BCD ii) BCD to HEX iii) EXIT. Display proper strings to prompt the user while accepting the input and displaying the result. Write near procedure to complete the task.|
|[ASSIGN3.ASM](Assignments/ASSIGN3.ASM)|Write ALP to perform following operations on string: i. Find and display length ii. Display reverse iii. Check whether string is palindrome or not. Display proper strings to prompt the user while accepting the input and displaying the result. Write near procedures to complete the task.|
|(ASSIGN4.ASM)[Assignments/ASSIGN4.ASM]|Write menu driven ALP to perform string manipulations. The strings to be accepted from the user is to be stored in code segment Module_1 and write FAR PROCEDURES in code segment Module_2 to perform any two of the following string operations: i) Concatenation of two strings ii) Comparison of two strings iii) Finding Number of occurrences of a sub-string in the given string iv) Finding number of alphabets, digits, special characters, lower & upper case alphabets, word and number of lines from the text.Note: Use PUBLIC and EXTERN directives. Create .OBJ files of both the modules and link them to create an .EXE file.
|[STRINOP.ASM](Assignments/STRINOP.ASM)|Assembly file containing procedures required for ASSIGN4.ASM|
|[ASSIGN5.ASM](Assignments/ASSIGN5.C)|Write menu driven program in C using int86(), int86x(), intdos() and intdosx() functions for implementing following operations on file. i. To delete a file ii. To create a directory iii. To copy a file|
|[ASSIGN6.a51](Assignments/ASSIGN6.a51)|Write 8051 ALP to add n, 8 bits numbers found in internal ram location 40H onwards and store results in R6 and R7.|
|[ASSIGN7.a51](Assignments/ASSIGN7.a51)|Write 8051 ALP for the block transfer for internal / external memory.|
|[ASSIGN8.a51](Assignments/ASSIGN8.a51)|Serial port programming: ISR based Connect two 8051 microcontrollers using serial ports. Send FFh and 00h alternatively to receiver. Output received byte to port1, see port pin waveform on CRO.|
|[ASSIGN9.a51](Assignments/ASSIGN9.a51)|Write ALP to interface 8051 with: LCD to display message.|
|[ASSIGN10.a51](Assignments/ASSIGN10.a51)|Write ALP to interface 8051 with: Stepper motor to rotate motor with different step angles and speeds.|


## Table of Contents for Basic Programs

| Program Name                     | Problem Statement                    |
| :-----------------------------:  | :--------------------------------    |
|[ARR.ASM](Initial/ARR.ASM)|Example 1 of array|
|[ARR1.ASM](Initial/ARR1.ASM)|Example 2 of array|
|[ARR2.ASM](Initial/ARR2.ASM)|Example 3 of array|
|[ARRADD.ASM](Initial/ARRADD.ASM)|Addition of array|
|[EXAM.ASM](Initial/EXAM.ASM)|Example of TASM program|
|[HELWORLD.ASM](Initial/HELWORLD.ASM)|Example of hello world in TASM|
|[LOOP.ASM](Initial/LOOP.ASM)|Example of loops in TASM|
|[MACRO.ASM](Initial/MACRO.ASM)|Example of macro|
|[PICT.ASM](Initial/PICT.ASM)|Example of TASM|
|[PROC.ASM](Initial/PROC.ASM)|Example of procedures|
|[USERADD.ASM](Initial/USERADD.ASM)|Input from user and add example 1|
|[USERADD2.ASM](Initial/USERADD2.ASM)|Input from user and add example 2|


## Table of Contents for Basic String Programs in TASM


| Program Name                     | Problem Statement                    |
| :-----------------------------:  | :--------------------------------    |
|[PALIN.ASM](String/PALIN.ASM)|String palindrome example|
|[STRCAT.ASM](String/STRCAT.ASM)|String concantenation example|
|[STRCMP.ASM](String/STRCMP.ASM)|String compare example|
|[STRLEN.ASM](String/STRLEN.ASM)|String length example|
|[STRREV.ASM](String/STRREV.ASM)|String reverse example|
|[SUBSTR.ASM](String/SUBSTR.ASM)|String substring example|