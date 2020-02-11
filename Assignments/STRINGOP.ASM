.model small
.stack 100h
.data
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
	public strcmp,concat,substring
	
concat proc
        
	scall m1,09h    
	scall s1,0Ah   

	scall m2,09h    
	scall s2,0Ah   

	lea si,s1
	lea di,s3
	inc si
	mov cl,[si]   

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
	mov cl,[si]    

	;copying entire s2 string to s3
	loop2:
		inc si
		mov al,[si]
		mov [di],al
		inc di
		dec cl
		jnz loop2

	mov al,24h
	mov [di],al

	scall nwline,09h
	scall m3,09h  
	scall s3,09h  

	ret           
endp                

substring proc

	scall m1,09h    
	scall s1,0Ah    
	scall m2,09h   
	scall s2,0Ah    

	lea si,s1
	inc si
	mov cl,[si]    
	inc si

	lea di,s2
	inc di
	mov ch,[di]     
	inc di
	mov dh,ch       

	mov [count],0   

	loop3:    
		mov al,[si]
		mov bp,si      
		cmp al,[di]
		je loop4
		inc si

		dec cl          
		jnz loop3

		mov dl,[count]
		cmp dl,0        
		je fail
		jmp result

	loop4:   
		dec ch          
		cmp ch,0
		je success
		inc si
		inc di
		mov al,[si]
		cmp al,[di]
		je loop4        

		jmp loop3       

	success: 
		add [count],01
		lea di,s2
		add di,2       
		inc bp
		mov si,bp       
		dec cl
		mov ch,dh       

		jmp loop3       

	fail:
		scall m5,09h    
		ret             

	result: 
		scall m4,09h   
		scall m6,09h    

		mov dl,[count]  
		add dl,30h              
		mov ah,02h      
		int 21h         
	ret            
endp                   

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
end
