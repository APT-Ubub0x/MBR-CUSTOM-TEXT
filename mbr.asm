org 0x7c00      ; Set the starting address of the program
bits 16         ; Use 16-bit mode

; Entry point of the program
start:
    call clear_screen      ; Clear the screen before displaying the message
    mov bx, message        ; Load the address of the message into BX

    call print_string      ; Call the function to print the string
    jmp halt               ; Jump to halt after printing

; Function to print a NULL-terminated string
; Arguments:
;  BX: Pointer to the string to print
print_string:
    mov al, [bx]          ; Load the current character from the string
    cmp al, 0             ; Check for the NULL terminator
    je done                ; If NULL, finish the printing
    call print_character   ; Print the character
    inc bx                 ; Move to the next character
    jmp print_string       ; Repeat for the next character

; Function to print a single character
; Arguments:
;  AL: Character to print
print_character:
    mov ah, 0x0e          ; BIOS function to write a character
    int 0x10              ; Call BIOS interrupt to display character
    ret                    ; Return from character print

; Function to clean the screen
clear_screen:
    mov ah, 0x07          ; Function to scroll the screen
    mov al, 0x00          ; Number of lines to scroll
    mov bh, 0x04          ; Color attributes: black background, white text
    mov cx, 0x00          ; Upper left corner (row)
    mov dx, 0x184f        ; Lower right corner (column)
    int 0x10              ; Call BIOS interrupt
    ret                    ; Return from clear screen

; String to display
message db "NukPack has u!", 13, 10, "Leave a star on GitHub", 13, 10, 0 

; Fill the remaining sectors with zeros
times 510 - ($ - $$) db 0 ; Pad remaining space
dw 0xaa55                  ; Bootable signature

; Program execution starts here
halt:
    ret                     ; Halt the program
