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
		printf("Failed to load buffer(s)!\n");
	else
		printf("Successfully loaded buffer(s)!\n");


	alt_up_char_buffer_clear(char_buffer);	// Clear the screen
	/*alt_up_char_buffer_string(char_buffer, "UCR CS179J - NES FPGA Emulator!", 0,0);
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
*/


	alt_up_pixel_buffer_dma_clear_screen( pix_buffer, 0 );
	//alt_up_pixel_buffer_dma_draw( pix_buffer, 0xFFFFF, 11, 11);
	alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 110, 75, 256+110, 240+75, 0x55FFF, 0);

	int color = 0;
	int x = 0, y = 0, s = 0;
	byte mask;

	for( s = 0; s < 32*30; ++s)
	{
		for( y = 0; y < 8; ++y )
		{
			mask = 0x80;
			for( x = 0; x < 8; ++x)
			{
				color = (((CHR_ROM[y+s*16] & mask) ? 1 : 0) | (((CHR_ROM[y+8+s*16] & mask) ? 1 : 0) << 1));
				if(color == 0)
					color = 0xFFFFFFFF;
				else if(color == 1)
					color = 0x0000FFFF;
				else if(color == 2)
					color = 0xFFFF0000;
				else
					color = 0;
				alt_up_pixel_buffer_dma_draw( pix_buffer, color, 110+x+(s%32)*8, 75+y+((s > 32) ? s/32*8+1 : 0));
				mask = mask >> 1;
			}

		}
	}

	/*	for( y = 0; y < 8; ++y )
	{
		mask = 0x80;
		for( x = 0; x < 8; ++x)
		{
			color = (((CHR_ROM[y+16] & mask) ? 1 : 0) | (((CHR_ROM[y+8+16] & mask) ? 1 : 0) << 1));
			if(color == 0)
				color = 0xFFFFFFFF;
			else if(color == 1)
				color = 0x0000FFFF;
			else if(color == 2)
				color = 0xFFFF0000;
			else
				color = 0;
			alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 110+x+8, 75+y, 111+x+8, 75+y, color , 0);
			mask = mask >> 1;
		}

	}
	for( y = 0; y < 8; ++y )
	{
		mask = 0x80;
		for( x = 0; x < 8; ++x)
		{
			color = (((CHR_ROM[y+32] & mask) ? 1 : 0) | (((CHR_ROM[y+8+32] & mask) ? 1 : 0) << 1));
			if(color == 0)
				color = 0xFFFFFFFF;
			else if(color == 1)
				color = 0x0000FFFF;
			else if(color == 2)
				color = 0xFFFF0000;
			else
				color = 0;
			alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 110+x, 75+y+8, 111+x, 75+y+8, color , 0);
			mask = mask >> 1;
		}

	}
	for( y = 0; y < 8; ++y )
	{
		mask = 0x80;
		for( x = 0; x < 8; ++x)
		{
			color = (((CHR_ROM[y+48] & mask) ? 1 : 0) | (((CHR_ROM[y+8+48] & mask) ? 1 : 0) << 1));
			if(color == 0)
				color = 0xFFFFFFFF;
			else if(color == 1)
				color = 0x0000FFFF;
			else if(color == 2)
				color = 0xFFFF0000;
			else
				color = 0;
			alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 110+x+8, 75+y+8, 111+x+8, 75+y+8, color , 0);
			mask = mask >> 1;
		}

	}*/
/*
	for( y = 0; y < 8; ++y )
	{
		mask = 0x80;
		for( x = 0; x < 8; ++x)
		{
			color = (((CHR_ROM[y+56] & mask) ? 1 : 0) | (((CHR_ROM[y+8+56] & mask) ? 1 : 0) << 1));
			if(color == 0)
				color = 0xFFFFFFFF;
			else if(color == 1)
				color = 0x0000FFFF;
			else if(color == 2)
				color = 0xFFFF0000;
			else
				color = 0;
			alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 110+x, 75+y+16, 111+x, 75+y+16, color , 0);
			mask = mask >> 1;
		}

	}
	for( y = 0; y < 8; ++y )
	{
		mask = 0x80;
		for( x = 0; x < 8; ++x)
		{
			color = (((CHR_ROM[y+64] & mask) ? 1 : 0) | (((CHR_ROM[y+8+64] & mask) ? 1 : 0) << 1));
			if(color == 0)
				color = 0xFFFFFFFF;
			else if(color == 1)
				color = 0x0000FFFF;
			else if(color == 2)
				color = 0xFFFF0000;
			else
				color = 0;
			alt_up_pixel_buffer_dma_draw_box ( pix_buffer, 110+x+8, 75+y+16, 111+x+8, 75+y+16, color , 0);
			mask = mask >> 1;
		}

	}*/
	return;
}
