#ifndef NES_H_
#define NES_H_

//=========================================================
//						LIBRARIES
//=========================================================
#include <stdio.h>
#include <malloc.h>
#include <altera_up_sd_card_avalon_interface.h>
#include <altera_up_avalon_video_character_buffer_with_dma.h>
#include <altera_up_avalon_video_pixel_buffer_dma.h>
#include "system.h"
#include "sys/alt_irq.h"
#include "alt_types.h"
#include "sys/alt_sys_init.h"


//=========================================================
//				STRUCTS AND DEFINITIONS
//=========================================================

/* Data types */
typedef unsigned char byte;     // 8-bit
typedef unsigned short word;    // 16-bit

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

  word AB;	// Address Bus.
  byte DB;	// Data Bus.
  byte IR;	// Instruction Register
  //byte T;   // Current instruction state. Simulates cycles. Unused

  // Interrupt Signals
  byte NMI; // Non-maskable interrupt. Set by the PPU.
  byte RES; // Reset interrupt. Set on emulator shut on / reset.
  byte IRQ; // Interrupt Request. Set by program.

  byte* MEM;  // CPU Memory
} NMOS6502;


/* Definitions */
#define PRG     0x8000    // Length: 0x8000 Program Memory
#define SRAM    0x6000    // Length: 0x2000
#define EROM    0x4020    // Length: 0x1180
#define STACK   0x0100    // Length: 0x0100 Stack Memory

#define IRQL	 0xFFFA   // Interrupt Request Low
#define IRQH	 0xFFFB   // Interrupt Request High
#define RESL     0xFFFC   // Reset Vector Low
#define RESH     0xFFFD   // Reset Vector High
#define NMIL     0xFFFE   // Non-maskable Interrupt Low
#define NMIH     0xFFFF   // Non-maskable Interrupt High


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
//					GLOBAL VARIABLES
//=========================================================
byte* CHR_ROM; // Holds CHR data stored in ROM
byte chr_size; // The number of PRG banks in ROM
byte prg_size; // The number of CHR banks in ROM

alt_up_char_buffer_dev* char_buffer;		// Character Buffer for Altera
alt_up_pixel_buffer_dma_dev* pix_buffer;    // Color/pixel Buffer for Altera

char* file_name;		 // The name of the ROM
NMOS6502* CPU;			 // CPU Struct Instance


//=========================================================
//					ALTERA CYCLONE CONNECTIONS
//=========================================================
/* Set these the corresponding memory locations */
#define player1 0x00			// Button input from controller 1
#define player2 0x10			// Button input from controller 2


#endif /* NES_H_ */
