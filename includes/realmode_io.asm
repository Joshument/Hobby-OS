; dh = y coordinate
; dl = x coordiante
; returns: none
move_cursor:
    mov ah, 0x02 ; move cursor code 
    mov bh, 0x0 ; display page

    int 0x10 ; interrupt for cursor commands

    ret

; al = character to print
; bl = text color
; cx = number of times character should be printed
; returns: none
put_char:
    ; mov al, 0x61
    ; mov bl, 0x03
    ; mov cx, 0x5
    mov ah, 0x9 ; Write character and attribute at cursor position 
    mov bh, 0x0 ; display page
    
    int 0x10 
    ret

; ds:si = Zero terminated string
; bl = text color
; returns: none
put_string:
    mov cx, 1
string_loop:
    mov al, [ds:si] ; load value into register and check if it's the null terminator
    cmp al, 0x0
    je string_exit

    mov cx, 1
    call put_char
    add si, 1

    mov ah, 0x03 ; get cursor positon
    mov bh, 0x0
    int 0x10 ; interrupt for visual commands

    add dl, 0x1
    call move_cursor

    jmp string_loop
string_exit:
    ret