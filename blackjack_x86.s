; CS 274
;
; Matthew Latta
; Kevin Guan
;
; Final implementation of project
;

base: db 0xff
seed: dw 79       ; seed value
deck_size: db 0x34
num_decks: db 0x01
available_cards: db 0x34
used_cards: db 0x34

; Deck: High = card suit, Low = card value
cards:
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

stats:
    db 0x00 ; Computer wins
    db 0x00 ; Computer card points
    db 0x00 ; Player wins
    db 0x00 ; Player card points

money:
    dw 0x03e8 ; computer money
    dw 0x03e8 ; user money
    
    
user_w: DB "You win!"
comp_w: DB "You Lose!"

buffer:
    db 0x04
    db 0xca
    db [0xff,4]

settings:
    db 0x00 ; Difficulty level
    db 0x00 ; Deck count
    db 0x00 ; Starting cash
    db 0x00 ; Computer betting mode

difficulty_prompt: db "Select a difficulty level: 1. Easy 2. Normal 3. Hard"
deck_count_prompt: db "Select a number of decks up to 3."
cash_prompt: db "Select starting cash from 10 to 1000."
cpu_bet_prompt: db "Select computer's betting behavior: 1. Conservative 2. Normal 3. Aggressive"
play_again_prompt: db "Play again? 1. Yes 2. No"
invalid_input_string: db "Invalid input."
bet_prompt: db "How much would you like to bet?"
invalid_bet_prompt: db "You cannot bet that amount."
hit_stand_prompt: db "Hit or stand? 1. Hit 2. Stand"

