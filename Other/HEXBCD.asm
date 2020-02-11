;=====================================================================
; Assignment 2
; Title :            HEX to BCD, BCD to HEX
; Problem Statement: Write menu driven ALP to convert 4-digit Hex number
;	             into its equivalent BCD no.and 5-digit BCD no.into 	
;		     its equivalent HEX no. Make your program user 
;	             friendly to accept the choice from user for
;                    i)Hex to BCD ii)BCD to HEX iii)EXIT
;                    Display proper string to prompt the user while 
;                    accepting the input and displaying the result.
;                    Write near procedure to complete the task.
;
; 
;=====================================================================

.model small

disp macro msg
mov ah,09h
lea dx,msg
int 21h
endm

.stack
.data

msg0 db 10,13, '$'
msg1 db 10,13, '======MEMU======$'
msg2 db 10,13, '1:HEX TO BCD $'
msg3 db 10,13, '2:BCD TO HEX $'
msg31 db 10,13,'3:EXIT $'
msg4 db 10,13, 'Enter your choice :: $'
msg5 db 10,13, 'Enter 4 digit hex number :: $'
msg6 db 10,13, 'Equivalent bcd number is :: $'
msg7 db 10,13, 'Enter 5 digit bcd number :: $'
msg8 db 10,13, 'Equivalent hex number is ::$'
msg9 db 10,13, 'Invalid entry!!!$'
op db 10 dup(?)

.code
main:   mov ax,@data
        mov ds,ax

menu:   disp msg1
        disp msg2
        disp msg3
        disp msg31
        disp msg4

        mov ah,01h
        int 21h

        cmp al,31h
        je hex

        cmp al,32h
        je bcd

        cmp al,33h
        je exit
        disp msg9
        jmp menu

hex:    disp msg5
        call inputp
        disp msg6
        call hexp
        jmp menu

bcd:    disp msg7
        call inp1
        call bcdp   
        disp msg8
        call disp1
        jmp menu

exit:   mov ah,4ch
        int 21h

inputp proc near
        mov cx,0404h
        mov ax,0000h
        mov bx,0000h

in1:     mov ah,01h
        int 21h
        cmp al,30h
        jb invalid
        cmp al,39h
        jg a1
        sub al,30h
        jmp insert

a1:     cmp al,41h
        jb invalid
        cmp al,46h
        jg a2
        sub al,37h
        jmp insert

a2:     cmp al,61h
        jb invalid
        cmp al,66h
        jg invalid
        sub al,57h
        jmp insert

insert:
        shl bx,cl
        add bl,al
        dec ch
        jnz in1
        
        ret

invalid:
        disp msg9
        jmp menu
        
inputp endp

hexp proc near
        mov ax,bx
        mov bx,0010
        mov cl,00
        
b1:     mov dx,00h
        div bx
        push dx
        inc cx
        cmp ax,00h
        jne b1

b2:     pop dx
        ;and dl,0fh
        add dl,30h
        mov ah,02h
        int 21h
        dec cl
        jnz b2
        ret

hexp endp

inp1 proc near
        lea si,op
        mov cl,05
 c1:
        mov ah,01h
        int 21h
        cmp al,30h
        jb invalid1
        cmp al,39h
        jg invalid1
        sub al,30h
        mov [si],al
        inc si
        dec cl

        jnz c1

        ret
invalid1:
        disp msg9
c2:     ret

inp1 endp


bcdp proc near
        
        mov bx,0000h
        mov cx,0000h
        mov dx,0000h
        lea si,op
        
        mov ax,10000
        mov bl,[si]
        mul bx
        add cx,ax
        inc si

        mov ax,1000
        mov bl,[si]
        mul bx
        add cx,ax
        inc si

        mov ax,100
        mov bl,[si]
        mul bx
        add cx,ax
        inc si

        mov ax,10
        mov bl,[si]
        mul bx
        add cx,ax
        inc si

        mov ax,1
        mov bl,[si]
        mul bx
        add cx,ax

        ;mov bx,cx

        ret
bcdp endp

disp1 proc near

        ;mov ax,dx
        mov dx,0000h
        mov bx,cx
        mov cx,0404h

d2:     rol bx,cl
        mov dx,00h
        mov dl,bl
        and dl,0fh
        cmp dl,09h
        jbe d1

        add dl,07h

d1:     add dl,30h
        mov ah,02h
        int 21h
        inc si
        dec ch
        jnz d2
        ret
disp1 endp

end
