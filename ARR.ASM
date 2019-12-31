.model small
.stack 100h
.data
        arr db 50,51,52,53,54,55,56,57,48
.code
        mov     ax,@data
        mov     ds,ax

        mov     cx,9
        lea     si,arr

        l1:
                mov     dl,[si]
                mov     ah,02h
                int     21h
                inc     si
                loop    l1

        mov     ah,04ch
        int     21h
end
