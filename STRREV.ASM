.model small
.stack 100h
.data
    msg1 db 13,10, 'Enter a string:- $'
    msg2 db 13,10, 'Reverse string is:- $'
    string db 255 dup(0)
    result db 255 dup('$')

.code
    
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg1
    int 21h

    lea si, string

    read:
        mov ah, 01h
        int 21h
		mov [si], al
        inc si
    	cmp al, 13
        jnz read

    mov ax, si
    lea bx, string
    sub ax, bx

    lea di, result
    add di, ax
	dec di
    dec di

	lea dx, msg2
  	mov ah, 09h
    int 21h 
    
    lea si, string

    reverse_string:
        mov al, [si]
        mov [di], al
        inc si
        dec di
        cmp si,13
        jnz reverse_string

    lea dx, result
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
end
