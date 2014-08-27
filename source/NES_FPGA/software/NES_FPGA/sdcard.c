#include "sdcard.h"

void load_rom(char* rom)
{
	int sd_fileh;

	// This functions links the verilog modules with C
	alt_up_sd_card_dev *sd_card_dev = alt_up_sd_card_open_dev(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_NAME);

	// Checks if it was able to obtain the address of the SD Card Socket
	if(sd_card_dev == 0)
	{
		printf("ERROR: UNABLE TO OBATIN SD SOCKET ADDRESS\n");
		return;
	}

	// Checks if the SD Card is Present in the Socket
	if(!alt_up_sd_card_is_Present())
	{
		printf("ERROR: SD CARD NOT PRESENT\n");
		return;
	}

	// Check if the Card is Fat16
	if(alt_up_sd_card_is_FAT16())
	{
		//opens the file to be read - 0 if successful
		printf("Opening %s...\n", rom);
		sd_fileh = alt_up_sd_card_fopen(rom, false);

		// Successful open
		if(sd_fileh == 0)
		{
			char data = 0;
			int i = 0;

			// Skip 'NES' (4 bytes)
			for(i = 0; i < 4; i++)
			  data = alt_up_sd_card_read(sd_fileh);

			// Get PRG and CHR size
			prg_size = alt_up_sd_card_read(sd_fileh);
			chr_size = alt_up_sd_card_read(sd_fileh);
			CHR_ROM = (byte*) malloc(sizeof(byte)*8*1024*chr_size);

			// Skip last 10 bytes of header
			for(i = 0; i < 10; i++)
			  data = alt_up_sd_card_read(sd_fileh);

			// Extract the PRG Data
			for(i = 0; i < (prg_size*16*1024); ++i)
			{
			  data = alt_up_sd_card_read(sd_fileh);
			  CPU->MEM[i+0x8000] = (byte)data;
			}

			// Extract CHR Data
			for(i = 0; i < (chr_size*8*1024); ++i)
			{
			  data = alt_up_sd_card_read(sd_fileh);
			  CHR_ROM[i] = (byte) data;
			}

			printf("Successfully Completed\n");
		}
		else
			printf("ERROR: OPENING FILE\n");
	}
	else
		printf("ERROR: SD CARD NOT FAT16 FORMAT\n");


	printf("Done loading memory! prg_size, chr_size: %d %d\n", prg_size, chr_size);
	return;
}

