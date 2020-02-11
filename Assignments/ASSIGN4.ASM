.model small
.data
	menu db 10d,13d,10d,13d,"        MENU"
	db 10d,'1. Concatenation'
	db 10d,'2. Substring'
	db 10d,'3. String Comparison'
	db 10d,'4. Exit'
	db 10d,'Enter your choice:- $'
             
.code
extrn strcmp:far
extrn concat:far
extrn substring:far

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
end
