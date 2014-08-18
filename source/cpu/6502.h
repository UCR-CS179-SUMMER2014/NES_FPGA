#ifndef _6502_H_
#define _6502_H_
	

#include <stdio.h>


typedef unsigned char byte;
typedef unsigned short word;

typedef struct
{
	// Special Purpose Registers
	byte S;		// Stack Pointer
	byte P;		// Status Register
	word PC;	// Program Counter [16-bits]

	
	// General Purpose Registers
	byte A;		// Accumulator
	byte X;		// Index X
	byte Y;		// Index Y

	word AB;	// Address Bus
	byte DB;	// Data Bus
	
	byte IR;	// Instruction Register
	byte state; // Current instruction state. Simulates cycles.
	
} NMOS6502; 

				
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
