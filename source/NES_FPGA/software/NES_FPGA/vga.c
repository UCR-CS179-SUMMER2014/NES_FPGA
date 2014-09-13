/*
 * vga.c
 *
 *  Created on: Sep 12, 2014
 *      Author: Sergio
 */
#include "vga.h"

void vga_test()
{
	alt_up_char_buffer_init(char_buffer); // Initialize buffer
	//alt_up_char_buffer_init(pix_buffer); // Initialize buffer
	char_buffer = alt_up_char_buffer_open_dev("/dev/Char_Buffer_with_DMA"); // Name must be "/dev/" followed by instance name
	pix_buffer = alt_up_pixel_buffer_dma_open_dev("/dev/Pixel_Buffer_DMA");		// Same with Pixel Buffer

	if(!char_buffer || !pix_buffer)	// Buffer fails to load if its NULL
		printf("Failed to load buffer(s)!");
	else
		printf("Successfully loaded buffer(s)!");


	alt_up_char_buffer_clear(char_buffer);	// Clear the screen
	alt_up_char_buffer_string(char_buffer, "UCR CS179J - NES FPGA Emulator!", 0,0);
	alt_up_char_buffer_string(char_buffer, "Select Game:", 20,20);
	alt_up_char_buffer_string(char_buffer, "1. Mario Bros.", 20,21);
	alt_up_char_buffer_string(char_buffer, "2. Donkey Kong", 20,22);
	alt_up_char_buffer_string(char_buffer, "// ----------------------------------------------------------", 0,1);
	alt_up_char_buffer_string(char_buffer, "//       _        __   _____    ______         _______  ", 0,2);
	alt_up_char_buffer_string(char_buffer, "//      / \\      / /  / ___/  /  ____/        |   ____|  ",0,3);
	alt_up_char_buffer_string(char_buffer, "//     /   \\    / /  / /__    \\  \\      ___   |  |___  ",0,4);
	alt_up_char_buffer_string(char_buffer, "//    / / \\ \\  / /  / ___/     \\  \\    |___|  |   ___|    :)",0,5);
	alt_up_char_buffer_string(char_buffer, "//   / /   \\ \\/ /  / /___   ____\\  \\          |  |  ",0,6);
	alt_up_char_buffer_string(char_buffer, "//  /_/     \\__/  /_____/  /_______/          |__|  ",0,7);
	alt_up_char_buffer_string(char_buffer, "// ----------------------------------------------------------",0,8);



	alt_up_pixel_buffer_dma_clear_screen( pix_buffer, 0 );
	alt_up_pixel_buffer_dma_draw( pix_buffer, 0xFFFFF, 11, 11);
	alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 0, 0, 640, 480, 0xFF5FF, 0);

	return;
}
