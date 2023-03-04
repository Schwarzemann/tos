; A very simple BIOS with no additional features such as error handling and disc access

ORG 0x7C00    ; Set origin to the BIOS boot sector address
BITS 16       ; Set code generation to 16-bit mode

start:
    ; Initialize stack pointer
    mov sp, 0x7C00

    ; Set up the data segment register
    mov ax, 0x07C0
    mov ds, ax

    ; Clear the screen
    mov ax, 0x0003 ; BIOS video mode 3 (text mode)
    int 0x10       ; Video BIOS interrupt
    mov ax, 0x0000 ; Set the video mode
    int 0x10

    ; Print a message to the screen
    mov si, message
    call print_string

    ; End of BIOS program
    cli
    hlt

print_string:
    ; Print a null-terminated string to the screen
    lodsb ; Load the next character from the string
    cmp al, 0 ; Check if it is the null terminator
    je done ; If it is, end the function
    mov ah, 0x0E ; BIOS interrupt function for printing a character
    int 0x10 ; Call the BIOS video interrupt
    jmp print_string ; Loop to print the next character

done:
    ret ; Return from the function

message db 'Tune BIOS!!!', 0 ; The message to print
times 510-($-$$) db 0 ; Fill the rest of the boot sector with zeros
dw 0xAA55 ; Boot sector signature
