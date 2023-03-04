; A very simple keyboard interrupt handler

; Define the keyboard interrupt vector
irq1_vector equ 9

; Set up the interrupt descriptor table (IDT)
idt_start:
    dw 0           ; IDT entry 0 - dummy entry
    dw 0           ; offset 0:0
    dw 0x8         ; selector (code segment with ring 0)
    dw 0x8E00      ; flags: present, ring 0, 32-bit interrupt gate
    dw 0           ; IDT entry 1 - dummy entry
    dw 0           ; offset 0:0
    dw 0x8         ; selector (code segment with ring 0)
    dw 0x8E00      ; flags: present, ring 0, 32-bit interrupt gate
    dw 0           ; IDT entry 2 - dummy entry
    dw 0           ; offset 0:0
    dw 0x8         ; selector (code segment with ring 0)
    dw 0x8E00      ; flags: present, ring 0, 32-bit interrupt gate
    ; ...

; Set up the code segment with ring 0
code_segment equ 0x8
bits 32
org 0x1000

; Define the interrupt handler
irq1_handler:
    pushad          ; Save all registers
    in al, 0x60     ; Read the scan code from the keyboard controller
    cmp al, 0x1c    ; Check if the scan code is for the 'ENTER' key
    jne skip        ; If not, skip the next line
    mov ebx, 0xCAFEBABE ; Store a value in ebx to indicate the 'ENTER' key was pressed
skip:
    popad           ; Restore all registers
    iret            ; Return from the interrupt

; Set up the interrupt descriptor table pointer (IDTR)
idtr:
    dw idt_end - idt_start - 1
    dd idt_start

; Load the IDT
lidt [idtr]

; Enable interrupts
sti

; Infinite loop to keep the program running
start:
    jmp start

; Define the end of the IDT
idt_end:

