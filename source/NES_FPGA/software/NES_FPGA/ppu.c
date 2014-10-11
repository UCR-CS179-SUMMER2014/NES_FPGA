#include "ppu.h"

static short i;			// Temp variable for loops

int RGB[64] = {
		0x757575,
		0x271B8F,
		0x0000AB,
		0x47009F,
		0x8F0077,
		0xAB0013,
		0xA70000,
		0x7F0B00,
		0x432F00,
		0x004700,
		0x005100,
		0x003F17,
		0x1B3F5F,
		0x000000,
		0x000000,
		0x000000,
		0xBCBCBC,
		0x0073EF,
		0x233BEF,
		0x8300F3,
		0xBF00BF,
		0xE7005B,
		0xDB2B00,
		0xCB4F0F,
		0x8B7300,
		0x009700,
		0x00AB00,
		0x00933B,
		0x00838B,
		0x000000,
		0x000000,
		0x000000,
		0xFFFFFF,
		0x3FBFFF,
		0x5F97FF,
		0xA78BFD,
		0xF77BFF,
		0xFF77B7,
		0xFF7763,
		0xFF9B3B,
		0xF3BF3F,
		0x83D313,
		0x4FDF4B,
		0x58F898,
		0x00EBDB,
		0x000000,
		0x000000,
		0x000000,
		0xFFFFFF,
		0xABE7FF,
		0xC7D7FF,
		0xD7CBFF,
		0xFFC7FF,
		0xFFC7DB,
		0xFFBFB3,
		0xFFDBAB,
		0xFFE7A3,
		0xE3FFA3,
		0xABF3BF,
		0xB3FFCF,
		0x9FFFF3,
		0x000000,
		0x000000,
		0x000000,
};


// Handles reads from special PPU registers.
inline byte read_ppu_reg( word addr )
{
	byte t1;

	// Reads to $2002 clears the VBlank flag, and the $2005/$2006 write latch.
	if( addr == 0x2002 )
	{
		t1 = PPUSTATUS;		// "Read" $2002.
		PPUSTATUS &= 0x7F;	// Bit 7 gets cleared after a read from $2002.
		PPU->ppu_latch = 0; // PPU $2005/$2006 write latch also gets cleared after a read.

		return t1;
	}

	// Reads to $2004 returns the contents of whatever address oamaddr has.
	else if( addr == 0x2004)
	{
		// TODO: Confirm 2004 is correctly handled for reads
		OAMDATA = PPU->OAM[ OAMADDR ];
		return OAMDATA;
	}

	// Reads to $2007 returns the contents of whatever address ppuaddr has.
	else if( addr == 0x2007 )
	{
		if( PPU->ppuaddr > 0x3FFF )
			PPU->ppuaddr &= 0x3FFF; // $4000+ are mirrors of the whole memory map

		// Caution: Reading from VRAM 0000h-3EFFh loads the desired value into a latch, and
		// returns the OLD content of the latch to the CPU. After changing the address one should
		// thus always issue a dummy read to flush the old content
		if( PPU->ppuaddr < 0x3F00 )
		{
			t1 = PPU->read_buffer;	// Get the old content.

			if( (PPU->ppuaddr >= 0x3000) && (PPU->ppuaddr <= 0x3EFF) )
				PPU->read_buffer = PPU->MEM[ PPU->ppuaddr & 0x2FFF]; // $3000-$3EFF are mirrors of $2000-$2EFF
			else
				PPU->read_buffer = PPU->MEM[ PPU->ppuaddr ];	// Normal read

			// Auto Increment ppuaddr depending on PPUCTRL bit 3
			if( (VRAM_ADDR_INC) == 0) 
				++PPU->ppuaddr;
			else 
				PPU->ppuaddr += 32;
			
			PPUDATA = t1;

			return t1;
		}
		// Palette reads
		else
		{
			// What is copied to the delayed buffer is addr[ppu.reg[6] - 0x1000]
			PPU->read_buffer = PPU->ppuaddr - 0x1000;
			
			// Actual palette data is returned
			t1 = PPU->MEM[ PPU->ppuaddr & 0x3F1F ];	// Normal read for palettes.

			// Auto Increment ppuaddr depending on PPUCTRL bit 3
			if( (VRAM_ADDR_INC) == 0) 
				++PPU->ppuaddr;
			else 
				PPU->ppuaddr += 32;
			
			PPUDATA = t1;

			return t1;

		}
	}
	// For the other registers
	return 0;
}

