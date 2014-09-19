#ifndef CPU_H_
#define CPU_H_

#include "NES.h"

/*
 * Outputs contents of PRG ROM
 */
void prg_test();

/* Function:    cpu_reset
   Description: Initializes CPU */
inline void cpu_reset();

/* Function:    cpu_reset
   Description: Sets PC to NMI vector */
inline void cpu_nmi();

/* Function:    cpu_irq
   Description: Sets PC to IRQ vector  */
inline void cpu_irq();

/* Function:    cpu_init
 * Description: Sets up CPU by allocating memory and uses default signals.
 * 				Memory => Zero.
 * 				A, X, Y => Zero. P => 0010 0000
 * 				RES => 1         S => 0xFD */
inline void cpu_init();


/* Read the contents of PC, then increment it */
inline byte cpu_read();

/* Read the contents of the address in CPU memory */
inline byte cpu_mem_read( word addr );

/* Write contents to address in CPU memory */
inline void cpu_mem_write( byte data, word addr );

/* Function:    execute_instruction
   Description: Takes in opcode and executes instruction.
                Opcode is taken in from CPU struct. */
void cpu_exec();



/* CPU Setup/Debug Functions */
inline void cpu_status();



/* Instruction functions separated by Adressing Mode and Uniqueness */
byte ABS();  // Absolute
byte ABSX(); // Absolute, X
byte ABSY(); // Absolute, Y
byte XIND(); // (Indirect, X)
byte INDY(); // (Indirect), Y
byte IMM();  // Immediate [ #$50 ]
byte ZP();   // Zero Page
byte ZPX();  // Zero Page, X

// Addressing Modes not implemented: (Used directly in cases)
//ACC  - Accumulator
//IMP  - Implied (No extra operands)
//IND  - Indirect (JMP)
//REL  - Relative (Comparisons)
//ZPY  - Zero Page, Y


void ADC( byte operand  ); // Add with Carry
void AND( byte operand  ); // AND
void ASL( byte* operand ); // Arithmetic Shift Left
void CMP( byte operand  ); // Compare
void CPX( byte operand  ); // Copy X
void CPY( byte operand  ); // Copy Y
void DEC( byte* operand ); // Decrement
void INC( byte* operand ); // Increment
void LDA( byte operand  ); // Load A
void LDX( byte operand  ); // Load X
void LDY( byte operand  ); // Load Y
void LSR( byte* operand ); // Logical Shift Left
void ORA( byte operand  ); // OR, A
void ROL( byte* operand ); // Rotate on Left
void ROR( byte* operand ); // Rotate on Right
void SBC( byte operand  ); // Subtract with Carry



#endif /* CPU_H_ */
