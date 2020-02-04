.model small
.stack 100h

.data
	msg1	db 10,13 'Enter string 1:- $'
	msg2	db 10,13 'Enter string 2:- $'
	good	db 10,13 'Strings are equal$'
	bad 	db 10,13 'Strings are unequal$'
	str1	db 20	dup('$')
	str2	db 20	dup('$')
	newline db 10,'$'
	
scall macro xx,yy
        lea dx,xx
        mov ah,yy
        int 21h
endm                    ;end of macro

.code
	
	mov ax,@data
	mov ds,ax

	scall m1,09h    ;display m1 string
	scall s1,0ah    ;buffered s1 string input

	scall m2,09h    ;display m2 string
	scall s2,0ah    ;buffered s2 string input

	lea si,s1
	lea di,s2
	mov bl,[si]
	mov cl,[di]     ;length of s1 string
	
	cld;
	
	repe	cmpsb
	
	je	equal
	jne	not_equal
	
	
	
