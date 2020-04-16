;--------------------------------------------------------
;Roll number 23260
;Batch H10
;Addition of n 8-bit numbers
;---------------------------------------------------------

MOV 40H,#01
MOV 41H,#02
MOV 42H,#03 
MOV 43H,#04
MOV 44H,#06
MOV R1,#05
MOV R0,#40H
MOV R6,#00H  ;STORES RESULT
MOV R7,#00H  ;STORES CARRY
BACK:MOV A,@R0
	ADD A,R6
	MOV R6,A
	MOV A,R7
	ADDC A,#00H
	MOV R7,A
	INC R0
	DJNZ R1,BACK
	MOV DPTR,#46H
	MOV A,R6
	MOV R0,A
END