// Handles writes to special PPU registers.
inline void write_ppu_reg( byte data, word addr )
{
	if( addr == 0x2004)		// Sprite/OAMDATA
	{
		// Store the data into the OAM/Sprite Table, with the address
		// specified by 0x2003, OAMADDR.
		OAMDATA = data;
		PPU->OAM[ OAMADDR ] = OAMDATA;
	}
	else if( addr == 0x2005) // PPUSCROLL
	{
		// TODO Fix PPUSCROLL writes
		PPUSCROLL = data;

		// We're on the first write
		if(PPU->ppu_latch == 0)
		{
			PPU->ppuscroll = ( (word) data) << 8;
			PPU->ppu_latch = 1;
		}
		// We're on the second write
		else
		{
			// We now have our 16 bits of data
			PPU->ppuscroll |= data;	// Write to PPU Scroll register now.
			PPU->ppu_latch = 0;
		}
	}
	else if( addr == 0x2006 ) // PPUADDR
	{
		//printf("\n\nWriting %x to $2006\n\n", data);
		PPUADDR = data;

		// We're on the first write
		if(PPU->ppu_latch == 0)
		{
			// Note PPU address is only 14 bits long! So the first write only uses 6 bits.
			PPU->ppuaddr_temp = ( data & 0x3F) << 8; // Don't overwrite ppuaddr until the second (lower) byte is written
			PPU->ppu_latch = 1;						 // Signal that we've written the higher byte, now for the lower byte
		}
		// We're on the second write
		else
		{
			PPU->ppuaddr = PPU->ppuaddr_temp | data;	// Now that lower byte is given, overwrite ppuaddr.
			PPU->ppu_latch = 0;						// Signal that we're back to writing the higher byte
		}
	}
	else if( addr == 0x2007 ) // PPUDATA
	{
		//printf("\n\nWriting %x to $2007\n\n", data);
		PPUDATA = 0x00; //data;  Noticed that in the emulator, $2007 stays 0x00;

		if( PPU->ppuaddr > 0x3FFF )
		{
			printf(" entire ppu mirroring!\n ");
			PPU->ppuaddr &= 0x3FFF; // $4000+ are mirrors of the whole memory map
		}

		// Nametables.
		else if( (PPU->ppuaddr > 0x1FFF) &&  (PPU->ppuaddr < 0x3F00) )
		{
			// Now we handle name table scroll mirroring
			if( (mirroring & 0x09) == 1) // Vertical
			{
				if( PPU->ppuaddr < 0x2400 || ((PPU->ppuaddr >= 0x2400) && (PPU->ppuaddr <= 0x27FF)) )
				{
					PPU->MEM[ PPU->ppuaddr ] = data;
					PPU->MEM[ PPU->ppuaddr + 0x800 ] = data;
				}
				else
				{
					PPU->MEM[ PPU->ppuaddr ] = data;
					PPU->MEM[ PPU->ppuaddr - 0x800 ] = data;
				}

			}
			else // Horizontal. $2000 = $2400
			{
				if( PPU->ppuaddr < 0x2400 || ((PPU->ppuaddr >= 0x2800) && (PPU->ppuaddr <= 0x2BFF)) )
				{
					PPU->MEM[ PPU->ppuaddr ] = data;
					PPU->MEM[ PPU->ppuaddr + 0x400 ] = data;
				}
				else
				{
					PPU->MEM[ PPU->ppuaddr ] = data;
					PPU->MEM[ PPU->ppuaddr - 0x400 ] = data;
				}
			}
		}

		// Palette tables
		else if( PPU->ppuaddr >= 0x3F00 && PPU->ppuaddr < 0x4000 )
			PPU->MEM[ PPU->ppuaddr & 0x3F1F ] = data; // Includes mirroring

		// Auto Increment ppuaddr depending on PPUCTRL bit 3
		if( (VRAM_ADDR_INC) == 0) ++PPU->ppuaddr;
		else PPU->ppuaddr += 32;
	}
	return;
}

