.model small
.stack 100h
.data
        msg1 db 'Enter size of array:- $'
        msg2 db 13,10,'Enter array elements:- $'
        msg3 db 13,10,'Array addition is:- $'
        array db 50 dup(?)
        
.code
        mov     ax,@data
        mov     ds,ax

        lea     dx,msg1
        mov     ah,9h
        int     21h   
        
        mov	ah,01h
      	int 	21h
      
        mov     cl,al	
        sub	cl,30h
        mov	bl,cl
        mov     si,0
        
  	lea     dx,msg2
        mov     ah,9h
        int     21h

        accept:
                mov     ah,1h
                int     21h
                mov     array[si],al
                inc     si
                dec	cl
                jnz    accept

        lea     dx,msg3
        mov     ah,9h
        int     21h   
        
        mov     si,0
        mov	cl,bl  
        xor	dx,dx
        
        addition:
        	add	dl,array[si]
        	sub	dl,30h
        	inc 	si
        	dec	cl
        	jnz 	addition
	
	add	dl,30h
	mov	ah,02h
	int	21h
   
        mov     ah,04ch
        int     21h
end
