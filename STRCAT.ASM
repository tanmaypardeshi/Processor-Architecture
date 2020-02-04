.model small
.data
       .data
        m1 db 10d,13d,"enter first string:  $"
        m2 db 10d,13d,"enter second string: $"
        m3 db 10d,13d,"concatenated string: $"
        s1 db 20 dup('$')
        s2 db 20 dup('$')
        s3 db 40 dup('$')
        nwline db 10d,"$"

scall macro xx,yy
        lea dx,xx
        mov ah,yy
        int 21h
endm                    ;end of macro

             
.code
	mov ax,@data
	mov ds,ax

	scall m1,09h    ;display m1 string
	scall s1,0ah    ;buffered s1 string input

	scall m2,09h    ;display m2 string
	scall s2,0ah    ;buffered s2 string input

	lea si,s1
	lea di,s3
	inc si
	mov cl,[si]     ;length of s1 string

;copying entire s1 string to s3
	loop1:  
		inc si
		mov al,[si]
		mov [di],al
		inc di
		dec cl
		jnz loop1

		lea si,s2
		inc si
		mov cl,[si]     ;length of s2 string

;copying entire s2 string to s3
	loop2: 
		inc si
		mov al,[si]
		mov [di],al
		inc di
		dec cl
		jnz loop2

		mov al,24h      ;'$'=24h, putting $ at end of string s3
		mov [di],al

		scall nwline,09h
		scall m3,09h    ;display m3 string
		scall s3,09h    ;display concatenated string

        mov ah,4ch
        int 21h
end                     ;end of program