/* Display current scanline and cycle status for PPU. */
inline void ppu_status()
{
	printf(" SL: %d CYC: %d ", PPU->scanline, PPU->cycle);
	return;
}

/* PPU tick function. Loops through cycles and scanlines at a rate of 3x CPU cycles. */
void ppu_exec()
{

	/* PPU Cycles:
	 * 		Range from 0-341.
	 * PPU Scanlines:
	 * 		Range from -1-260.
	 */
	// Run PPU at a rate of 3x faster than CPU.
	for( i = 0; i < 3*CPU->T; ++i)
	{

		// TODO: Implement Reload vertical scroll bits on scanline -1.
		if(PPU->cycle == 304)
		{
			// TODO: Rendering also has to be enabled.
			if(PPU->scanline == -1)
			{
				// Also check what cycle we will be ending on since we're in -1.
				// Cycle length is shorter on an odd_frame.
				if(PPU->odd_frame)
				{
					PPU->last_cycle = 341;
					PPU->odd_frame ^= 1;
				}
				else
					PPU->odd_frame ^= 1;
			}
		}
		else if((PPU->cycle == 1) && (PPU->scanline == -1))
		{
			// This is when we turn off VBlank, one cycle after scanline 260 ended.
			PPUSTATUS = 0x00;
		}
		// We've reached the last cycle of the scanline
		else if(PPU->cycle == PPU->last_cycle)
		{
			// Reset cycle, increment scanline
			PPU->cycle = 0;
			++PPU->scanline;

			if( PPU->scanline == 241)
			{
				// PPU "finished" rendering.
				//render_to_screen();
				//nametable_viewer();
				nametable_display(0);

				// Now we're in Vblank time.
				PPUSTATUS |= 0x80;

				// PPPU "PC" gets reinitialized
				PPU->ppuaddr = 0x2000;

				// NMI gets generated if bit 7 of $2000 is set.
				CPU->NMI = (PPUCTRL & 0x80) ? 1 : 0;
			}
			else if( PPU->scanline >= 261)
			{
				PPU->scanline = -1;
			}

		}


		// Increment PPU cycles
		++PPU->cycle;
	}


	return;
}

