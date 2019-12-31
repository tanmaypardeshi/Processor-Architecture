.model small
.stack 100h
.data
        msg db 'Hello World',13,10,'$'
.code
main    proc    far

        mov     ax,@data
        mov     ds,ax

        mov     ah,09h
        mov     dx,OFFSET msg
        int     21h

        mov     ah,04ch
        int     21h
main endp
end main
