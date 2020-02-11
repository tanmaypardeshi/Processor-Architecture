;--------------------------------------------------------------------------------------------
;
;Assignment3: Write ALP to perform following operations on string: 
;	i.Find and display length
;	ii.Display reverse
;	iii.Check whether string is palindrome or not.
;	Display proper strings to prompt the user while accepting the input and displaying the result. Write near procedures to complete the task.
;
;
;
;--------------------------------------------------------------------------------------------------------

% TITLE "String Operations"

disp macro msg
lea dx,msg
mov ah,09h
int 21h
endm

.model small
.data
str1 db 25,?,25 dup('$')
str2 db 25,?,25 dup('$')
msg1 db 10,13,'Enter string :$'
msg2 db 10,10,13,'*******String Operations*******$'
msg3 db 10,13,'1.Lenght$'
msg4 db 10,13,'2.Reverse string$'
msg5 db 10,13,'3.Palindrome$'
msg6 db 10,13,'4.Exit$'
msg7 db 10,10,13,'Enter Your choice=>$'
msg8 db 10,10,13,'Length of string is:$'
msg9 db 10,10,13,'Reverse string is:$'
msg10 db 10,10,13,'String is palindrome!$'
msg11 db 10,10,13,'String is not palindrome!$'
msg12 db 10,10,13,'Good Bye!!!$'


.code
start:
mov ax,@data
mov ds,ax
mov es,ax

disp msg1
call accept
menu:
disp msg2
disp msg3
disp msg4
disp msg5
disp msg6
disp msg7

mov ah,01h
int 21h

cmp al,31h
jz A
cmp al,32h
jz B
cmp al,33h
jz C
cmp al,34h
jz D

A: 
disp msg8
call length1
jmp menu

B: 
call reverse
disp msg9
call display1
jmp menu

C: 
call palindrome
jmp menu

D: 
disp msg12 
mov ah,04ch
int 21h

accept proc near
mov ah,0Ah
lea dx, str1
int 21h
ret
endp

display1 proc near
lea dx, str2+2
mov ah,09h
int 21h
ret
endp

length1 proc near
mov dl,str1+1
add dl,30h
mov ah,02h
int 21h
ret
endp

reverse proc near
xor cx,cx
mov cl,str1+1
lea si,str1+1
add si,cx
lea di,str2+2

back: mov bh,[si]
mov [di], bh
dec si
inc di
loop back
ret
endp

palindrome proc near
call reverse
xor cx,cx
mov cl,str1+1
lea si, str1+2
lea di, str2+2

cld
rep cmpsb

jz next
disp msg11
jmp l1
next: disp msg10
l1: ret
endp


end
