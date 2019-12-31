.model small
.stack 100h
.data
        msg1 db 'Enter array elements:- ',13,10,'$'
        msg2 db 13,10,'Elements of array are:- ',13,10,'$'
        array db 5 dup(?)
.code
        mov     ax,@data
        mov     ds,ax

        lea     dx,msg1
        mov     ah,9h
        int     21h

        mov     cx,5
        lea     si,array

        accept:
                mov     [si],al
                mov     ah,1h
                int     21h
                inc     si
                loop    accept

        lea     dx,msg2
        mov     ah,9h
        int     21h

        mov     cx,5
        lea     si,array

        l1:
                mov     dl,[si]
                mov     ah,2h
                int     21h
                inc     si
                loop    l1                            

        mov     ah,04ch
        int     21h
end
