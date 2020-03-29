;--------------------------------------------------------
;Roll number 23260
;Batch H10
;Write ALP to interface 8051 with: Stepper motor to rotate 
;motor with different step angles and speeds.
;---------------------------------------------------------

	MOV	A,#66H		;Load step sequence
	L1:
		MOV	P1,A	;Give sequence to motor	
		RR	A	;Rotate right clockwise
		ACALL	DELAY	;Wait for sometime
		SJMP	L1	;Continue

	DELAY:
		MOV	R2,#100
	L3:
		MOV	R3,#255
	L2:
		DJNZ	R3,L2
		DJNZ	R2,L3
		RET
END
