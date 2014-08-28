#include <altera_up_avalon_video_character_buffer_with_dma.h>
#include <altera_up_avalon_video_character_buffer_with_dma_regs.h>
#include <stdio.h>

#define buttons 0x10
int main()
{
	alt_up_char_buffer_dev* buffer;
	alt_up_char_buffer_init(buffer);

	buffer = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");
	if(!buffer)
		printf("Failed to load!");
	else
		printf("Successfully loaded!");

	alt_up_char_buffer_clear(buffer);

	while(1)
	{
		alt_up_char_buffer_string(buffer, "UCR CS179J - NES FPGA Emulator!", 0,0);
		alt_up_char_buffer_string(buffer, "Select Game:", 20,20);
		alt_up_char_buffer_string(buffer, "1. Mario Bros.", 20,21);
		alt_up_char_buffer_string(buffer, "2. Donkey Kong", 20,22);
	}

	printf("Hello world!");
	return 0;
}


