.model small
.stack 100h
.data
	msg1 db 13,10,'Enter a string:- $'
	msg2 db 13,10,'Length of string is:- $'
	msg3 db 13,10,'String is:- $'
	string db 80 dup(?)
	len dw 00h

.code
	
	mov	ax,@data
	mov	ds,ax
	
	mov	ah,9h
	lea	dx,msg1
	int 	21h
	lea  si,string
	
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
			
		mov	ah,9h
		lea	dx,msg3
		int 	21h
		
		mov	ah,9h
		lea	dx,string
		int 	21h
		
		mov	ah,9h
		lea	dx,msg2
		int 	21h
		
		
		xor	dx,dx
		mov	dx,len
		add	dx,30h
		
		mov	ah,02h
		int	21h
		mov	ah,04ch
		int	21h
end
