#ifndef _6502_H_
#define _6502_H_
	

#include <stdio.h>
#include <malloc.h>

/* Data types */
typedef unsigned char byte;
typedef unsigned short word;

/* Memory Map Offsets */
#define PRG     0x8000    // Length: 0x8000
#define SRAM    0x6000    // Length: 0x2000
#define EROM    0x4020    // Length: 0x1180
#define STACK   0x0100    // Length: 0x0100

#define RESL     0xFFFC
#define RESH     0xFFFD

/* Structs */
typedef struct
{
  // Special Purpose Registers
  word PC;	// Program Counter [16-bits]
  byte S;	// Stack Pointer
  struct
  {
    byte C;
    byte Z;
    byte I;
    byte D; // Not required. BCD disabled in RP2A03
    byte B;
    byte V;
    byte N;
  } P;       	// Status Register

  
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



/* Function:    load_rom
   Description: Takes in ROM file as input, stripping unnecessary
                headers and splitting PRG/CHR rom memory. */
void load_rom(char* file, byte** prg_array, byte** chr_array, byte* prg_size, byte* chr_size);

/* Function:    mmap_init
   Description: Initializes CPU memory map with PRG_ROM */
void mmap_init(byte** prg_array);

/* Function:    execute_instruction
   Description: Takes in opcode and executes instruction. 
                Opcode is taken in from CPU struct. */
void cpu_exec();



/* CPU Setup/Debug Functions */
inline void cpu_init();
inline byte cpu_read(word addr);
inline byte cpu_write(word addr, byte data);
inline void cpu_status();



/* Instruction functions separated by Adressing Mode and Uniqueness */
byte ABS();
byte ABSX();
byte ABSY();
byte XIND();
byte INDY();
byte IMM();
byte ZP();
byte ZPX();

// Not Implemented: (Used directly in cases)
//ACC
//IMP
//IND
//REL
//ZPY


void ADC( byte operand  );
void AND( byte operand  );
void ASL( byte* operand );	
void CMP( byte operand  );	
void CPX( byte operand  );	
void CPY( byte operand  );
void DEC( byte* operand );
void INC( byte* operand );
void LDA( byte operand  );
void LDX( byte operand  );
void LDY( byte operand  );
void LSR( byte* operand );
void ORA( byte operand  );
void ROL( byte* operand );
void ROR( byte* operand );
void SBC( byte operand  );

#endif   // 6502_H
