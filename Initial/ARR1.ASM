.model small
.stack 100h
.data
        msg1 db 'Enter array elements:- $'
        msg2 db 13,10,'Elements of array are:- $'
        array db 5 dup(?)
.code
        mov     ax,@data
        mov     ds,ax

        lea     dx,msg1
        mov     ah,9h
        int     21h

        mov     cx,5	;use cx when you are assigning constant value
        mov     si,0

       
        accept:
                mov     ah,1h
                int     21h
                mov	array[si],al
                inc     si
                dec	cx
                jnz	accept

        lea     dx,msg2
        mov     ah,9h
        int     21h

        mov     cx,5
        mov     si,0

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