inline void ppu_init()
{
  PPU = (RP2C02*) malloc(sizeof(RP2C02));
  PPU->MEM = (byte*) malloc(sizeof(byte)*16384);
  PPU->ATTRIBUTE_TABLE_INFO = (ATT_TABLE_INFO*) malloc(sizeof(ATT_TABLE_INFO) * 960);
  /*PPU->BUFFER = (int**)malloc(240* sizeof(int*));

  //Creating the VGA buffer
  int i, j;
  for(i = 0; i < 240; ++i)
	  PPU->BUFFER[i] =  (int*)malloc(256* sizeof(int));

  int x,y;
  //Assigning zeros to the buffer
  for(y = 0; y < 240; ++y)
	  for(x = 0; x < 256; ++x)
		  PPU->BUFFER[x][y] = 0;*/

  PPU->scanline = -1;
  PPU->cycle = 0;
  PPU->last_cycle = 340;
  PPU->odd_frame = 1;
  PPU->ppu_latch = 0;
  PPU->tempa = 0;
  PPU->ppuaddr = 0;
  PPU->ppuscroll = 0;
  PPU->read_buffer = 0;

  //this initializes the whole memory map to 0x00
  int i;
  for(i = 0; i < 65535; ++i)
		PPU->MEM[i] = 0x00;

  //SEPARATE SPRITE_RAM for Rendering memory map
  //Access via SPR_RAM[i][j]
  //Total size is SPR_RAM[0-3][0-63]
  byte r = 4, c = 64, j;
  byte **SPR_RAM = (byte **)malloc(r * sizeof(byte *));
  for (i=0; i<r; i++)
	  SPR_RAM[i] = (byte *)malloc(c * sizeof(byte));

  //initialize everything to 0
  for(i = 0; i < r; ++i)
	  for(j = 0; j < c; ++j)
		  SPR_RAM[i][j] = 0x00;

  //This is a table where the the index is the tile number
  //and the data inside is attribute offset of the attribute table
  //and also is its tile top right, top left, bottom right or bottom left
  	int tile = 0;
  	for(tile = 0; tile < 960; tile++)
  	{
  		PPU->ATTRIBUTE_TABLE_INFO[tile].TL = 0;
  		PPU->ATTRIBUTE_TABLE_INFO[tile].TR = 0;
  		PPU->ATTRIBUTE_TABLE_INFO[tile].BL = 0;
  		PPU->ATTRIBUTE_TABLE_INFO[tile].BR = 0;
  		PPU->ATTRIBUTE_TABLE_INFO[tile].OFFSET = 0;
  		PPU->ATTRIBUTE_TABLE_INFO[tile].SCANLINE = 0;
  		PPU->ATTRIBUTE_TABLE_INFO[tile].BIT = 0;
  	}
  	//This fucntion call sets the correct data to every tile.
  	//if you want to see if a tile is in the top left or top right or lower left or lower right of its 4x4 attribute tile
  	// thank you can access it via these calls
  	/*
  	 *  				PPU->ATTRIBUTE_TABLE_INFO[tile]->TL;
						PPU->ATTRIBUTE_TABLE_INFO[tile]->LR;
						PPU->ATTRIBUTE_TABLE_INFO[tile]->LL;
						PPU->ATTRIBUTE_TABLE_INFO[tile]->LR;
  	 *
  	 * every 4X4 tile has an offset number which tells it that they must grab a byte from the 64 bytes in the attribute table
  	 * since 16 tiles access one byte of the attribute table that makes  16tiles = 1Byte. So since theres 32x30 tiles (960 tiles)
  	 * 960tiles / 16tiles sets = 60 sets where each set uses 1 byte of the attribute table. The attribute table is 64Bytes long
  	 * so theres an extra 4 B useless ytes in the end of the table.
  	 *
  	 * you can access each tile's offset by accesing
  	 *
  	 * 					PPU->ATTRIBUTE_TABLE_INFO[tile]->OFFSET;
  	 * also  Every tile has a variable called BIT. This byte has 2 bits that are set to 1's. which are the only
  	 * only bits for that tile to be checked on the attribute byte. For example if we are on the first 4x4 tile
  	 * that would mean that we would check the first byte in the attribute table.
  	 * Therefore, lets say the attibute table first byte has this sequence "11100100"
  	 * Then,
  	 * that would mean we must use the first 2 bits for the 2x2 on the Top Left of the 4x4. the example below
  	 * shows which bits to grab for the tiles in a 4x4 attribute tiles
  	 *
  	 * bit sequence "11100100"
  	 *
  	 *   00|00|01|01|
		 --|--|--|--|
		 00|00|01|01|
		 -----|-----|
		 10|10|11|11|
		 --|--|--|--|
		 10|10|11|11|

		 we can access the bits we need to check by accesing
		 	 	 	 	 	 	 PPU->ATTRIBUTE_TABLE_INFO[tile]->BIT;
		 we use this sequence to "AND" it with the attribute byte and that would be our 2 byte color selector
  	 *
  	 * */
  	attribute_offset_set(); //Sets the attribute tile information
  	//pallet_init(); //Sets the color palletes

  	//byte temp = 0x00;
  	/*for(tile = 0x2000; tile < 0x23C0; ++tile)
  	{
  		PPU->MEM[tile] = (tile - 0x2000) % 0xFF;
  	}*/

  return;
}


