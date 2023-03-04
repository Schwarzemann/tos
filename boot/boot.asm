; A very simple boot loader 

org 0x7c00      ; Set the origin to the start of the boot sector

start:
    ; Disable interrupts
    cli

    ; Load data into the segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Load the contents of the boot sector into memory
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x80     ; Load the boot sector from the first hard disk
    mov bx, 0x0000
    mov es, bx       ; Set the segment of the buffer to 0
    mov bx, 0x7c00   ; Set the offset of the buffer to 7C00h
    int 0x13         ; Call BIOS interrupt 13h to read the disk

    ; Jump to the start of the loaded code
    jmp 0x0000:0x7c00

    ; Fill the rest of the sector with zeros
    times 510-($-$$) db 0
    dw 0xaa55       ; Boot signature
