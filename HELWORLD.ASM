.model small    
.stack 100h

.data
        message db 'Hello World',13,10,'$'
.code
        mov     ax,@data    ;to use data segment
        mov     ds,ax       ;to use data segment

      ;  mov     ah,09h     ;use DOS function 09h to print string
      ;  mov     dx,OFFSET message       ;it points the string to data segment
      ;  int     21h
        LEA     dx,message
        mov     ah,09h
        int     21h


        mov     ah,04ch
        int     21h
end