void draw_tile(int x, int y, word ADDR_START )
{
	int x_start = x;
	int y_start = y;
	int x_finish = x+8;
	int y_finish = y+8;

	byte color_bit1 = 0;
	byte color_bit2 = 0;
	byte colors = 0;
	int PATTERN_TABLE_COUNTER = 0;
	int bit_location = 7;
	byte mask = 0x80;

	for(;y_start < y_finish; ++y_start)
	{
		color_bit1 = 0;
		color_bit2  = 0;
		bit_location = 7;
		x_start = x;
		x_finish = x+8;
		mask = 0x80;

		for(;x_start < x_finish; ++x_start)
		{
			// Assign the first  bit
			color_bit1 = (PPU->MEM[ (ADDR_START + PATTERN_TABLE_COUNTER) ] & mask) >> bit_location;

			// Assign the second bit
			color_bit2 = (PPU->MEM[ (ADDR_START + PATTERN_TABLE_COUNTER) + 8 ] & mask) >> bit_location;

			//Assign the Third and fourth Bit
			int temp_tile = tile_retrieval(x_start, y_start);
			//printf("	temp_tile %d\n", temp_tile);

			byte attribute_byte = PPU->MEM[ATTRIBUTE_TABLE_0 + PPU->ATTRIBUTE_TABLE_INFO[temp_tile].OFFSET];
			byte tmp_color;
			//printf("	attribute_byte %x\n", attribute_byte);


			if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].TL == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & ( attribute_byte << 2 );
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].TR == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & ( attribute_byte );
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BL == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & ( attribute_byte >> 2 );
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BR == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & ( attribute_byte >> 4 );

			colors = (color_bit1 | ( color_bit2 << 1));

			//By now Colors should have the 4bit color to be look on the palette
			//colors |= tmp_color;


			// Obtain byte from background pallete
			int VGA_Color = RGB[colors];

			// Output Pixel
			alt_up_pixel_buffer_dma_draw( pix_buffer, VGA_Color, 100+x_start,100+y_start );

			// Update the Bit counter
			bit_location--;

			// Update mask
			mask = mask >> 1;
		}
		PATTERN_TABLE_COUNTER++;
	}

	//printf("Tile completed========\n");
}
void render_to_screen()
{
	//printf("Start Rendering\n");
	//byte NMTA; //get name table address
	word ADDR_START; //Gets the the address from pattern table in hex
	//byte cycle = CPU->T; //The number of CPU Cycles to estimate PPU Cycles

	int X_RENDER = -8;
	int Y_RENDER = 0;

	int tile = 0;
	for(tile = 0; tile < 960; ++tile)
	{
		//update XY-coordinates
		if(tile % 32 == 0 && tile != 0){
			X_RENDER = 0;
			Y_RENDER += 8;
		}
		else if(tile % 32 != 0 )X_RENDER += 8;
		else if(tile == 0)X_RENDER += 8;



		//printf("Tile: %d\n", tile);
		//printf("X_RENDER: %d\n", X_RENDER);
		//printf("Y_RENDER: %d\n", Y_RENDER);
		//printf("---------\n");

		//NMTA = PPU->MEM[NAMETABLE_0 + tile];//get name table address

		ADDR_START = 16 * PPU->MEM[0x2000 + tile];// + ((PPUCTRL & 0X10) ? 0x1000 : 0x0000);
		//NMTA = PPU->MEM[ADDR_START ];

		//ADDR_START = pattern_lookout(NMTA); //Gets the the address from pattern table in hex

		//printf("NMTA: %d\n", NMTA);
		//printf("ADDR_START: %d\n", ADDR_START);

		draw_tile( X_RENDER, Y_RENDER, ADDR_START);
		//char* en;
		//fgets(en, 2, stdin);
		//printf("finished drawing tile\n");

		//printf("finished Updating\n");
		//printf("=====================\n");
	}
	//printf("Finished Rendering\n");
	//printf("X_RENDER: %d\n", X_RENDER);
	//printf("Y_RENDER: %d\n", Y_RENDER);


}
void attribute_offset_set()
{
	int tile = 0; //This is the tile number being updated
	byte scanline = 0; //The scanline number
	byte prev_scanline = 0;
	int counter_line = 0; //This will have which position in the 4x4 the tile is on
	byte tile_index = 0; // This will have the position of the tile in the 2x2 within the 4x4
	int offset_start = 0; //This is the atart of the Attribute offset at every start of every 16x16 tiles vertical
	byte offset_counter = 0; //This wll be the counting of every attribute offset horizontally
	byte position = 0; //This is the position of the tile weather it lies on top left 2x2 or top right 2x2 etc...


	for(tile = 0; tile < 960; ++tile)
	{
		//This will retrive the tile's Scanline and Obtain which scanline is within the 4x4 tile
		//EXAMPLE OF 4X4 TILE The number represent the bits within
		//the attribute byte '11100100'

		//00|00|01|01| scanline 1
		//--|--|--|--|
		//00|00|01|01| scanline 2
		//-----|-----|
		//10|10|11|11| scanline 3
		//--|--|--|--|
		//10|10|11|11| scanline 4
		//--|--|--|--|
		prev_scanline = scanline;
		scanline = scanline_retireval(tile);
		counter_line = scanline % 4;
		PPU->ATTRIBUTE_TABLE_INFO[tile].SCANLINE = scanline;
		if(prev_scanline != scanline && counter_line != 0)
			offset_counter = offset_start;
		if(prev_scanline != scanline && counter_line == 0)
		{
			offset_start += 8;
			offset_counter = offset_start;
		}

		//Counter_Line updates from 0 to 3 where it means the Horizontal scanliine within a 4x4 anywhere
		//in the output for every 4x4 attribute tile
		if( (scanline % 2 == 0) && counter_line == 0)
		{
			if(tile_index == 0 || tile_index == 1) position = 0;
			else if(tile_index == 2 || tile_index == 3) position = 1;
			UPDATE(tile_index,offset_counter,tile, position);
			//Update
			tile_index++;
			if(tile_index == 4)
			{
				tile_index = 0;
				offset_counter++;
			}
		}
		//-----------------------------------------------------------------------
		if( (scanline % 2 == 0) && counter_line == 2)
		{
			if(tile_index == 0 || tile_index == 1) position = 2;
			else if(tile_index == 2 || tile_index == 3) position = 3;
			UPDATE(tile_index,offset_counter,tile, position);
			//Update
			tile_index++;
			if(tile_index == 4)
			{
				tile_index = 0;
				offset_counter++;
			}
		}
		//-----------------------------------------------------------------------
		if( (scanline % 2 == 1) && counter_line == 1)
		{
			if(tile_index == 0 || tile_index == 1) position = 0;
			else if(tile_index == 2 || tile_index == 3) position = 1;
			UPDATE(tile_index,offset_counter,tile, position);
			//Update
			tile_index++;
			if(tile_index == 4)
			{
				tile_index = 0;
				offset_counter++;
			}
		}
		//-----------------------------------------------------------------
		if( (scanline % 2 == 1) && counter_line == 3)
		{
			if(tile_index == 0 || tile_index == 1) position = 2;
			else if(tile_index == 2 || tile_index == 3) position = 3;
			UPDATE(tile_index,offset_counter,tile, position);
			//Update
			tile_index++;
			if(tile_index == 4)
			{
				tile_index = 0;
				offset_counter++;
			}
		}

	}
}
word pattern_lookout(byte look)
{
	word index  = -1;
	int found = 0;
	int i;
	for( i = 0x0000; i < 0x2000; ++i)
	{
		if(look == PPU->MEM[i] )
		{
			//printf("byte found!\n");
			found = 1;
			index = i;
			break;
		}
	}
	//if(found == 0)printf("byte not found\n");
	return index;

}
byte mask(byte bit)
{
	byte result = 0x00;

	if(bit == 0)result = 0x01;	// 0000 0001;
	else if(bit == 1)result = 0x02;	// 0000 0010;
	else if(bit == 2)result = 0x04; // 0000 0100;
	else if(bit == 3)result = 0x08; // 0000 1000;
	else if(bit == 4)result = 0x10; // 0001 0000;
	else if(bit == 5)result = 0x20; // 0010 0000;
	else if(bit == 6)result = 0x40; // 0100 0000;
	else if(bit == 7)result = 0x80; // 1000 0000;
	else result = 0x00;

	return result;
}



