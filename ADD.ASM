.model small
.stack 100h
.data
        x db 03h
        y db 02h
.code
        mov     ax,@data
        mov     ds,ax

        mov     al,x
        mov     bl,y
        add     al,bl
        aaa

        mov     dl,al
        mov     ah,02h
        int     21h
       
        mov     ah,04ch
        int     21h
end
