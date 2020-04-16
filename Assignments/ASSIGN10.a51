;--------------------------------------------------------
;Roll number 23260
;Batch H10
;Write ALP to interface 8051 with: Stepper motor to rotate 
;motor with different step angles and speeds.
;---------------------------------------------------------

;CLOCKWISE ROTATION

MAIN: 
	MOV A,#0AH
	MOV P0,A
	CALL DELAY
	MOV A,#06H
	MOV P0,A
	CALL DELAY
	MOV A,#05H
	MOV P0,A
	CALL DELAY
	MOV A,#09H
	MOV P0,A
	CALL DELAY
SJMP MAIN
DELAY: 
  	L2:  MOV R1,#0FFH
  	L1:  MOV R3,#0FFH
  	L3:  DJNZ R3,L3
        DJNZ R1,L1
        
      RET
 END
