#ifndef NES_H_
#define NES_H_

//=========================================================
//						LIBRARIES
//=========================================================
#include <stdio.h>
#include <malloc.h>
#include <altera_up_sd_card_avalon_interface.h>
//#include <altera_up_avalon_video_character_buffer_with_dma.h>
#include <altera_up_avalon_video_pixel_buffer_dma.h>
#include "system.h"
#include "sys/alt_irq.h"
#include "alt_types.h"
#include "sys/alt_sys_init.h"


//=========================================================
// 		[General] 	Definitions
//=========================================================

/* Data types */
typedef unsigned char byte;     // 8-bit type for data and registers
typedef unsigned short word;    // 16-bit type for addressing

/* Set these the corresponding memory locations */
#define player1 0x00			// Button input from controller 1
#define player2 0x10			// Button input from controller 2


/* Helper macros. Source: StackOverflow */
#define BYTETOBINARYPATTERN "%d%d%d%d%d%d%d%d"  // Displays a byte in binary
#define BYTETOBINARY(byte)  \
  (byte & 0x80 ? 1 : 0), \
  (byte & 0x40 ? 1 : 0), \
  (byte & 0x20 ? 1 : 0), \
  (byte & 0x10 ? 1 : 0), \
  (byte & 0x08 ? 1 : 0), \
  (byte & 0x04 ? 1 : 0), \
  (byte & 0x02 ? 1 : 0), \
  (byte & 0x01 ? 1 : 0)



//=========================================================
// 		[General] 	Global/Temporary Variables, used by all
//=========================================================

byte chr_size; 			// The number of PRG banks in ROM
byte prg_size; 			// The number of CHR banks in ROM
byte cpu_sram_batt;	    // SRAM in CPU is battery packed
byte trainer;           // 512-byte trainer at $7000-7FFF
byte cpu_sram;          // $6000-$7FFF.  0 if present, 1 if not present
byte prg_ram_size;      // in 8 kB units
byte tv_system;         // Unused. 0: NTSC, 1: PAL
byte mapper;	        // Type of NES cart mapper
byte mirroring;         // Horizontal, vertical, or four-screen mirroring.

char* file_name;		// The name of the ROM

//alt_up_char_buffer_dev* char_buffer;		// Character Buffer for Altera
alt_up_pixel_buffer_dma_dev* pix_buffer;    // Color/pixel Buffer for Altera


// --------------------------------------------------------------------------------------//
// --------------------------------------------------------------------------------------//


//=========================================================
//	[NES CPU - RP2A03]  Structs and Definitions
//=========================================================


/* Structs */
typedef struct // 6502 Microprocessor Struct
{
  // Special Purpose Registers
  word PC;	// Program Counter [16-bits]
  byte S;	// Stack Pointer

  struct	// Status Register
  {
    byte C; // Carry
    byte Z; // Zero
    byte I; // Interrupt Disable
    byte D; // Not required. BCD disabled in RP2A03
    byte B; // BRK (Only present in Stack)
    byte V; // Overflow
    byte N; // Negative
  } P;

  // General Purpose Registers
  byte A;	// Accumulator
  byte X;	// Index X
  byte Y;	// Index Y

  word AB;	// Address Bus. [UNUSED]
  byte DB;	// Data Bus.    [UNUSED]
  byte IR;	// Instruction Register
  byte T;   // The number of clock cycles the last instruction took

  byte* MEM;  // CPU Memory

  unsigned int instructions; // Total instruction count for the CPU

  // Interrupt Signals
  byte NMI; // Non-maskable interrupt. Set by the PPU.
  byte RES; // Reset interrupt. Set on emulator shut on / reset.
  byte IRQ; // Interrupt Request. Set by program.

  byte page_boundary;	// Used in calculating cycle count. This is when CPU takes an extra
  	  	  	  	  	  	// cycle to do a carry when adding an address.

  byte exit;	// Debug variable used for throwing an error at invalid opcodes.

  /* CPU Memory Map Mirroring:
	RAM: [0, 0x1FFF]
	The address lines 0x800-0x1FFF is mirrored with 0-0x7FF,
	thus the RAM is really RAM[index & 0x7FF] when accessing RAM[0-0x1FFF].

	PPU: [0x2000, 0x3FFF] [0x4014]
	These are memory mapped registers to interact with the PPU, they are
	used to read the PPU status, and to read/write memory to. They will be
	covered more in detailed in the PPU section. They are mirrored every
	8 bytes so assuming the addr[0] is 0x2000 and on, the access operation
	will be it will be addr[index & 0x07]. The 0x4014 address
	is used for quick transferring of 256 bytes (DMA) to the sprite memory
	space covered in the PPU section.
   */
} RP2A03;

