.model small
.stack 100h
.data
	msg1    db      13,10,'Enter a string:- $'
	pal	db	13,10,'Palindrome.',13,10,'$'
	notpal	db	13,10,'Not a palindrome.',13,10,'$'
	str1	db	20 dup(?)
	len	dw	?
	
.code
	mov ax, @data
	mov ds, ax
	
	mov ah, 09h
	mov dx, offset msg1
	int 21h
	
	lea si, str1
	mov len, 0
	
	loop1:
	mov ah, 01h
	int 21h
	mov [si], al
	inc si
	inc len
	cmp al, 13
	jne loop1
	
	sub len, 1
	
	lea si, str1
	lea di, str1
	add di, len
	sub di, 1
	mov cx, len
	
	loop3:
	mov al, [si]
	mov bl, [di]
	cmp al, bl
	jne nopal
	inc si
	dec di
	dec cx
	jnz loop3
	
	mov ah, 09h
	mov dx, offset pal
	int 21h
	jmp palend
	
	
	nopal:
	mov ah, 09h
	mov dx, offset notpal
	int 21h
	
	palend:
	mov ah, 04ch
	int 21h
end

