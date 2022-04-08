; bootloader.asm
; *******************************

org 0x7c00
bits 16
start: jmp boot

%include "../includes/realmode_io.asm"

; constant and variable definitions
welcome db "Awesome Bootloader v0.0.1", 0
testing_sector db "Attempting to run sector 2...", 0

boot:
    cli ; no interrupts
    cld ; all that's needed to init

    ; reset segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, $$

    ; clear display
    mov ah, 0x0
    mov al, 0x3
    int 0x10

    ; send greet message
    mov dh, 0
    mov dl, 0
    call move_cursor

    mov al, 0x61
    mov bl, 0x04
    mov cx, 0x05
    call put_char

    mov si, welcome
    mov bl, 0x02
    call put_string

    mov dh, 1
    mov dl, 0
    call move_cursor

    mov si, testing_sector
    mov bl, 0x0F
    call put_string

    ;; load and sector from floppy disk
    mov ax, 0x50
    mov es, ax
    xor bx, bx

    ; set up parameters
    mov al, 2
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0

    mov ah, 0x02 ; code for reading sectors
    int 0x13 ; interrupt for drive-related operations
    jmp 0x50:0x0 ; jump to the start of the next sector
    
    hlt ; halt the system

; We need to have 512 bytes, so clear the rest of the bytes with 0

times 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signature