/* CPU Definitions */
#define PRG     0x8000    // Length: 0x8000 Program Memory
#define PPUREG  0x2000	  // Length: 0x2000 PPU Registers
#define SRAM    0x6000    // Length: 0x2000
#define EROM    0x4020    // Length: 0x1180
#define STACK   0x0100    // Length: 0x0100 Stack Memory

#define IRQL	 0xFFFE   // Interrupt Request Low
#define IRQH	 0xFFFF   // Interrupt Request High
#define RESL     0xFFFC   // Reset Vector Low
#define RESH     0xFFFD   // Reset Vector High
#define NMIL     0xFFFA   // Non-maskable Interrupt Low
#define NMIH     0xFFFB   // Non-maskable Interrupt High


//=========================================================
//	[NES CPU - RP2A03]  Global/Temporary variables
//=========================================================

RP2A03* CPU;			 // CPU Struct Instance

word t1, t2, l , h;		 // Temp values:
word temp;				 // Used in cpu_exec()
word temp2;				 // "
word temp_addr;			 // "
byte operand;			 // "
signed short pb;		 // "

// --------------------------------------------------------------------------------------//
// --------------------------------------------------------------------------------------//

//=========================================================
//	[NES Picture Processing Unit]  Structs and Definitions
//=========================================================

typedef struct	// PPU Attribute Table Information
{
	byte TL;
	byte TR;
	byte BL;
	byte BR;
	byte OFFSET;
	byte BIT;
	byte SCANLINE;
}ATT_TABLE_INFO;

typedef struct
{
	byte* MEM;	// PPU Memory Map

	byte* OAM;				// PPU Object Attribute Memory, AKA Sprite Table
	byte* sprite_buffer;	// Stores data of sprites during rendering.

	short scanline;			// The current scanline of the PPU, for rendering.
	short cycle;			// The current cycle of the PPU for a certain scanline.
	short last_cycle;		// Either 340 or 341 based on odd_frame.
	byte odd_frame; 		// Used for scanline -1. If we're displaying an odd_frame, use 340 cycles instead of 341.

	word ppuaddr;			// Register variable for 16 bit address in $2006
	word ppuaddr_temp;		// This overwrites ppuaddr once both upper and lower byte of $2006 is written.

	word ppuscroll; 		// Register variable for 16 bit address in $2005
	word ppuscroll_temp;		// This overwrites ppuaddr once both upper and lower byte of $2006 is written.

	byte ppu_addwrite;		// Determines if we're on 1st or 2nd write to $2005/2006
	byte ppu_scrollwrite;   // Same, but for $2005
	word tempa;				// Temp variable for holding 16 bits

	/*
	One byte of the name table holds the address of one tile (8x8 pixel),
	making up 32x30 (0x3C0 bytes) rows of data. (32*8) = 256 and (30*8)=240,
	thus making one name table the resolution of the PPU.
	 */
	ATT_TABLE_INFO* ATTRIBUTE_TABLE_INFO;

} RP2C02;


/* PPU Definitions */
#define PATTERN_TABLE_0		0x0000		// Sprite Pattern Table
#define PATTERN_TABLE_1		0x1000		// Background Pattern Table

