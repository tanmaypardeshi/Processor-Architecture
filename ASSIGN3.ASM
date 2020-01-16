.model small
.stack 100h

;----------------------
;DATA SEGMENT
;----------------------
.data
	chc db 13,10,"Choose Operation: $"
	chc1 db 13,10," 1. Display Length $"
	chc2 db 13,10," 2. Display Reverse $"
	chc3 db 13,10," 3. Check Palindrome $"
	chc4 db 13,10," 4. Exit $"
	chc5 db 13,10,"Enter your choice:- $"
	len dw 00h
	string db 40 dup(?)
	result db 40 dup(?)
	msg db 13,10,"Please enter the String:- $"
	msg1 db 13,10,"The entered String is:- $"
	msg2 db 13,10,"The length of the entered String is:- $"
	msg3 db 13,10,"The reverse of the entered String is:- $"
	pal db 13,10,"The String is a Palindrome. $"
	npal db 13,10,"The String is not a Palindrome. $"
	newl db 13,10," $"
	
;----------------------
;MACROS
;----------------------	

initz macro
	mov ax,@data
	mov ds,ax
endm	

print macro m
	lea	dx,m
	mov	ah,9h
	int	21h
endm

;----------------------
;CODE
;----------------------	

.code

	initz
	
	l: 
		print	chc
		print chc1
		print chc2
		print chc3
		print chc4
		print newl
		print chc5
		

		mov ah,01h
		int 21h
		sub al,30h

		cmp al,04h
		jz exit

;----------------------
;PALINDROME
;----------------------
	cmp	al,03h
	jne	n1
	call	Palindrome
		
;----------------------
;REVERSE
;----------------------

	n1: 
		cmp al,02h 
		jne n2   
	call Reverse
	
	
;----------------------
;STRLEN
;----------------------

	n2: 
		cmp	al,01h
		jne	l
	call Strlen
	jmp
			
;----------------------
;EXIT
;----------------------

	exit: 
		mov	ah,4ch
		int	21h
		
;----------------------
;PROCEDURES
;----------------------

Palindrome proc far
	print	msg
		
	lea	si, string
	mov	len, 0

	loop1:
		mov	ah, 01h
		int	21h
		mov	[si], al
		inc	si
		inc	len
		cmp	al, 13
		jne	loop1

	sub 	len, 1

	lea	si, string
	lea	di, string
	add	di, len
	sub	di, 1
	mov	cx, len

	loop3:
		mov al, [si]
		mov bl, [di]
		cmp al, bl
		jne nopal
		inc si
		dec di
		dec cx
		jnz loop3

	print pal
	jmp palend


	nopal:
		print npal

	palend:
		jmp l
Palindrome endp

Reverse proc far
	print msg

	lea 	si, string

	read:
		mov	ah, 01h
		int	21h
		mov	[si], al
		inc	si
		cmp	al, 13
		jnz	read

	mov	ax, si
	lea	bx, string
	sub	ax, bx

	lea	di, result
	add	di, ax
	dec	di
	dec	di

	print	msg1
	print string
	print msg3

	lea si, string

	reverse_string:
		mov	al, [si]
		mov	[di], al
		inc	si
		dec	di
		cmp	si,13
		jnz	reverse_string

	print	result
	jmp	l
	
Reverse endp

Strlen proc far
	mov	len,00h
	print	msg
	
	lea 	si,string
	mov	ah,01h
	l1:
		int	21h		
		cmp	al,13
		je 	loopend
	
		mov	[si],al
		inc	si
		inc	len
		jmp 	l1
	
	loopend:
		mov	al,'$'
		mov	[si],al
		
		print	msg1
		print string
		print msg2
	
		xor	dx,dx
		mov	dx,len
		add	dx,30h
	
		mov	ah,02h
		int	21h
		
	jmp	l

Strlen endp

end

