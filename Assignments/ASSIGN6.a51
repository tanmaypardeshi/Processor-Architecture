ORG 00H					;originate to 00h
MOV A,#10H				;mov 10 to A
MOV R0,#40H				;mov 40h to r0 (address of internal ram in r0)
MOV R1,#5				;mov 5h to r1 (used for counter)

PUTNUMBER:
	MOV @R0,A
	INC A
	INC R0
	DJNZ R1,PUTNUMBER

MOV A,#0H
MOV R0,#40H
MOV R1,#5

ADDNUMBER:
	ADD A,@R0
	INC R0
	DJNZ R1,ADDNUMBER

MOV R6,A
END