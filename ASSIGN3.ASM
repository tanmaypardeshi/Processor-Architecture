print macro m
mov ah,09h
mov dx,offset m
int 21h
endm

.model small


;******  Data Segment ******
.data

menu db 10,13, "Menu: "
     db 10,13, "1.Enter the string "
     db 10,13, "2.Reverse "
     db 10,13, "3.Check for palindrome "
     db 10,13, "4.Exit  "
     db 10,13, "  "
     db 10,13, "Your choice: $"
msg1 db 10,13, "Your choice is: $"
mc6 db 10,13, "Exiting the program $"
mc7 db 10,13, "Invalid choice....try again $"
empty db 10,13, "   $"
str1 db 25,?,25 dup('$')
str2 db 25,?,25 dup('$')
len db ?
mstring db 10,13, "Enter the string: $"
notpalin db 10,13, "String is not a palindrome. $"
palin db 10,13, "String is a palindrome. $"
mconcat db 10,13, "Concatenated string: $"
mscount db 10,13, "Number of spaces: $"
mlength db 10,13, "Length is: $"
mreverse db 10,13, "Reversed string: $"
scount db ?





.code

start:
mov ax,@data
mov ds,ax

again:

print menu
call accept 
mov bl,al


case1:

        cmp bl,"1"  
        jne case2    
        
		print empty         
		print mstring
        call accept_string   

        mov cl,str1+1        
        mov bl,cl             
		print mlength       
        call display1        
		print empty
        jmp again            



case2:  cmp bl,"2"       
        jne case3          
		print empty

        mov si,offset str1      
        mov di,offset str2    


        mov al,[si]     
        mov [di],al         
        inc si              
        inc di


        mov al,[si]
        mov [di],al
        inc si
        inc di

        mov cl,str1+1        
        mov ch,00              
        add si,cx             
        dec si               
        
move_more: mov al,[si]       
           mov [di],al   
           dec si           
           inc di
           dec cl
           jnz move_more

        
		print mreverse
        print str2+2     
		print empty

        mov ah,00
        mov al,cl
        jmp again

case3:  cmp bl,"3"   
        jne case4         
		print empty

        mov si,offset str1
		mov cl,str1+1        
		mov ch,00h
		mov len,cl
		inc si
		add si,cx       
		        
		mov di,offset str1   
		add di,0002h        
		
				
         
		mov cl,len ;load counter
 cmpagain: mov al,[si]
           mov ah,[di]
		   inc di
		   dec si
           cmp al,ah
           jne nopalin
		   dec cl
		   jnz cmpagain
          	
		print palin
		print empty
        jmp again		
nopalin: print notpalin		
		print empty
        jmp again


	   
case4: cmp bl,"4"     
       jne case5      
	   print mc6
	   jmp exit
        	   
case5: print mc7   
       jmp again   

exit:
mov ah,4ch      
int 21h



accept proc near

mov ah,01
int 21h
ret
accept endp

display1 proc near

   mov al,bl
   mov bl,al
   and al,0f0h
   mov cl,04
   rol al,cl

   cmp al,09
   jbe number
   add al,07
number:  add al,30h
         mov dl,al
         mov ah,02
         int 21h

         mov al,bl
         and al,00fh
         cmp al,09
         jbe number2
         add al,07
number2:  add al,30h
          mov dl,al
          mov ah,02
          int 21h
ret
display1 endp



accept_string proc near

mov ah,0ah          
mov dx,offset str1  
int 21h
ret
accept_string endp

end start
end
