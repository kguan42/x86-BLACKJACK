; CS 274
;
; Matthew Latta, Kevin Guan
; Create a pseudo-random integer generator to give an index from 0-51 to represent every card in a deck
; X_k+1 = a * X_k mod m
; a = multiplier
; m = modulus multiplier
; X_k+1 = next number
; X_k = current number

base: db 0xff
seed: dw 100       ; seed value
deck_size: db 0x34
num_decks: db 0x01
available_cards: db 0x34
used_cards: db 0x34

; Deck: High = card suit, Low = card value

; Spades
DW 0x0101  ; Ace of Spades
DW 0x0102  ; 2 of Spades
DW 0x0103  ; 3 of Spades
DW 0x0104  ; 4 of Spades
DW 0x0105  ; 5 of Spades
DW 0x0106  ; 6 of Spades
DW 0x0107  ; 7 of Spades
DW 0x0108  ; 8 of Spades
DW 0x0109  ; 9 of Spades
DW 0x010a  ; 10 of Spades
DW 0x010a  ; Jack of Spades
DW 0x010a  ; Queen of Spades
DW 0x010a  ; King of Spades

; Hearts
DW 0x0201  ; Ace of Hearts
DW 0x0202  ; 2 of Hearts
DW 0x0203  ; 3 of Hearts
DW 0x0204  ; 4 of Hearts
DW 0x0205  ; 5 of Hearts
DW 0x0206  ; 6 of Hearts
DW 0x0207  ; 7 of Hearts
DW 0x0208  ; 8 of Hearts
DW 0x0209  ; 9 of Hearts
DW 0x020a  ; 10 of Hearts
DW 0x020a  ; Jack of Hearts
DW 0x020a  ; Queen of Hearts
DW 0x020a  ; King of Hearts

; Diamonds
DW 0x0301  ; Ace of Diamonds
DW 0x0302  ; 2 of Diamonds
DW 0x0303  ; 3 of Diamonds
DW 0x0304  ; 4 of Diamonds
DW 0x0305  ; 5 of Diamonds
DW 0x0306  ; 6 of Diamonds
DW 0x0307  ; 7 of Diamonds
DW 0x0308  ; 8 of Diamonds
DW 0x0309  ; 9 of Diamonds
DW 0x030a  ; 10 of Diamonds
DW 0x030a  ; Jack of Diamonds
DW 0x030a  ; Queen of Diamonds
DW 0x030a  ; King of Diamonds

; Clubs
DW 0x0401  ; Ace of Clubs
DW 0x0402  ; 2 of Clubs
DW 0x0403  ; 3 of Clubs
DW 0x0404  ; 4 of Clubs
DW 0x0405  ; 5 of Clubs
DW 0x0406  ; 6 of Clubs
DW 0x0407  ; 7 of Clubs
DW 0x0408  ; 8 of Clubs
DW 0x0409  ; 9 of Clubs
DW 0x040a  ; 10 of Clubs
DW 0x040a  ; Jack of Clubs
DW 0x040a  ; Queen of Clubs
DW 0x040a  ; King of Clubs


start:
    mov ax, word seed
    mov ds, ax      ; initialize seed (X_k)
    
    mov cx, 52      ; 52 cards in deck
    mov si, 0       ; initialize si (index)
    mov di, 0       ; initialize di (index)

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
    