#define NAMETABLE_0			0x2000		// The BG tiles to be displayed on screen. 32x30. (960 bytes total)
#define ATTRIBUTE_TABLE_0	0x23C0		// The upper 2 bits of palette colors for tiles. 1 byte populates 16 tiles. (64 bytes total, 4 unused)
#define NAMETABLE_1			0x2400
#define ATTRIBUTE_TABLE_1	0x27C0
#define NAMETABLE_2			0x2800
#define ATTRIBUTE_TABLE_2	0x2BC0
#define NAMETABLE_3			0x2C00
#define ATTRIBUTE_TABLE_3	0x2FC0

#define NAMETABLE_MIRROR 	0x3000

#define BACKGROUND_PALETTE 	0x3F00
#define SPRITE_PALLETE  	0x3F10

#define PALETTE_MIRROR 		0x3F20


/* PPU-CPU I/O Registers */
#define	PPUCTRL_ADDR 0x2000
#define PPUCTRL	CPU->MEM[0x2000]			 // Register $2000 in CPU.
#define BASENTABLE		(CPU->MEM[0x2000] & 0x03)
#define VRAM_ADDR_INC   (CPU->MEM[0x2000] & 0x04) ? 1 : 0
#define SPRITE_PTABLE   (CPU->MEM[0x2000] & 0x08) ? 1 : 0
#define BG_PTABLE 	    (CPU->MEM[0x2000] & 0x10) ? 1 : 0

/*
76543210
||||||||
||||||++- Base nametable address
||||||    (0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00)
|||||+--- VRAM address increment per CPU read/write of PPUDATA
|||||     (0: increment by 1, going across; 1: increment by 32, going down)
||||+---- Sprite pattern table address for 8x8 sprites (0: $0000; 1: $1000)
|||+----- Background pattern table address (0: $0000; 1: $1000)
||+------ Sprite size (0: 8x8; 1: 8x16)
|+------- PPU master/slave select (has no effect on the NES)
+-------- Generate an NMI at the start of the
          vertical blanking interval (0: off; 1: on)

          Writing to PPUCTRL triggers multiple NMIs.
*/

#define PPUMASK		CPU->MEM[0x2001]			// Register $2001
/*
	This is a write only register, reading it will return open bus. This
	register controls some operations of the PPU when it writes to the screen.

76543210
||||||||
|||||||+- Grayscale (0: normal color; 1: AND all palette entries
|||||||   with 0x30, effectively producing a monochrome display;
|||||||   note that colour emphasis STILL works when this is on!)
||||||+-- Enable background in leftmost 8 pixels of screen (0: no; 1:yes)
|||||+--- Enable sprite in leftmost 8 pixels of screen (0: no; 1: yes)
||||+---- Enable background rendering
|||+----- Enable sprite rendering
||+------ Intensify reds (and darken other colors)
|+------- Intensify greens (and darken other colors)
+-------- Intensify blues (and darken other colors)
 */

#define PPUSTATUS	CPU->MEM[0x2002]  // Register  $2002
#define VBLANK		(CPU->MEM[0x2002] & 0x80) ? 1 : 0
#define SPRITE0HIT  (CPU->MEM[0x2002] & 0x40) ? 1 : 0
#define SPRITEVFLOW (CPU->MEM[0x2002] & 0x20) ? 1 : 0
/*
	This register returns the status of the PPU. This is read-only.
	Writing to it does nothing.

76543210
||||||||
|||+++++- Unimplemented (read back as open bus data)
||+------ Sprite overflow. The PPU can handle only eight sprites on one
||        scanline and sets this bit if it starts dropping sprites.
||        Normally, this triggers when there are 9 sprites on a scanline,
||        but the actual behavior is significantly more complicated.
|+------- Sprite 0 Hit.  Set when a nonzero pixel of sprite 0 'hits'
|         a nonzero background pixel.  Used for raster timing.
+-------- Vertical blank has started (0: not in VBLANK; 1: in VBLANK)
*/