def proc_get_user_input {
    ; ask user for difficulty level (Easy 1/2 user cash, Normal 1/1 user cash, Hard 3/2 user cash
    ; ask user how many decks (1-3)
    ; ask user how much starting cash (10-1000)
    ; ask user for computer betting mode (Conservative, Normal, Aggressive)
    ; ask user for computer risk level (stand, hit, forfeit) add up to 100%

    lea bp, word settings ; loading settings array into bp register
    mov ah, 0x13 ; AH value of 0x13 for int 0x10 to display to screen
    mov cx, 0x34 ; length of string difficulty_prompt
    mov bx, 0
    mov es, bx
    mov ax, offset difficulty_prompt
    int 0x10 ; interrupt to display difficulty_prompt
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov al, offset buffer ; Difficulty level stored in al
    mov byte[bp, 0x00], al ; Difficulty level changed in settings array

    mov ah, 0x13
    mov cx, 0x21 ; length of string deck_count_prompt
    mov bx, 0
    mov es, bx
    mov ax, offset deck_count_prompt
    int 0x10 ; interrupt to display deck_count_prompt
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov al, offset buffer ; Deck count stored in al
    mov byte[bp, 0x01], al ; Deck count changed in settings array

    mov ah, 0x13
    mov cx, 0x26 ; length of string cash_prompt
    mov bx, 0
    mov es, bx
    mov ax, offset cash_prompt
    int 0x10 ; interrupt to display cash_prompt
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov al, offset buffer ; Starting cash stored in al
    mov byte[bp, 0x02], al ; Starting cash changed in settings array

    mov ah, 0x13
    mov cx, 0x4C ; length of string cpu_bet_prompt
    mov bx, 0
    mov es, bx
    mov ax, offset cpu_bet_prompt
    int 0x10 ; interrupt to display cpu_bet_prompt
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov al, offset buffer ; Computer betting mode stored in al
    mov byte[bp, 0x03], al ; Computer betting mode changed in settings array

    ret
}

new_game:
    call proc_get_user_input

fill_one_deck:
    ; For s in range(0,4) suits
    ;    For v in [...]
    ;
    mov ax, word [bp, di]
    stos word               ; put whats in AX into memory
    inc di                  ; index of cards
    cmp di, 0x33            ; max size
    jg fill_one_deck


fill_n_decks:
    ; Loop over chosen number of decks with si
    lea bp, word cards
    mov di, 0x00
    dec si
    jmp fill_one_deck
    cmp si, 0x00
    jg fill_n_decks
    jmp start


def proc_check_user_bet {
    ; checks if user has the total cash to bet, if not, jump back to place bet
    lea bp, word money
    mov al, byte[bp, 0x01] ; move money value of user to al register
    cmp al, bl

    mov ah, 0x13 ; AH value of 0x13 for int 0x10 to display to screen
    mov cx, 0x1B ; length of string
    mov bx, 0
    mov es, bx
    mov bx, offset invalid_bet_prompt
    int 0x10 ; interrupt to display string
    jl place_bet

    ret
}

def proc_place_bet {
    lea bp, word money
    ; prompt the user to place a bet no more than their total
    mov ah, 0x13 ; AH value of 0x13 for int 0x10 to display to screen
    mov cx, 0x1F ; length of string
    mov bx, 0
    mov es, bx
    mov ax, offset bet_prompt
    int 0x10 ; interrupt to display string
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov bl, offset buffer ; bet amount stored in bl

    call proc_check_user_bet
    ; computer will also place bet depending on conditions (enough money)
    
    mov si, 0x01
    mov cx, word [bp, si]
    mov al, 0x05
    div cx
    
    
    ret
}



def proc_check_comp {
    ; check if computer has any money left, if not call user_win
    lea bp, word money
    mov si, 0x01
    mov ax, word [bp, si]
    cmp ax, 0x00
    jle user_win
    
    ret
}

def proc_check_user {
    ; check if user has any money left, if not call comp_win
    lea bp, word money
    mov si, 0x03
    mov ax, word [bp, si]
    cmp ax, 0x00
    jle comp_win
    ret
}

def proc_check_deck {
    ; if no cards left to start another game, call compare money
    
    mov dh, byte available_cards
    
    cmp dh, 0x00
    jle no_cards
    ret
}


def proc_user_choice {
    ; prompt the user to either hit for another card or stand on their current cards
    mov ah, 0x13 ; AH value of 0x13 for int 0x10 to display to screen
    mov cx, 0x1D ; length of string
    mov bx, 0
    mov es, bx
    mov ax, offset hit_stand_prompt
    int 0x10 ; interrupt to display hit_stand_prompt
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov al, offset buffer 
    cmp al, 0x01
    je choose_hit
    cmp al, 0x02
    je choose_stand ; when stand check opponent and prompt computers choice
    jne reprompt_user_choice
    ret
}

reprompt_user_choice:
    call proc_user_choice

def proc_check_user_deck {
    ; this will check if the user got a bust, 21, or not
    ; go to proc_user_choice if neither bust or 21
    ; if 21, go to proc_user_round_win
    ; if bust go to proc_comp_round_win
    lea bp, word stats
    mov si, 0x04
    mov al, byte [bp, si]
    cmp al, 0x15
    je user_round_win
    
    ret
}

def proc_give_user_card {
    ; gives user another card if they choose to hit
    mov dx, 0
    mov bx, 75           ; initialize weird multiplier on the wiki (a)
    mul bx               ; multiply ax by bx
    mov bx, 65535        ; modulus, 16 bit max (a)
    div bx               ; divide ax by bx where dx = remainder
    mov ax, dx           ; remainder
    mov bx, 52           ; set modulus to max cards in deck
    div bx
    mov si, dx
    mov al, 0x02
    mul si
    
    
    
    lea bp, word cards
    mov al, byte [bp, si]
    
    lea bp, word stats
    add byte [bp,0x03], al      ; add al to player's card score
    
    call proc_check_user_deck   ; check if bust, 21, or not
    
    ret
}


def proc_computer_choice {
    ; computer selects hit, stand, or forfeit hand depending on risk level
    lea bp, word stats
    mov si, 0x02
    mov ah, byte [bp, si]
    cmp ah, 0x21
    jl comp_hit
    cmp ah, 0x17
    jge comp_forfeit_check
    
    ret
}

choose_stand: 
    call proc_computer_choice

def proc_give_starting_card {
    ; this will give out 2 cards each to the computer and the player
    ; marks the cards as used/unavailable
    ; shows the user their cards and computer's cards
    
    call proc_give_user_card
    call proc_give_user_card
    ret
}


def proc_check_comp_deck {
    ; this will check if the computer got a bust, 21, or not
    ; go to proc_computer_choice if neither bust or 21
    ; if 21, go to proc_comp_round_win
    ; if bust go to proc_user_round_win
    lea bp, word stats
    mov si, 0x02
    mov ah, byte [bp, si]
    cmp ah, 0x15
    je comp_round_win
    
    ret
}


def proc_give_comp_card {
    ; gives computer another card if it chooses to hit
    
    mov dx, 0
    mov bx, 75           ; initialize weird multiplier on the wiki (a)
    mul bx               ; multiply ax by bx
    mov bx, 65535        ; modulus, 16 bit max (a)
    div bx               ; divide ax by bx where dx = remainder
    mov ax, dx           ; remainder
    mov bx, 52           ; set modulus to max cards in deck
    div bx
    
    mov si, dx
    mov al, 0x02
    mul si
    
    
    
    lea bp, word cards
    mov al, byte [bp, si]
    
    lea bp, word stats
    add byte [bp,0x01], al           ; add al to computer's card score
    
    call proc_check_comp_deck ; check if bust, 21, or not
    
    ret
}


def proc_compare_decks {
    ; if the player and computer stands, compare decks values
    ; go to proc_user_round_win if user > computer
    ; go to proc_comp_round_win if user < computer
    
    lea bp, word stats
    mov bl, byte [bp, 0x01] ; computer points
    mov cl, byte [bp, 0x03] ; player points
    
    cmp bl, cl
    jg user_round_win
    jl comp_round_win
    
    ret
}



proc_play_again:
    ; ask the user if they wish to play the next turn
    ; if yes start round
    ; if no go to proc_compare_wins

    mov ah, 0x13 ; AH value of 0x13 for int 0x10 to display to screen
    mov cx, 0x34 ; length of string play_again_prompt
    mov bx, 0
    mov es, bx
    mov ax, offset difficulty_prompt
    int 0x10 ; interrupt to display difficulty_prompt
    mov ah, 0x0A ; set AH to 0x0A so int 0x21 can prompt user input
    lea dx, word buffer
    int 0x21 ; user input prompted
    mov al, offset buffer ; input stored in al
    cmp al, 0x01
    je next_round
    cmp al, 0x02
    je compare_wins

    mov ah, 0x13
    mov cx, 0x0E ; length of invalid input string
    mov bx, 0
    mov es, bx
    mov ax, offset invalid_input_string
    int 0x10 ; interrupt to display string
    jmp proc_play_again

user_round_win:
    ; subtract betted money from computer
    ; add betted money to user
    inc byte [bp, 0x03]
    
    jmp proc_play_again
    

comp_round_win:
    ; subtract betted money from user
    ; add betted money to computer
    inc byte [bp, 0x01]
    
    jmp proc_play_again
    

comp_hit:
    call proc_give_comp_card
    call proc_computer_choice
    
comp_forfeit_check:
    mov si, 0x04
    mov al, byte [bp, si]
    cmp ah, al
    jl user_round_win
    call proc_compare_decks


def start_round {
    ; This starts the round once difficulty and num decks are initialized.
    
    call proc_check_comp ; check computer's money
    call proc_check_user ; check user's money
    call proc_check_deck ; check if cards left in deck
    
    
    call proc_place_bet ; user and computer place bets (might separate into 2 methods if easier later)
    
    call proc_give_starting_card ; give the user and computer 2 starting cards from available deck
    
    call proc_check_user_deck ; check if deck is 21 or not (cant be bust yet)
    call proc_check_comp_deck ; check if deck is 21 or not (cant be bust yet)
    
    
    ret
}

def proc_compare_wins {
    ; compare user's wins to computer's wins
    ; jmp to user_win if user has more
    ; jmp to comp_win if computer has more
    
    lea bp, word stats
    mov bl, byte [bp, 0x00] ; computer wins
    mov cl, byte [bp, 0x02] ; player wins
    
    cmp bl, cl
    
    jg user_win ; if user has more wins, user wins
    jl comp_win ; if user has less wins, computer wins
    
    
    ret
}
choose_hit:
    call proc_give_user_card

place_bet:
    call proc_place_bet

next_round:
    call start_round

compare_wins:
    call proc_compare_wins

no_cards:
    call proc_compare_wins

user_win:
    ; display that the user has won
    MOV AH, 0x13            ; move BIOS interrupt number in AH
    MOV CX, 8              ; move length of string in cx
    MOV BX, 0               ; mov 0 to bx, so we can move it to es
    MOV ES, BX              ; move segment start of string to es, 0
    MOV BP, OFFSET user_w    ; move start offset of string in bp
    MOV DL, 0               ; start writing from col 0
    int 0x10                ; BIOS interrupt
    
    jmp end
    


comp_win:
    ; display that the computer has won
    MOV AH, 0x13            ; move BIOS interrupt number in AH
    MOV CX, 9              ; move length of string in cx
    MOV BX, 0               ; mov 0 to bx, so we can move it to es
    MOV ES, BX              ; move segment start of string to es, 0
    MOV BP, OFFSET comp_w    ; move start offset of string in bp
    MOV DL, 0               ; start writing from col 0
    int 0x10                ; BIOS interrupt
    
    jmp end

start:
    mov ax, bx
    jmp user_win
    
end:
    mov ax, bx
