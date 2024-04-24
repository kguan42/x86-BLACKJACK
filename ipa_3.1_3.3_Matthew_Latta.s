; CS 274
;
; Matthew Latta
;
; Implement bets and wins
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


def proc_get_user_input {
    ; ask user for difficulty level (Easy 1/2 user cash, Normal 1/1 user cash, Hard 3/2 user cash
    ; ask user how many decks (1-3)
    ; ask user how much starting cash (10-1000)
    ; ask user for computer betting mode (Conservative, Normal, Aggressive)
    ; ask user for computer risk level (stand, hit, forfeit) add up to 100%
    ; deck num goes into si
    
    ret
}

def proc_fill_one_deck {
    ; For s in range(0,4) suits
    ;    For v in [...]
    ;
    ret
}

def proc_fill_n_decks {
    ; Loop over chosen number of decks with si
    call proc_fill_one_deck
    ret
}

def proc_check_user_bet {
    ; checks if user has the total cash to bet, if not, jump back to place bet
    ret
}

def proc_place_bet {
    ; prompt the user to place a bet no more than their total
    call proc_check_user_bet
    ; computer will also place bet depending on conditions (enough money)
    ret
}



def proc_check_comp {
    ; check if computer has any money left, if not call user_win
    ret
}

def proc_check_user {
    ; check if user has any money left, if not call comp_win
    ret
}

def proc_check_deck {
    ; if no cards left to start another game, call compare money
    ret
}



def proc_give_starting_card {
    ; this will give out 2 cards each to the computer and the player
    ; marks the cards as used/unavailable
    ; shows the user their cards and computer's cards
    ret
}

def proc_user_choice {
    ; prompt the user to either hit for another card or stand on their current cards
    
    ret
}

def proc_check_user_deck {
    ; this will check if the user got a bust, 21, or not
    ; go to proc_user_choice if neither bust or 21
    ; if 21, go to proc_user_round_win
    ; if bust go to proc_comp_round_win
    
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
    
    ret
}


def proc_check_comp_deck {
    ; this will check if the computer got a bust, 21, or not
    ; go to proc_computer_choice if neither bust or 21
    ; if 21, go to proc_comp_round_win
    ; if bust go to proc_user_round_win
    
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
    ; if no go to proc_compare_money
    

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
