.model small
.stack 100h
.data
	menu db 10, 13, 10, 13, '1. Calculate Length', 10, 13, '2. Display reverse', 10, 13, '3. Check palindrome', 10, 13, '4. Exit' , 10, 13, 'Your 	Choice:- ', '$'
	msg1 db 10, 13, 10, 13, 'Enter String:- $'
	msg2 db 10, 13, 10, 13, 'String is:- $'
	msg3 db 10, 13, 10, 13, 'Length:- $'
	msg4 db 10, 13, 10, 13, 'Reverse:- $'
	msg5 db 10, 13, 10, 13, 'The given string is a palindrome$'
	msg6 db 10, 13, 10, 13, 'The given string is not a palindrome$'
	menures db ?
	res db 80 dup(?)
	newline db 10, 13, '$'
	len dw 00h

.code

	mov ax, @data
	mov ds, ax
	
	mov dx, offset msg1
	mov ah, 09h
	int 21h
	lea si, res
	mov ah, 01h
	
	loop1:
		int 21h
		cmp al, 13
		je loop1end
		mov [si], al
		inc si
		inc len

		jmp loop1
	
	loop1end:
		mov al, '$'
		mov [si], al
	
	main:	
		lea dx,menu
		mov ah,09h      ;display menu string
		int 21h

		mov ah,01h      ;single char input
		int 21h

		cmp al,'1'
		je case1
		cmp al,'2'
		je case2
		cmp al,'3'
		je case3
		jmp exit
		
		case1:  
			call strlen
			jmp main
		case2:  
			call reverse
			jmp main
		case3:
			call palindrome
			jmp main
		exit:
			mov ah,4ch
			int 21h
	
proc strlen near
	mov dx, offset msg3
	mov ah, 09h
	int 21h
	
	xor dx,dx
	mov dx, len
	add dx, 30h
	mov ah, 02h
	int 21h
	ret
	
endp

proc reverse near
	mov dx, offset msg4
	mov ah, 09h
	int 21h
	
	lea di, res
	add di, len
	sub di, 1
	mov dx, [di]
	mov ah, 02h
	mov cx, len
	
	loop2:
		mov dx, [di]
		int 21h
		dec di
		dec cx
		jnz loop2
	ret
endp

proc palindrome near
	cpal:
		lea si, res
		lea di, res
		add di, len
		sub di, 1
		mov cx, len
	
	loop3:
		mov al, [si]
		mov ah, [di]
		cmp al, ah
		jne notpal
		inc si
		dec di
		dec cx
		jnz loop3
		
		xor ax, ax
		
	mov dx, offset msg5
	mov ah, 09h
	int 21h
	ret
	
	notpal:	
		mov dx, offset msg6
		mov ah, 09h
		int 21h
		ret
endp
end
