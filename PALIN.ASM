.model small
.stack 100h
.data
	string db 80 dup(?)
	msg db  13,10,'Enter a string:- $'
	true db 13,10,'String is palindrome $'
	false db 13,10,'String is not palindrome $'
	len dw 00h

.code
	mov	ax,@data
	mov	ds,ax
	
	mov	ah,9h
	lea	dx,msg
	int	21h
	
	lea   si,string
	mov	ah,01h
	
	l1:
		int	21h		
		cmp	al,13
		je 	loop1
		mov	[si],al
		inc	si
		inc	len
		jmp 	l1	

	lea	si,string
		
	loop1: 
		mov	ax, [si] 
		cmp	al,'$'
		je	label1 
		inc	si 
		jmp	loop1	 

	label1: 
		lea	si,string
		lea	di,string
		add	di,len
		dec	di 

	loop2: 
		mov	ax,[si] 
		mov	bx,[di]
		cmp	al,bl
		jne	output2 
		dec	di 
		inc	si 
		jmp loop2 

	output1: 
		lea	dx,true 
		mov	ah,9h
		int 21h
		
	output2: 
		lea	dx,false 
		mov	ah,9h
		int 21h

	mov	ah,4ch
	int	21h
end

