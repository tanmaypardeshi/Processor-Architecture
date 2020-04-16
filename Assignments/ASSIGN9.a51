;--------------------------------------------------------
;Roll number 23260
;Batch H10
;Write ALP to interface 8051 with: LCD to display message.
;---------------------------------------------------------

	;calls a time delay before sending next data/command
	;P2.0-P2.7 are connected to LCD data pins D0-D7
	;P1.0 is connected to RS pin of LCD
	;P1.1 is connected to R/W pin of LCD
	;P1.2 is connected to E pin of LCD

	ORG 	0H
	MOV 	A,#38H 		;INIT. LCD 2 LINES, 5X7 MATRIX
	ACALL 	COMNWRT 	;call command subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#0EH 		;display on, cursor on
	ACALL 	COMNWRT 	;call command subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#01 		;clear LCD
	ACALL 	COMNWRT 	;call command subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#06H 		;shift cursor right
	ACALL 	COMNWRT 	;call command subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#080H 		;cursor at line 1, pos.0 
	ACALL 	COMNWRT 	;call command subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#'P' 		;display letter P
	ACALL 	DATAWRT 	;call display subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#'I' 		;display letter I
	ACALL 	DATAWRT 	;call display subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#'C' 		;display letter C
	ACALL 	DATAWRT 	;call display subroutine
	ACALL 	DELAY 		;give LCD some time
	MOV 	A,#'T' 		;display letter T
	ACALL 	DATAWRT 	;call display subroutine
AGAIN: SJMP 	AGAIN 	;stay here
COMNWRT: 				;send command to LCD
	MOV 	P2,A 			;copy reg A to port 1
	CLR 	P1.0 			;RS=0 for command
	CLR 	P1.1 			;R/W=0 for write
	SETB 	P1.2 			;E=1 for high pulse
	ACALL 	DELAY 		;give LCD some time
	CLR 	P1.2 			;E=0 for H-to-L pulse
	RET
DATAWRT: 				;write data to LCD
	MOV 	P2,A 			;copy reg A to port 1
	SETB 	P1.0 			;RS=1 for data
	CLR 	P1.1 			;R/W=0 for write
	SETB 	P1.2 			;E=1 for high pulse
	ACALL 	DELAY 		;give LCD some time
	CLR 	P1.2 			;E=0 for H-to-L pulse
	RET
DELAY: 	MOV 	R3,#50 	;50 or higher for fast CPUs
HERE2: 	MOV 	R4,#255 	;R4 = 255
HERE: 	DJNZ 	R4,HERE 	;stay until R4 becomes 0
	DJNZ 	R3,HERE2
	RET
	END