#define OAMADDR		CPU->MEM[0x2003]				// Register $2003
/*
	The address of where OAMDATA will use, it is also the starting address
	that SPRDMA will use to to write data to the sprite address. it is write
	only, reading will return open bus. Writing here during the PPU rendering
	might mess up the sprite rendering, though the exact behavior isn't
	figured out yet.
 */


#define OAMDATA		CPU->MEM[0x2004]				// Register $2004
/*
	This the the register used to communicate with the sprite data, it
	returns whatever is in the OAMADDR is set to when the PPU is not rendering
	graphics, if it is, then it returns what the PPU is reading from the
	sprite data to render onto the screen. The OAMADDR is auto incremented
	on writes to this. Attribute regs bit 5 to 8 are unimplemented,
	read back 0 here, so data &= 0xE3. Reading here increments the OAMADDR,
	when it is over 0xFF mark, it wraps back to 0. Writing here does *not*
	increment the OAMADDR however.

 */

#define PPUSCROLL	CPU->MEM[0x2005]				// Register $2005
/*
	This affects where the PPU will read from the name table.
	It modifies the horizontal and vertical offset of the name table read, a
	detailed explanation of it will be given in a later section.
 */

#define PPUADDR		CPU->MEM[0x2006]				// Register $2006
/*
	This is the register where you write the address that you want to
	read from or write to using PPUDATA (0x2007). Games must not ever
	write to this address during rendering, or it will mess up the display,
	this will be explained in a later section. Reading here will return
	open bus. During rendering the address written here will be the
	"program counter" for the PPU, so this is why it messes up, because
	the PPU also increments that register as its rendering leading to
	addresses you don't want. Only use this during vblank to update
	graphic data.
*/

#define PPUDATA		CPU->MEM[0x2007]				// Register $2007
/*
	This address is used to write or read data from the specified address
	in PPUADDR (0x2006). Do not read from or write to this address during
	rendering, it will mess up the display. If you do read from it it returns
	the internal operation of the PPU, and if you write to it, it writes to
	address the PPU currently is using to get data to draw to the screen.
	The reason it messes it up is because it increments the "program counter"
	of the PPU which causes distortions to the rendering. I believe the
	rationale for incrementing the program counter automatically on a read or
	write is to help the programmer save precious VBLANK time from
	manually incrementing it themselves. Since the only time you can write
	to the graphics or read from it is VBLANK or when the PPU is turned "off".
	Reads are delayed by one cycle, discard the first byte read, in example,
	here is how one reads 0x2007:

	tmp = cpu.reg2007; cpu.reg2007 = data; return tmp;
	However, if the address is in the palette range, that is (0x3F00 to 0x3FFF)
	accesses the address, without the delayed read. On writes to the 0x2007
	register, if the game uses CHR-ROM, writing to memory address [0, 0x1FFF]
	should do nothing, while it works normally for CHR-RAM.
	PPUADDR is incremented with the value set in PPUCTRL after every read or
	write to 0x2007. There is one last quirk, and that is if the register
	0x2006 address is in the palette range, that is if the range is
	((ppu.reg[6] & 0x3F00) == 0x3F00) what is returned is the palette data,
	but what is copied to the delayed buffer is addr[ppu.reg[6] - 0x1000];
 */

#define SPR_DMA  0x4014   // PPU Sprite DMA (256 bytes) to populate OAM (Sprite Table)


//=========================================================
//	[NES Picture Processing Unit]  Global/Temporary variables
//=========================================================

RP2C02* PPU;			 // PPU Struct Instance


// --------------------------------------------------------------------------------------//
// --------------------------------------------------------------------------------------//

//=========================================================
//	[NES pseudo Audio Processing Unit] Definitions
//=========================================================




#endif /* NES_H_ */
