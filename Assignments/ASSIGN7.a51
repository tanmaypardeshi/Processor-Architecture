;------------------------------------------------------------------
;Roll number 23260
;Batch H10
;Transger of memory, internal to internal and internal to external
;------------------------------------------------------------------

    MOV R0,#4BH
	MOV R1,#30H
	MOV R2, #10
XYZ:
	MOV A,@R0
	MOV @R1,A
	INC R0
	INC R1
	DJNZ R2,XYZ
	END
