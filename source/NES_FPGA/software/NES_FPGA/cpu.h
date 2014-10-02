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

/* Read the contents of the address in CPU memory.
   Here, we also take care of handling any mirrored locations.
 */
inline byte cpu_mem_read( word addr );

/* Write contents to address in CPU memory */
inline void cpu_mem_write( byte data, word addr );


/* Returns P/Status registers as one byte */
inline byte cpu_join_flags();

/* Retrieves flags as a byte, splits them, and returns to flag registers. */
inline void cpu_split_flags( byte operand );

/* Function:    execute_instruction
   Description: Takes in opcode and executes instruction.
                Opcode is taken in from CPU struct. */
void cpu_exec();



/* CPU Setup/Debug Functions */
inline void cpu_status();



/* Instruction functions separated by Adressing Mode and Uniqueness */
inline byte ABS();  // Absolute
inline byte ABSX(); // Absolute, X
inline byte ABSY(); // Absolute, Y
inline byte XIND(); // (Indirect, X)
inline byte INDY(); // (Indirect), Y
inline byte IMM();  // Immediate [ #$50 ]
inline byte ZP();   // Zero Page
inline byte ZPX();  // Zero Page, X

inline word ABSw();  // Absolute write
inline word ABSXw(); // Absolute X write
inline word ABSYw(); // Absolute Y write
inline word XINDw(); // [ Indirect, x ] write
inline word INDYw(); // [ Indirect ], Y write
inline word ZPXw();  // Zeropage, X write. Note: Wrap-around occurs if +X > $00FF

// Addressing Modes not implemented: (Used directly in cases)
//ACC  - Accumulator
//IMP  - Implied (No extra operands)
//IND  - Indirect (JMP)
//REL  - Relative (Comparisons)
//ZPY  - Zero Page, Y

inline void ADC( byte operand  ); // Add with Carry
inline void AND( byte operand  ); // AND
inline byte ASL( byte operand ); // Arithmetic Shift Left
inline void CMP( byte operand  ); // Compare
inline void CPX( byte operand  ); // Copy X
inline void CPY( byte operand  ); // Copy Y
inline byte DEC( byte operand ); // Decrement
inline byte INC( byte operand ); // Increment
inline void LDA( byte operand  ); // Load A
inline void LDX( byte operand  ); // Load X
inline void LDY( byte operand  ); // Load Y
inline byte LSR( byte operand ); // Logical Shift Left
inline void ORA( byte operand  ); // OR, A
inline byte ROL( byte operand ); // Rotate on Left
inline byte ROR( byte operand ); // Rotate on Right
inline void SBC( byte operand  ); // Subtract with Carry



#endif /* CPU_H_ */
