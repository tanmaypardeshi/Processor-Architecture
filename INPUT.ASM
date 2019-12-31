.model small
.stack 100h
.data
        msg1 db 13,10,'Enter number 1:- ','$'
        msg2 db 13,10,'Enter number 2:- ','$'
        msg3 db 13,10,'Result is:- ','$'
        a db ?
        b db ?

.code
        mov     ax,@data
        mov     ds,ax

        mov     ah,09h
        mov     dx,OFFSET msg1
        int     21h

        mov     ah,01h
        int     21h

        mov     bl,al

        mov     ah,09h
        mov     dx,OFFSET msg2
        int     21h

        mov     ah,01h
        int     21h

        mov     cl,al                                         
        sub     bl,30h

        mov     ah,09h
        mov     dx,OFFSET msg3
        int     21h

        add     cl,bl
        mov     dl,cl                   

        mov     ah,02h
        int     21h

        mov     ah,04ch
        int     21h
end
