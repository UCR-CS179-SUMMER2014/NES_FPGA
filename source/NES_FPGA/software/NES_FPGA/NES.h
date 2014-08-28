#ifndef NES_H_
#define NES_H_

//=========================================================
//						LIBRARIES
//=========================================================
#include <stdio.h>
#include <malloc.h>
#include <altera_up_sd_card_avalon_interface.h>
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

  byte* MEM;  // CPU Memory Map
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

//=========================================================
//					GLOBAL VARIABLES
//=========================================================
byte* CHR_ROM; // Holds CHR data stored in ROM
byte chr_size; // The number of PRG and CHR banks in ROM
byte prg_size;

NMOS6502* CPU;			 // CPU Struct Instance


//=========================================================
//					ALTERA CYCLONE CONNECTIONS
//=========================================================
/* Set these the corresponding memory locations */
#define player1 0x00			// Button input from controller 1
#define player2 0x10


#endif /* NES_H_ */
