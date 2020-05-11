.model small
.stack 100h

.data
	m1 db 10d,13d,"Enter first string:  $"
	m2 db 10d,13d,"Enter second string: $"
	s1 db 20 dup('$')
	s2 db 20 dup('$')
	s3 db 40 dup('$')
	nwline db 10d,"$"
	m4 db 10d,13d,"Second String is Substring.$"
	m5 db 10d,13d,"Second String is not a Substring.$"
	m6 db 10d,13d,"No. Of Occurrence: $"
	count db 1 dup(0)



scall macro xx,yy
        lea dx,xx
        mov ah,yy
        int 21h
endm                    ;end of macro

     
             
.code
	mov ax,@data
	mov ds,ax
	
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

		mov [count],0h   ;initialise count with zero
		  
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

			jmp loop3       ;inc case of mismatch, start again

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

			mov ah,4Ch
			int 21h
	endp
end                     ;end of program


