#ifndef _6502_H_
#define _6502_H_
	

#include <stdio.h>
#include <malloc.h>

// Data types
typedef unsigned char byte;
typedef unsigned short word;

// Structs
typedef struct
{
  // Special Purpose Registers
  byte S;	// Stack Pointer
  byte P;	// Status Register
  word PC;	// Program Counter [16-bits]

  
  // General Purpose Registers
  byte A;	// Accumulator
  byte X;	// Index X
  byte Y;	// Index Y

  word AB;	// Address Bus
  byte DB;	// Data Bus

  byte IR;	// Instruction Register
  byte T;       // Current instruction state. Simulates cycles.

  byte* MEM;    // CPU Memory Map
} NMOS6502; 


// Functions


/* Function:    load_rom
   Description: Takes in ROM file as input, stripping unnecessary
                headers and splitting PRG/CHR rom memory. */
void load_rom(char* file, byte** prg_array, byte** chr_array, byte* prg_size, byte* chr_size);

/* Function:    execute_instruction
   Description: Takes in opcode and executes instruction. 
                Opcode is taken in from CPU struct. */
void execute_instruction();

/* CPU Setup/Debug Functions */
void cpu_init();
void cpu_status();
				/* Absolute OPCODES */
				/* Accumulator OPCODES */
				/* Immediate OPCODES */
				/* Implied OPCODES */
				/* Indexed Absolute OPCODES */
				/* Indexed Indirect OPCODES */
				/* Indexed Zero Page OPCODES */
				/* Indirect Indexed OPCODES */
				/* Indirect OPCODES */
				/* Relative OPCODES */
				/* Zero Page OPCODES */




#endif   // 6502_H
