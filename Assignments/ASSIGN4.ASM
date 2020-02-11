.model small
.data
	menu db 10d,13d,10d,13d,"        MENU"
	db 10d,'1. Concatenation'
	db 10d,'2. Substring'
	db 10d,'3. String Comparison'
	db 10d,'4. Exit'
	db 10d,'Enter your choice:- $'
	
	m1 db 10d,13d,"Enter first string:-  $"
	m2 db 10d,13d,"Enter second string:- $"
	m3 db 10d,13d,"Concatenated string:- $"
	
	equal		db	13d,10d,'The two strings are equal.',13d,10d,'$'
	not_equal	db	13d,10d,'The two strings are not equal.',13d,10d,'$'
	str1		db	20 dup(?)
	str2		db	20 dup(?)
	len1		dw	0
	len2		dw	0
	
	s1 db 20 dup('$')
	s2 db 20 dup('$')
	s3 db 40 dup('$')
	nwline db 10d,"$"
	
	count db 1 dup(0)
	
	m4 db 10d,13d,"Second String is Substring.$"
	m5 db 10d,13d,"Second String is not a Substring.$"
	m6 db 10d,13d,"No. Of Occurrences:- $"

scall macro xx,yy
	lea dx,xx
	mov ah,yy
	int 21h
endm      
             
.code
	mov ax,@data
	mov ds,ax

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
			call concat     ;call procedure
			jmp main
		case2:  
			call substring  ;call procedure
			jmp main
		case3:
			call strcmp
			jmp main
		exit:
			mov ah,4ch
			int 21h

concat proc
        
	scall m1,09h    ;display m1 string
	scall s1,0Ah    ;buffered s1 string input

	scall m2,09h    ;display m2 string
	scall s2,0Ah    ;buffered s2 string input

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

	ret             ;return from prodecure
endp                    ;end of prodecure

substring proc

	scall m1,09h    ;display m1 string
	scall s1,0Ah    ;accept s1 string
	scall m2,09h    ;display m2 string
	scall s2,0Ah    ;accept s2 string 

	lea si,s1
	inc si
	mov cl,[si]     ;take length of s1 string in cl
	inc si

	lea di,s2
	inc di
	mov ch,[di]     ;take length of s2 string in cl
	inc di
	mov dh,ch       ;backup of ch register

	mov [count],0   ;initialise count with zero

	loop3:    
		mov al,[si]
		mov bp,si       ;backup of si pointer
		cmp al,[di]
		je loop4
		inc si

		dec cl          ;counter for main string
		jnz loop3

		mov dl,[count]
		cmp dl,0        ;dl=0 implies no string found
		je fail
		jmp result

	loop4:   
		dec ch          ;counter for sub-string
		cmp ch,0
		je success
		inc si
		inc di
		mov al,[si]
		cmp al,[di]
		je loop4        ;continue this loop till string are same

		jmp loop3       ;in case of mismatch, start again

	success: 
		add [count],01
		lea di,s2
		add di,2        ;move di to string place
		inc bp
		mov si,bp       ;restore si from bp
		dec cl
		mov ch,dh       ;restore ch from dh

		jmp loop3       ;start again till main string ends

	fail:
		scall m5,09h    ;display m5
		ret             ;return from procedure 

	result: 
		scall m4,09h    ;display m4 string
		scall m6,09h    ;display m6 string

		mov dl,[count]  
		add dl,30h              
		mov ah,02h      ;display dl contents
		int 21h         
	ret             ;return from procedure
endp                    ;end of procedure

strcmp proc
	
	scall m1,09h
	
	lea si, str1

	loop5:
		mov ah, 01h
		int 21h
		mov [si], al
		inc si
		inc len1
		cmp al, 13
		jne loop5
	
	sub len1, 1
	
	scall m2,09h
	
	lea si, str2
	
	loop6:
	mov ah, 01h
	int 21h
	mov [si], al
	inc si
	inc len2
	cmp al, 13
	jne loop6
	
	sub len2, 1
	
	mov cx, len1
	lea si, str1
	lea di, str2
	
	mov ax, len1
	mov bx, len2
	cmp ax, bx
	jne noequ
	
	loopcomp:
		mov al, [si]
		mov bl, [di]
		cmp al, bl
		jne noequ
		inc si
		inc di
		dec cx
		jnz loopcomp
	
	scall equal,9h
	ret
	
	noequ:
		scall not_equal,09h
		ret	
endp
end                     ;end of Program