int tile_retrieval(int x, int y)
{
	int tmp_x = x / 8;
	int tmp_y = y / 8;

	int result = (32 * tmp_y) + (tmp_x + 1);

	return result - 1;
}
byte scanline_retireval(int tile)
{
	byte result = 0;
	if(tile > 0 && tile < 32) result = 0;
	else if(tile >= 32 && tile < 64)  result = 1;
	else if(tile >= 64 && tile < 96)  result = 2;
	else if(tile >= 96 && tile < 128) result = 3;
	else if(tile >= 128 && tile < 160) result = 4;
	else if(tile >= 160 && tile < 192) result = 5;
	else if(tile >= 192 && tile < 224) result = 6;
	else if(tile >= 224 && tile < 256) result = 7;
	else if(tile >= 256 && tile < 288) result = 8;
	else if(tile >= 288 && tile < 320) result = 9;
	else if(tile >= 320 && tile < 352) result = 10;
	else if(tile >= 352 && tile < 384) result = 11;
	else if(tile >= 384 && tile < 416) result = 12;
	else if(tile >= 416 && tile < 448) result = 13;
	else if(tile >= 448 && tile < 480) result = 14;
	else if(tile >= 480 && tile < 512) result = 15;
	else if(tile >= 512 && tile < 544) result = 16;
	else if(tile >= 544 && tile < 576) result = 17;
	else if(tile >= 576 && tile < 608) result = 18;
	else if(tile >= 608 && tile < 640) result = 19;
	else if(tile >= 640 && tile < 672) result = 20;
	else if(tile >= 672 && tile < 704) result = 21;
	else if(tile >= 704 && tile < 736) result = 22;
	else if(tile >= 736 && tile < 768) result = 23;
	else if(tile >= 768 && tile < 800) result = 24;
	else if(tile >= 800 && tile < 832) result = 25;
	else if(tile >= 832 && tile < 864) result = 26;
	else if(tile >= 864 && tile < 896) result = 27;
	else if(tile >= 896 && tile < 928) result = 28;
	else if(tile >= 928 && tile < 960) result = 29;

	return result;
}


