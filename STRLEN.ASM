.model small
.stack 100h
.data
	msg1 db 13,10,'Given string is:- $'
	msg2 db 13,10,'Length of string is:- $'
	string db 'PICT$'

.code
	
	mov	ax,@data
	mov	ds,ax
	
	mov	al,0h
	mov	ah,9h
	lea	dx,msg1
	int 	21h
	
	mov	ah,9h
	lea	dx,string
	int	21h
	
	lea	si,string
	
	start:
		cmp	[si],'$'
		je	finish
		inc	bl
		inc	si
		jmp	start
	finish:
		mov	ah,9h
		lea	dx,msg2
		int 	21h
		
		add	al,30h
		
		mov	dl,al
		mov	ah,02h
		int	21h
		
		mov	ah,04ch
		int	21h
end
