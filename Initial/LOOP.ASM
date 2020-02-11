.model small
.stack 100h
.data
        msg db 'Numbers are ',13,10,'$'
.code
        mov     ax,@data
        mov     ds,ax

        mov     cx,10
        mov     ah,02h
        mov     dl,48

        loop1:
                int     21h
                inc     dl
                dec     cx
                jnz     loop1

        mov     ah,04ch
        int     21h
end
