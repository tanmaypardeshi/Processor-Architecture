.model small
.stack 100h
.data
        a db 02h
        b db 09h
.code
        mov     ax,@data
        mov     ds,ax

        mov     al,a
        mov     bl,b

        add     al,bl
        add     al,37h

        mov     dl,al
        mov     ah,02h
                        
        int     21h
                           
        mov     ah,04ch
        int     21h
end
