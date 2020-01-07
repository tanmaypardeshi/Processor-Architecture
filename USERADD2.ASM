.model small
.stack 100h
.data 
	msg1 db 'Addition of two digit numbers is:- $'
	newline db 13,10,'$'

.code
	mov	ax,@data
	mov	ds,ax
	
	mov	ax,09h
	mov	bx,02h
	add	ax,bx
	mov	cx,ax
	
	xor	ax,ax
	
	
	mov	ax,cx
