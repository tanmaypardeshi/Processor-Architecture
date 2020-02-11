;----------------------------------------------------------------------------------------------------
; Assignment No: 1
; Title: 		Array Addition 
; Problem Statement: 	Write Assembly Language Program to add array of N numbers stored in the memory
;
;----------------------------------------------------------------------------------------------------

 PRINT MACRO MSG
 MOV AH,09H
 LEA DX,MSG
 INT 21H
 ENDM

.MODEL SMALL
.STACK 100H

 .DATA
    PROMPT  DB  'The Array elements are : $'
    RESULT  DB  10,13,'The Sum of the Array is = $'
    ARRAY   DB  1,2,3,4,5,6,7,8,9,10

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     MOV BX, 10                   ; set BX=10

     PRINT PROMPT

     MOV CX, BX                   ; set CX=BX
     LEA SI, ARRAY                ; set SI=offset address of ARRAY

     L:                       ; loop label
       MOV AH,0H                 ; clear AH
       MOV AL, [SI]               ; set AX=[SI]

       CALL OUTDEC                ; call the procedure OUTDEC

       INC SI                     ; set SI=SI+1

       MOV AH, 2                  ; set output function
       MOV DL, 20H                ; set DL=20H
       INT 21H                    ; print a character
     LOOP L                   ; jump to label LOOP while CX!=0

     PRINT RESULT               ; load and display the string RESULT

     LEA SI, ARRAY                ; set SI=offset address of ARRAY

     CALL SUM                     ; call the procedure SUM
     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP

 ;**************************************************************************;
 ;**************************************************************************;
 ;-------------------------  Procedure Definitions  ------------------------;
 ;**************************************************************************;
 ;**************************************************************************;

 ;**************************************************************************;
 ;---------------------------------  SUM  ----------------------------------;
 ;**************************************************************************;

 SUM PROC
   ; this procedure will calculate the sum of an array
   ; input : SI=offset address of the array
   ;       : BX=size of the array
   ; output : AX=sum of the array

   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK

   MOV AX, 0H                     ; clear AX
   MOV DX, 0H                     ; clear DX
   MOV CX, BX                     ; set CX=BX

   S:                          ; loop label
     MOV DL, [SI]                 ; set DL=[SI]
     ADD AX, DX                   ; set AX=AX+DX
     INC SI                       ; set SI=SI+1
   LOOP S                      ; jump to label SUM while CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX

   RET                            ; return control to the calling procedure
 SUM ENDP

 ;**************************************************************************;
 ;--------------------------------  OUTDEC  --------------------------------;
 ;**************************************************************************;

 OUTDEC PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK

   CMP AX, 0                      ; compare AX with 0
   JGE START                     ; jump to label START if AX>=0

   PUSH AX                        ; push AX onto the STACK

   MOV AH, 2                      ; set output function
   MOV DL, "-"                    ; set DL='-'
   INT 21H                        ; print the character

   POP AX                         ; pop a value from STACK into AX

   NEG AX                         ; take 2's complement of AX

   START:                        ; jump label

   MOV CX, 0H                     ; clear CX
   MOV BX, 10                     ; set BX=10

   OUTPUT:                        ; loop label
     MOV DX, 0H                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE OUTPUT                    ; jump to label OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   DISP:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP DISP                  ; jump to label DISPLAY if CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
 OUTDEC ENDP

 ;**************************************************************************;
 ;--------------------------------------------------------------------------;
 ;**************************************************************************;

 END MAIN
