#include "ppu.h"


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

 */
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

/* PPU has 341 cycles per scanline. Therefore,

 */
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


