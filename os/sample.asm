;*******************;
; sample program    ;
; does the adding   ;
;*******************;
org 0x500
start: jmp run

%include "../includes/realmode_io.asm"

; Variable decleration
test_string db "Hello from sector 2!", 0

run:
    mov dh, 3
    mov dl, 0
    call move_cursor

    mov si, test_string
    mov bl, 0x0F
    call put_string

loop:
    hlt
    jmp loop