void UPDATE(byte tile_index, int offset_counter, int tile, byte position)
{
	byte decision;
	if(position == 0)
	{
		PPU->ATTRIBUTE_TABLE_INFO[tile].TL = 1;
		decision = 0x03;
	}
	else if(position == 1)
	{
		PPU->ATTRIBUTE_TABLE_INFO[tile].TR = 1;
		decision = 0x0C;
	}
	else if(position == 2)
	{
		PPU->ATTRIBUTE_TABLE_INFO[tile].BL = 1;
		decision = 0x30;
	}
	else if(position == 3)
	{
		PPU->ATTRIBUTE_TABLE_INFO[tile].BR = 1;
		decision = 0xC0;
	}

	if(tile_index == 0 || tile_index == 1)
	{
		PPU->ATTRIBUTE_TABLE_INFO[tile].BIT = decision;
		PPU->ATTRIBUTE_TABLE_INFO[tile].OFFSET = offset_counter;
	}
	else if(tile_index == 2 || tile_index == 3)
	{
		PPU->ATTRIBUTE_TABLE_INFO[tile].BIT = decision;
		PPU->ATTRIBUTE_TABLE_INFO[tile].OFFSET = offset_counter;
	}
}


/*THIS IS FOR DEBUGGING
 * IT DISPLAYS ALL FOUR NAMETABLES ON THE SCREEN
 *
 */
