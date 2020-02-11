.model small
.stack 100h
.data
        msg1 db 'Enter size of array:- $'
        msg2 db 13,10,'Enter array elements:- $'
        msg3 db 13,10,'Elements of array are:- $'
        array db 50 dup(?)
        
.code
        mov     ax,@data
        mov     ds,ax

        lea     dx,msg1
        mov     ah,9h
        int     21h   
        
        mov	ah,01h
      	int 	21h
      
        mov     cl,al	;use cl when we have a variable value to store
        sub	cl,30h
        mov	bl,cl	;temporary var bl to store value of size which is present in cl
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

        mov     si,0
        mov	cl,bl  
        lea     dx,msg3
        mov	ah,09h
        int	21h

        l1:
                mov     dl,array[si]
                mov     ah,2h
                int     21h
                inc     si
                dec	cx
                jnz	l1                                         

        mov     ah,04ch
        int     21h
end
