base:
    db 0xFF
buffer:
    db 0x04
    db 0xca
    db [0xff,4]


item1: db "1: Hit "
item2: db "2: Stand"
prompt: db "Select an option. Enter 0 to quit."
    
start:     
    mov ah, 0x13
    mov cx, 0x0F ; length of string
    mov bx, 0
    mov es, bx
    mov bp, offset item1
    int 0x10
    mov ah, 0x13
    mov cx, 0x32 ; length of string
    mov bx, 0
    mov es, bx
    mov bp, offset prompt
    int 0x10
prompt_user:
    mov ah, 0x0A
    lea dx, word buffer
    int 0x21
    mov al, offset buffer ; How do i get the first character of the input?
    cmp al, 0x30 ; ASCII for 0
    je exit
    cmp al, 0x31 ; ASCII for 1
    je option_1
    cmp al, 0x32 ; ASCII for 2
    je option_2

exit:
    mov ah, 0x13
    int 0x10
    
option_1:
    
option_2:
    

