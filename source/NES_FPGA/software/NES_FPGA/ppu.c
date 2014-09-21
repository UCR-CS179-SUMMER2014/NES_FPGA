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
  return;
}





