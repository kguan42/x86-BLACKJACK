base: db 0xff
seed: dw 100       ; seed value
deck_size: db 0x34
num_decks: db 0x01

available_cards: db 0x34
used_cards: db 0x34

start:
    mov ax, word seed
    mov ds, ax      ; initialize seed (X_k)
    mov cx, 52      ; 52 cards in deck
    mov si, 0       ; initialize si (index)
    mov di, 0
    
init_cards_loop:
    cmp di, available_cards
    je draw_random_card
    mov byte [available_cards + di], 1   ; Mark card as available
    mov byte [used_cards + di], 0        ; Mark card as unused
    inc di
    jmp init_cards_loop
    
draw_random_card:
    mov dx, 0
    mov bx, 75           ; initialize weird multiplier on the wiki (a)
    mul bx               ; multiply ax by bx
    mov bx, 65535        ; modulus, 16 bit max (a)
    div bx               ; divide ax by bx where dx = remainder
    mov ax, dx           ; remainder
    mov bx, 52           ; set modulus to max cards in deck
    div bx
    mov ax, dx           ; mov dx=remainder into ax to get desired card index

check_card_available:
    mov si, ax           ; move random num (card index) into si
    mov al, byte [available_cards + si] ; load card availability
    cmp al, 1 ; compare status to 1 (available)
    jne draw_random_card ; lord help me
    
    mov byte [available_cards + si], 0 ; If card available, set to unavailable
    mov byte [used_cards + si], 1 ; If card available, mark the card as used
    