void draw_tile2(int x, int y, word ADDR_START, word attribute, byte number )
{
	//byte cycle = CPU->T; //The number of CPU Cycles to estimate PPU Cycles

	int x_start = x;
	int y_start = y;
	int x_finish = x+8;
	int y_finish = y+8;

	int VGA_Color;
	byte color_bit1 = 0;
	byte color_bit2 = 0;
	byte colors = 0;
	int PATTERN_TABLE_COUNTER = 0;
	int bit_location = 7;

	for(;y_start < y_finish; ++y_start)
	{
		color_bit1 = 0;
		color_bit2  = 0;
		bit_location = 7;
		x_start = x;
		x_finish = x+8;
		for(;x_start < x_finish; ++x_start)
		{
			//Assign the first  bit
			color_bit1 =   (PPU->MEM[ (ADDR_START + PATTERN_TABLE_COUNTER) ] & mask(bit_location)) >> bit_location;
			////Assign the second bit
			color_bit2=  (PPU->MEM[ (ADDR_START + PATTERN_TABLE_COUNTER) + 8 ] & mask(bit_location)) >> bit_location;

			//Assign the Third and fourth Bit
			int temp_tile = tile_retrieval(x_start, y_start);

			byte attribute_byte = PPU->MEM[attribute + PPU->ATTRIBUTE_TABLE_INFO[temp_tile].OFFSET];
			byte tmp_color;

			if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].TL == 1)
				tmp_color = (PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte) << 2;
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].TR == 1)
				tmp_color = (PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte);
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BL == 1)
				tmp_color = (PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte) >> 2;
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BR == 1)
				tmp_color = (PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte) >> 4;

			//tmp_color = 0x0000;

			colors = (color_bit1 | ( color_bit2 << 1));
			colors = (colors & 0x03); //| tmp_color;

			//obtain byte from background pallete
			byte sys_offset = PPU->MEM[BACKGROUND_PALETTE + colors];
			sys_offset = sys_offset & 0x3F;
			VGA_Color = toVGA(RGB[sys_offset]);


			//Output Pixel
			if(number == 0)
				alt_up_pixel_buffer_dma_draw( pix_buffer, VGA_Color, 2 + x_start, 2 + y_start );
			else if(number == 1)
				alt_up_pixel_buffer_dma_draw( pix_buffer, VGA_Color, 300+x_start, 2 + y_start );
			else if(number == 2)
				alt_up_pixel_buffer_dma_draw( pix_buffer, VGA_Color, 2 + x_start, 250 + y_start );
			else if(number == 3)
				alt_up_pixel_buffer_dma_draw( pix_buffer, VGA_Color, 300+x_start, 250+y_start );

			//Update the Bit counter
			bit_location--;
		}
		PATTERN_TABLE_COUNTER++;
	}
}
void nametable_display(byte number)
{
	word ADDR_START; //Gets the the address from pattern table in hex

		int X_RENDER = -8;
		int Y_RENDER = 0;

		int tile = 0;
		for(tile = 0; tile < 960; ++tile)
		{
			//update XY-coordinates
			if(tile % 32 == 0 && tile != 0){
				X_RENDER = 0;
				Y_RENDER += 8;
			}
			else if(tile % 32 != 0 )X_RENDER += 8;
			else if(tile == 0)X_RENDER += 8;

			word nametable, attribute;
			if(number == 0 ) {nametable = NAMETABLE_0; attribute = ATTRIBUTE_TABLE_0;}
			if(number == 1 ) {nametable = NAMETABLE_1; attribute = ATTRIBUTE_TABLE_1;}
			if(number == 2 ) {nametable = NAMETABLE_2; attribute = ATTRIBUTE_TABLE_2;}
			if(number == 3 ) {nametable = NAMETABLE_3; attribute = ATTRIBUTE_TABLE_3;}

			ADDR_START = 16 * PPU->MEM[nametable + tile] + ((PPUCTRL & 0x10) ? 0x1000 : 0x0000);

			draw_tile2( X_RENDER, Y_RENDER, ADDR_START, attribute, number);
		}
}

void nametable_viewer()
{
	int nametable;
	for(nametable = 0; nametable < 4; nametable++)
		nametable_display(nametable);
}

//static short PPU_CYCLE =  0;
void test_nametable()
{
	int i = 0;
	for(i = 0; i < 960; ++i)
	{
		printf("NameTable Byte ");
		printf("%d : ", i);
		printf("%x\n", PPU->MEM[NAMETABLE_0 + i]);
	}
	for(i = 0; i < 64; ++i)
		{
			printf("Attribute Byte ");
			printf("%d : ", i);
			printf("%x\n", PPU->MEM[ATTRIBUTE_TABLE_0 + i]);
		}
	for(i = 0; i < 8; ++i)
	{

	}
}

