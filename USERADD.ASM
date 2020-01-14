.MODEL  SMALL
.STACK  100H
.DATA

MSG1    DB      'Enter the first number:- $'
MSG2    DB      13,10,'Enter the second number:- $'
MSG3    DB      13,10,'Addition is:- $'
CHAR    DB      0

.CODE
	  MOV     AX,@data
        MOV     DS,AX

        MOV     AH,09H
        LEA	    DX,MSG1		
        INT     21H

        MOV     AH,01H
        INT     21H
        SUB     AL,30H
        MOV     BL,AL

        MOV     AH,09H
        LEA	    DX,MSG2		
        INT     21H

        MOV     AH,01H
        INT     21H
        SUB     AL,30H


        MOV     AH,09H
        MOV     DX,SEG MSG3
        MOV     DS,DX
        MOV     DX,OFFSET MSG3
        INT     21H

        ADD     AL,BL
        MOV     AH,00H
        AAA
        ADD     AH,30H
        MOV     BX,AX
        MOV     DL,BH
        MOV     AH,02H
        INT     21H

        ADD     BL,30H
        MOV     DL,BL
        MOV     AH,02H
        INT     21H

        MOV     AH,4CH
        INT     21H

END
