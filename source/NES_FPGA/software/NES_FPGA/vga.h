#ifndef VGA_H_
#define VGA_H_

#include "NES.h"

int toVGA(int in); // Converts NES palette to RGB values

void vga_init(); /* Initializes pixel buffer and the screen for rendering. */
void vga_test(); /* Tests the functionality of the Altera pixel buffer dma functions */


#endif
