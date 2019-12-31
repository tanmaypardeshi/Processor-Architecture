.model small
.stack 100h
.code
       
        mov     dl,'A'
        mov     ah,02h
        int     21h
       
        mov     ah,04ch
        int     21h
end
