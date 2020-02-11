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

;---Initialise data seg---
	mov ax, @data
	mov ds, ax
	
;---Print enter str---
	mov dx, offset msg1
	mov ah, 09h
	int 21h
	lea si, res
	mov ah, 01h
	
;---Input str char by char---
	loop1:
		int 21h
		cmp al, 13
		je loop1end
		mov [si], al
		inc si
		inc len
	
		jmp loop1
	
	
;---Append '$' to end---
	loop1end:
		mov al, '$'
		mov [si], al
	
;---Print string is : ---
	mov dx, offset msg2
	mov ah, 09h
	int 21h
	
;---Print the string---
	mov dx, offset res
	mov ah, 09h
	int 21h
	
;------ Menu driven ------
	menuloop:
		mov dx, offset menu
		mov ah, 09h
		int 21h
	
		mov ah, 01h
		int 21h
		cmp al, 31h
		je callen
		cmp al, 32h
		je rev
		cmp al, 33h
		je cpal
		jmp progend
	
	
;---Print length is---
	callen:
		mov dx, offset msg3
		mov ah, 09h
		int 21h
	
;---Print length---
	xor dx,dx
	mov dx, len
	add dx, 30h
	mov ah, 02h
	int 21h
	jmp menuloop
	
	
	
;---Print reverse---
	rev:
		mov dx, offset msg4
		mov ah, 09h
		int 21h
	
	
;---Print reverse string---
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
	
		jmp menuloop
			
;---Check Palindrome---
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
		
;--- Print str is pal ---
	mov dx, offset msg5
	mov ah, 09h
	int 21h
	
	jmp palend
	
	
;--- Print str not pal ---
	notpal:	
		mov dx, offset msg6
		mov ah, 09h
		int 21h
	
	palend:
		jmp menuloop
	
	
	
;---Terminate program---
	progend:
		mov ah, 04ch
		int 21h
end
