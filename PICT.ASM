.model small
.stack 100h
.data
        msg1 db 'Hello World',13,10,'$'
        msg2 db 'PICT',13,10,'$'
.code
        mov     ax,@data
        mov     ds,ax

        mov     ah,09h
        mov     dx,OFFSET msg1
        int     21h

        mov     ah,09h
        mov     dx,OFFSET msg2
        int     21h

        mov     ah,04ch
        int     21h
end
