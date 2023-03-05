ORG 0x7c00      ; Set the origin to 0x7c00

mov ax, 0x0000   ; Set up the data segment
mov ds, ax

mov si, msg      ; Display a message
call print

mov ax, 0x0000   ; Load the program from the first sector of the floppy disk
mov es, ax
mov bx, 0x0000
mov ah, 0x02
mov al, 0x01
mov ch, 0x00
mov cl, 0x02
mov dh, 0x00
int 0x13

jmp 0x0000:0x0000 ; Jump to the start of the loaded program

print:
    lodsb         ; Load a byte from the message
    or al, al     ; Check if it is null
    jz done       ; If it is null, return
    mov ah, 0x0e  ; Otherwise, display the character
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp print     ; Repeat for the next character

done:
    ret           ; Return to the caller

msg db 'TuneOS Loading...', 0

times 510-($-$$) db 0   ; Pad the boot sector to 510 bytes
dw 0xaa55              ; Add the boot signature at the end
