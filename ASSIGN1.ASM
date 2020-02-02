.model small                                    ;memory model
.stack 100h

.data
        m1	db 10,13,'Enter number of elements:- $'
        m2	db 10,13,'Enter numbers:- $'
        m3	db 10,13,'Entered numbers are:- $'
        m4	db 10,13,'The sum is:- $'
        newln	db 10,13,'$'

        arr	db 12 dup('0')
        answer	db 00h
        num	db 00h
        carry	db 00h

.code               
	mov	ax,@data
	mov	ds,ax                       

;count input code
	lea	dx,m1                       
	mov	ah,09h
	int	21h

	mov	ah,01h 
	int	21h    

	cmp	al,39h                              
	jbe	skip1
	sub	al,07H

	skip1:
		sub	al,30h
		lea	si,num
		mov	[si],al		

;enter code
		lea	dx,m2
		mov	ah,9h
		int	21h

		lea	si,arr
		mov	bh,num

	loop1:
		mov	bl,0h
		mov	ch,02h


	;code to input numbers
	loop2:
		mov	ah,01h
		int	21h

		cmp	al,39h
		jbe	skip2
		sub	al,07h

	skip2:
		sub	al,30h
		cmp	ch,01H
		je 	kip3
		mov	cl,04h
		rol	al,cl
	skip3:
		add	bl,al
		dec	ch
		jnz	loop2
		mov	[si],bl
		inc	si
		lea	dx,newln
		mov	ah,09h
		int	21h

		dec	bh
		jnz	loop1


;displaying array
	lea	dx,m3
	mov	ah,09H
	int	21h

	lea	si,arr
	mov	bh,num

	loop3:
		mov	bl,0h
		mov	ch,02h

		mov	dl,[si]
		mov	cl,04h
		rol	dl,cl

;code to display 2 digits
	loop4:	        
		and	dl,0Fh
		cmp	dl,09h
		jbe	skip4
		add	dl,07h
	skip4:	       
		add	dl,30h

		mov	ah,02h
		int	21h

		mov	dl,[si]
		dec	ch
		jnz	loop4

		lea	dx,newln
		mov	ah,09h
		int	21h

		inc	si
		dec	bh
		jnz	loop3


;addition code
	mov	bh,num
	lea	si,arr
	mov	bl,0h
	mov	al,0H
	
	loop5:
		add	bl,[si]
		adc	al,00H
		inc	si

		dec	bh
		jnz	loop5

	lea	si,answer
	mov	[si],bl


;display code
	lea	si,carry
	mov	[si],al

	lea	dx,m4
	mov	ah,09H
	int	21h

	lea	si,carry
	mov	bl,[si]
	add	bl,30H
	mov	dl,bl
	mov	ah,02H
	int	21H
	
	mov	ch,02H
	lea	si,answer
	mov	bh,[si]

	loop6:
		mov	bl,bh
		mov	cl,04h
		rol	bl,cl
		cmp	ch,01h
		jne	skip5
		mov	cl,04h
		rol	bl,cl

	skip5:
		and	bl,0FH
		cmp	bl,09H
		jbe	skip6
		add	bl,07h

	skip6:
		add	bl,30h
		mov	dl,bl
		mov	ah,02H
		int	21h

		dec	ch
		jnz	loop6

	mov	ah,4CH                                      
	int	21h 
end                                           s
