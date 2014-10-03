#include "ppu.h"

static short i;			// Temp variable for loops

int RGB[64] = {
			0x7C7C7CFF,
			0x0000FCFF,
			0x0000BCFF,
			0x4428BCFF,
			0x940084FF,
			0xA80020FF,
			0xA81000FF,
			0x881400FF,

			0x503000FF,
			0x007800FF,
			0x006800FF,
			0x005800FF,
			0x004058FF,
			0x000000FF,
			0x000000FF,
			0x000000FF,

			0xBCBCBCFF,
			0x0078F8FF,
			0x0058F8FF,
			0x6844FCFF,
			0xD800CCFF,
			0xE40058FF,
			0xF83800FF,
			0xE45C10FF,

			0xAC7C00FF,
			0x00B800FF,
			0x00A800FF,
			0x00A8A8FF,
			0x008888FF,
			0x000000FF,
			0x000000FF,
			0x000000FF,

			0xF8F8F8FF,
			0x3CBCFCFF,
			0x6888FCFF,
			0x9878F8FF,
			0xF878F8FF,
			0xF85898FF,
			0xF87858FF,
			0xFCA044FF,

			0xF8B800FF,
			0xFFFFFFFF,
			0x58D854FF,
			0x58F898FF,
			0x00E8D8FF,
			0x787878FF,
			0x000000FF,
			0x000000FF,

			0xFCFCFCFF,
			0xA4E4FCFF,
			0xB8B8F8FF,
			0xD8B8F8FF,
			0xF8B8F8FF,
			0xF8A4C0FF,
			0xF0D0B0FF,
			0xFCE0A8FF,

			0xF8D878FF,
			0xD8F878FF,
			0xB8F8B8FF,
			0xB8F8D8FF,
			0x00FCFCFF,
			0xD8D8D8FF,
			0x000000FF,
			0x000000FF};

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


/* Handles reads and writes to special PPU registers. */
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
		// We're on the first write
		if(PPU->ppu_scrollwrite == 0)
		{
			PPU->ppuscroll = ( (word) data) << 8;
			PPU->ppu_scrollwrite = 1;
		}
		// We're on the second write
		else
		{
			// We now have our 16 bits of data
			PPU->ppuscroll |= data;	// Write to PPU Scroll register now.
			PPU->ppu_scrollwrite = 0;
		}
	}
	// TODO: FIX PPUADDR WRITES OMFG
	else if( addr == 0x2006 ) // PPUADDR
	{
		//printf("\n\nWriting %x to $2006\n\n", data);
		PPUADDR = data;

		// We're on the first write
		if(PPU->ppu_addwrite == 0)
		{
			PPU->ppuaddr_temp = data << 8;				// Don't overwrite ppuaddr until the second (lower) byte is written
			PPU->ppu_addwrite = 1;						// Signal that we've written the higher byte, now for the lower byte
		}
		// We're on the second write
		else
		{
			PPU->ppuaddr = PPU->ppuaddr_temp | data;	// Now that lower byte is given, overwrite ppuaddr.
			PPU->ppu_addwrite = 0;						// Signal that we're back to writing the higher byte
		}
	}
	else if( addr == 0x2007 ) // PPUDATA
	{
		//printf("\n\nWriting %x to $2007\n\n", data);

		PPUDATA = data;
		PPU->MEM[ PPU->ppuaddr ] = PPUDATA;

		//Auto Incremenent ppuaddr depending on PPUCTRL bit 3
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
				render_to_screen();

				// Now we're in Vblank time.
				PPUSTATUS |= 0x80;

				// NMI gets generated if bit 7 of $2000 is set.
				CPU->NMI = (PPUCTRL & 0x80) ? 1 : 0;
			}
			else if( PPU->scanline == 260 )
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

  PPU->scanline = -1;
  PPU->cycle = 0;
  PPU->last_cycle = 340;
  PPU->odd_frame = 1;
  PPU->ppu_addwrite = 0;
  PPU->ppu_scrollwrite = 0;
  PPU->tempa = 0;
  PPU->ppuaddr = 0;
  PPU->ppuscroll = 0;

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
  	pallet_init(); //Sets the color palletes

  	//byte temp = 0x00;
  	/*for(tile = 0x2000; tile < 0x23C0; ++tile)
  	{
  		PPU->MEM[tile] = (tile - 0x2000) % 0xFF;
  	}*/

  return;
}
void pallet_init()
{

}

