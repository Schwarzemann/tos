#include <stdint.h>
#include <stddef.h>

/* VGA text mode buffer */
uint16_t* const VGA_MEMORY = (uint16_t*) 0xB8000;

/* Text mode colors */
enum VGA_COLOR {
    VGA_COLOR_BLACK = 0,
    VGA_COLOR_BLUE = 1,
    VGA_COLOR_GREEN = 2,
    VGA_COLOR_CYAN = 3,
    VGA_COLOR_RED = 4,
    VGA_COLOR_MAGENTA = 5,
    VGA_COLOR_BROWN = 6,
    VGA_COLOR_LIGHT_GREY = 7,
    VGA_COLOR_DARK_GREY = 8,
    VGA_COLOR_LIGHT_BLUE = 9,
    VGA_COLOR_LIGHT_GREEN = 10,
    VGA_COLOR_LIGHT_CYAN = 11,
    VGA_COLOR_LIGHT_RED = 12,
    VGA_COLOR_LIGHT_MAGENTA = 13,
    VGA_COLOR_LIGHT_BROWN = 14,
    VGA_COLOR_WHITE = 15,
};

/* Set a single character in the VGA buffer */
void vga_set_char(uint32_t x, uint32_t y, uint8_t c, uint8_t fg, uint8_t bg) {
    const uint16_t color = (bg << 4) | (fg & 0x0F);
    VGA_MEMORY[y * 80 + x] = ((uint16_t) c) | (color << 8);
}

/* Clear the VGA buffer */
void vga_clear() {
    for (size_t y = 0; y < 25; y++) {
        for (size_t x = 0; x < 80; x++) {
            vga_set_char(x, y, ' ', VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLUE);
        }
    }
}

/* Main kernel entry point */
void kernel_main() {
    vga_clear();
    vga_set_char(0, 0, 'T', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(1, 0, 'u', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(2, 0, 'n', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(3, 0, 'e', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(5, 0, ' ', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(6, 0, 'O', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(7, 0, 'p', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(8, 0, 'e', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(9, 0, 'r', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(10, 0, 'a', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(11, 0, 't', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(12, 0, 'i', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(13, 0, 'n', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(14, 0, 'g', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(15, 0, ' ', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(16, 0, 'S', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(17, 0, 'y', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(18, 0, 's', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(19, 0, 't', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(20, 0, 'e', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(21, 0, 'm', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    vga_set_char(22, 0, '!', VGA_COLOR_WHITE, VGA_COLOR_BLUE);
    
    while (1); /* halt the CPU */
}
