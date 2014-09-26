#ifndef PPU_H_
#define PPU_H_

#include "NES.h"

inline void ppu_status();						   // Display PPU Status
inline void write_ppu_reg( byte data, word addr ); // Used for $2004/$2005

inline void ppu_init();
void pallet_init();
int tile_retrieval(int x, int y);
byte scanline_retireval(int tile);
void attribute_offset_set();
void UPDATE(byte tile_index, int offset_counter, int tile, byte position);
byte mask(byte bit);
void PATTERN_SETS_INSERT();
word pattern_lookout(byte look);
void render_to_screen();
void ppu_exec();

/* Initializes PPU registers and memory
inline void ppu_init();

//Executes PPU on cycle by cycle basis.
inline void ppu_exec();

Renders PPU to screen based on scanline counter.
inline void ppu_render();
*/

#endif /* PPU_H_ */
