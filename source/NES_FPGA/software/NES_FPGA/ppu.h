#ifndef PPU_H_
#define PPU_H_

#include "NES.h"

/* Initializes PPU registers and memory */
inline void ppu_init();

/* Executes PPU on cycle by cycle basis. */
inline void ppu_exec();

/* Renders PPU to screen based on scanline counter. */
inline void ppu_render();


#endif /* PPU_H_ */