void draw_tile(int x, int y, word ADDR_START )
{
	int x_start = x;
	int y_start = y;
	int x_finish = x+8;
	int y_finish = y+8;
	//printf("   x_start %d\n", x_start );
	//printf("   y_start %d\n", y_start );
	//printf("   x_finsh %d\n", x_finish );
	//printf("   y_finish %d\n",y_finish );

	byte color_bit1 = 0;
	byte color_bit2 = 0;
	byte colors = 0;
	int PATTERN_TABLE_COUNTER = 0;
	int bit_location = 7;

	for(;y_start < y_finish; ++y_start)
	{
		//printf("   y_start %d\n", y_start );
		color_bit1 = 0;
		color_bit2  = 0;
		bit_location = 7;
		x_start = x;
		x_finish = x+8;
		//printf("   Line----\n");
		for(;x_start < x_finish; ++x_start)
		{
			//printf("	Color bit_location %d\n", bit_location);
			//Assign the first  bit
			color_bit1 =   (PPU->MEM[ (ADDR_START + PATTERN_TABLE_COUNTER) ] & mask(bit_location)) >> bit_location;
			////Assign the second bit
			//printf("	Color bit0: %x\n", color_bit1);
			color_bit2=  (PPU->MEM[ (ADDR_START + PATTERN_TABLE_COUNTER) + 8 ] & mask(bit_location)) >> bit_location;
			//printf("	Color bit1: %x\n", color_bit2);

			//Assign the Third and fourth Bit
			int temp_tile = tile_retrieval(x_start, y_start);
			//printf("	temp_tile %d\n", temp_tile);

			byte attribute_byte = PPU->MEM[ATTRIBUTE_TABLE_0 + PPU->ATTRIBUTE_TABLE_INFO[temp_tile].OFFSET];
			byte tmp_color;
			//printf("	attribute_byte %x\n", attribute_byte);


			if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].TL == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte << 2;
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].TR == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte;
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BL == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte >> 2;
			else if(PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BR == 1)
				tmp_color = PPU->ATTRIBUTE_TABLE_INFO[temp_tile].BIT & attribute_byte >> 4;

			//printf("	tmp_color %x\n", tmp_color);

			colors = (color_bit1 | ( color_bit2 << 1));
			//printf("	colors %d\n", colors);
			//By now Colors should have the 4bit color to be look on the palette
			colors |= tmp_color;
			//printf("	colors %x\n", colors);

			//obtain byte from background pallete
			int VGA_Color = RGB[colors];
			//int VGA_Color = PPU->MEM[BACKGROUND_PALETTE + colors];
			//printf("	VGA_Color %x\n", VGA_Color);

			//Output Pixel
			//pix_buffer->color_mode = ALT_UP_8BIT_COLOR_MODE	;
			alt_up_pixel_buffer_dma_draw( pix_buffer, VGA_Color, 100+x_start,100+y_start );

			//printf("Pixel: %d\n", x_start*y_start);
			//char* en;
			//fgets(en, 2, stdin);
			//printf("	=========================\n");

			//Update the Bit counter
			bit_location--;
		}
		PATTERN_TABLE_COUNTER++;
	}

	//printf("Tile completed========\n");
}
void render_to_screen()
{
	//printf("Start Rendering\n");
	byte NMTA; //get name table address
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

		ADDR_START = 16 * PPU->MEM[NAMETABLE_0 + tile] + (PPUCTRL & 0x10) ? 0x1000 : 0x0000;
		NMTA = PPU->MEM[ADDR_START ];

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



/* Attribute Table notes:
 *
  	2 bits inside the attribute table is shared by 2 tiles,
	making up 4 grouping of 8x8 pixels, making one attribute
	byte controlling 32x32 block pixels.

	+---+---+---+---+
	|   |   |   |   |
	+ D1-D0 + D3-D2 +
	|   |   |   |   |
	+---+---+---+---+
	|   |   |   |   |
	+ D5-D4 + D7-D6 +
	|   |   |   |   |
	+---+---+---+---+


inline void ppu_init()
{
  PPU = (RP2C02*) malloc(sizeof(RP2C02));
  PPU->MEM = (byte*) malloc(sizeof(byte)*65535);
  PPU->OAM = (byte*) malloc(sizeof(byte)*256);
  PPU->sprite_buffer = (byte*) malloc(sizeof(byte)*32);

  int i;
  for(i = 0; i < 65535; ++i)
  {
	  PPU->MEM[i] = 0x00;
	  if(i < 256)
		  PPU->OAM[i] = 0x00;
	  if(i < 32)
		  PPU->sprite_buffer[i] = 0x00;
  }

  PPU->scanline = -1;

  return;
}

// PPU has 341 cycles per scanline. Therefore,


inline void ppu_exec()
{

	if( PPU->cycles < 64)
	{
		// Sprite Buffer initialization. [Secondary OAM]
		// Note: all data is set to $FF to set unused sprites as hidden from frame.
		// "Attempting to read $2004 will return $FF"
	}
	else if( PPU->cycles > 63 && PPU->cycles < 256 )
	{
		// Sprite Evaluation.
		// Sprites are read from primary OAM [Sprite Table], and written to Sprite Buffer

		// Read Y-coordinate, as long as # of sprites < 8 per scanline.

		// If sprite's Y is in range, copy remaining bytes to sprite buffer.

		// Increment address/index

		// Once 8 sprites have been found, disable writes to sprite buffer. Then,
		// Grab the rest of the bytes.

	}
	else if( PPU->cycles > 255 && PPU->cycles < 320 )
	{
		// Sprite fetches. Fetch 8 sprites, taking 8 cycles per sprite.
		// Read Y coordinate, tile number, attributes, and X coordinate.

		// "On the first empty sprite slot, read the Y-coordinate of
	    // sprite #63 followed by $FF for the remaining 7 cycles
        // On all subsequent empty sprite slots, read $FF for all 8 reads"


	}
	else if( PPU->cycles > 319 && PPU->cycles < 341 )
	{
		// Background render pipeline initialization

		// Read first byte in sprite buffer.
		// If no sprites were found, then use sprite #63
	}
}

inline void ppu_render()
{
	// In NTSC, we have 20 scanlines of VBlank time. 262 total scanlines.
	int i = 0;
	for( i = 0; i < CPU->T; ++i)
	{
		if(PPU->scanline == -1)
		{
			// Doesn't render, but reading data starts here
		}
		else if(PPU->scanline > -1 && PPU->scanline < 240 )
		{
			// This is when the PPU starts rendering.
		}
		else if(PPU->scanline > 239 && PPU->scanline < 262 )
		{
			// This is VBlank time
		}
		++PPU->scanline;
	}
}
*/

