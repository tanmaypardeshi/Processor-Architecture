;--------------------------------------------------------
;Roll number 23260
;Batch H10
;Write ALP to interface 8051 with: LCD to display message.
;---------------------------------------------------------

	MOV	81H,#30H	;Initialize stack pointer

	MOV	A,#3CH		
	LCALL	COMMAND

	MOV	A,#0EH		;Command for setting display cursor on
	LCALL 	COMMAND

	MOV	A,#01H		;Command for clearing display
	LCALL	COMMAND

	MOV	A,#06H		;Shift cursor right
	LCALL	COMMAND

	MOV	A,#0CH		;Cursor line 2, positiion 0
	LCALL	COMMAND

	MOV	A,#'H'		;Display letter H
	LCALL	DISPLAY

	MOV	A,#'E'		;Display letter E
	LCALL	DISPLAY
	
	MOV	A,#'L'		;Display letter L
	LCALL	DISPLAY
	
	MOV	A,#'L'		;Display letter L
	LCALL	DISPLAY
	
	MOV	A,#'O'		;Display letter O
	LCALL	DISPLAY


HERE:	SJMP	HERE

;Command routine
COMMAND:
	LCALL	READY		;Check if LCD is ready
	MOV	P1,A		;Issue command code
	CLR	P3.2		;Make RS=0 to issue command
	CLR	P3.3		;Make R/W=0 to enable writing
	SETB	P3.4		;Make E=1
	CLR	P3.4		;Make E=0
	RET	

;Display Routine
DISPLAY:
	LCALL	READY		;Check if LCD is ready
	MOV	P1,A		;Give data
	SETB	P3.2		;RS=1 TO get data
	CLR	P3.3		;Make R/W=0 to enable writing
	SETB	P3.4		;Make E=1
	CLR	P3.4		;Make E=0
	RET

;Ready routine
READY:
	CLR	P3.4		;Disable display
	CLR	P3.2		;RS = 0 in order to access command register
	MOV	P1,#0FFH	;Configure P1 as input port
	SETB	P3.3		;R/W=1 to enable writing
	L1:
		SETB	P3.4	;Make E=1
		JB	P1.7,L1	;Check D7 bit. If 1,LCD is busy wait till it becomes 0
		CLR	P3.4	;Make E=0 to disable display
		RET
END
