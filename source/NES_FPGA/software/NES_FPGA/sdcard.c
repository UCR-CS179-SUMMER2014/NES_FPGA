#include "sdcard.h"

void load_rom()
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
		printf("Opening %s...\n", file_name);
		sd_fileh = alt_up_sd_card_fopen(file_name, false);

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

			// Next byte handles mirroring, SRAM presence, trainer, and mapper (lower)
			data = alt_up_sd_card_read(sd_fileh);

			// 0xx0 = horizontal, 0xx1 = vertical, 1xxx four-screen
			mirroring = data & 0x0F;
			cpu_sram_batt = (data & 0x02) ? 1 : 0;
			trainer = (data & 0x04) ? 1 : 0;

			// Upper nibble of mapper
			data = alt_up_sd_card_read(sd_fileh);
			mirroring = mirroring | (data >> 4);

			// Size of PRG RAM (unused)
			prg_ram_size = alt_up_sd_card_read(sd_fileh);

			// TV System
			tv_system = alt_up_sd_card_read(sd_fileh);

			// SRAM in CPU
			cpu_sram = (alt_up_sd_card_read(sd_fileh) & (0x10)) ? 1 : 0;

			// Skip last 5 bytes of header
			for(i = 0; i < 5; i++)
			  data = alt_up_sd_card_read(sd_fileh);

			// Extract the PRG Data
			for(i = 0; i < (prg_size*16*1024); ++i)
			{
			  data = alt_up_sd_card_read(sd_fileh);
			  CPU->MEM[i+PRG] = (byte)data;
			}
			if(prg_size == 1)	// Populate second half of PRG ROM with a copy of the first bank if prg_size is only 16kB.
			{
				for(i = 0; i < (prg_size*16*1024); ++i)
				  CPU->MEM[i+PRG+0x4000] = CPU->MEM[i+PRG];
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

