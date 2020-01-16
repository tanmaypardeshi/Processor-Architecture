.model small
.stack 100h

.data
	msg db 13,10,'Hello',13,10,'$'
	
print macro m
	lea	dx,m
	mov	ah,9h
	int	21h	
endm

initz macro
	mov	ax,@data
	mov	ds,ax
endm

endprog macro
	mov	ah,4ch
	int	21h
endm

.code
	initz
	print msg
	endprog
end
