#include "cpu.h"
#include "sdcard.h"



void prg_test()
{
	cpu_status();
	int i = 0;
	int c = 0;
	for(i = 0; i < 0x8000; ++i)
	{
	printf("%x ", CPU->MEM[PRG + i ]);
	if(c >= 50)
	{
		printf("\n");
		c = 0;
	}
	else
		++c;
	}
	printf("\n\n");

	return;
}

/*
   Function: decode_instruction( byte )
   Description: Reads in byte to decode into corresponding
	  	instruction with addressing mode.
*/
void cpu_exec()
{
  // Declare variables
  word temp;
  word temp2;
  word temp_addr;
  byte operand;

  // Execute OPCODE. Note: BCD-related actions are ignored.
  switch(CPU->IR)
  {
    // ###################### ADC #########################
  case 0x6D: // ABS
      operand = ABS(); ADC(operand); CPU->T = 2; break;
  case 0x7D: // ABSX
      operand = ABSX(); ADC( operand ); CPU->T = 4; break;
  case 0x79: // ABSY
      operand = ABSY(); ADC(operand); CPU->T = 4; break;
  case 0x69: // IMM
    operand = IMM(); ADC(operand); CPU->T = 2; break;
  case 0x71: // INDY
    operand = INDY(); ADC(operand);  CPU->T = 5; break;
  case 0x61: // XIND
    operand = XIND(); ADC(operand); CPU->T = 6; break;
  case 0x65: // ZP
    operand = ZP(); ADC(operand); CPU->T = 3; break;
  case 0x75: // ZPX
    operand = ZPX(); ADC(operand); CPU->T = 4; break;

    // ###################### AND #########################
  case 0x2D: // ABS
    operand = ABS(); AND(operand); CPU->T = 4; break;
  case 0x3D: // ABSX
    operand = ABSX(); AND(operand); CPU->T = 4; break;
  case 0x39: // ABSY
    operand = ABSY(); AND(operand); CPU->T = 4; break;
  case 0x29: // IMM
    operand = IMM(); AND(operand); CPU->T = 2; break;
  case 0x31: // INDY
    operand = INDY(); AND(operand); CPU->T = 5; break;
  case 0x21: // XIND
    operand = XIND(); AND(operand); CPU->T = 6; break;
  case 0x25: // ZP
    operand = ZP(); AND(operand); CPU->T = 2; break;
  case 0x35: // ZPX
    operand = ZPX(); AND(operand); CPU->T = 3; break;

    // ###################### ASL #########################
  case 0x0E: // ABS
	temp = (cpu_read());
	temp2 = (cpu_read()) << 8;
    ASL( &CPU->MEM[( temp | temp2 )]); CPU->T = 6; break;

  case 0x1E: // ABSX
	temp = (cpu_read());
	temp2 = (cpu_read()) << 8;
    ASL( &CPU->MEM[( ( temp | temp2 ) + CPU->X)]); CPU->T = 7; break;
  case 0x0A: // ACC
    ASL( &CPU->A ); CPU->T = 2; break;
  case 0x06: // ZP
    ASL( &CPU->MEM[ CPU->MEM[ CPU->PC++] ] ); CPU->T = 5; break;
  case 0x16: // ZPX
    ASL( &CPU->MEM[ (CPU->MEM[ CPU->PC++] + CPU->X) & 0xFF] ); CPU->T = 6; break;
    break;

    // ########################## BCC #####################
  case 0x90: // REL
    if(CPU->P.C == 0)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
     printf("BCC!\n");
    break;

    // ####################### BCS ########################
  case 0xB0: // REL
    if(CPU->P.C == 1)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1; // Added 1 because PC increments
      CPU->T = 3;
    }
     else
     {
      ++CPU->PC;
      CPU->T = 2;
     }
    printf("BCS!\n");
    break;

    // ######################## BEQ #######################
  case 0xF0: // REL
    if(CPU->P.Z == 1)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
    	++CPU->PC;
    	CPU->T = 2;
    }
    printf("BEQ!\n");
    break;

    // ########################## BMI #####################
  case 0x30: // REL
    if(CPU->P.N == 1)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    printf("BMI!\n");
    break;

    // ######################## BNE #######################
  case 0xD0: // REL
    if(CPU->P.Z == 0)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    printf("BNE!\n");
    break;

    // ####################### BPL ########################
  case 0x10: // REL
    if(CPU->P.N == 0)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC]+1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    printf("BPL!\n");
    break;

    // ######################### BRK ######################
  case 0x00: // IMP
    /* Simulate Interrupt ReQuest (IRQ)
       Note: Do we increment PC at first? */
    ++CPU->PC; // Shouldn't matter since we're replacing PC with Interrupt Vector anyways
    CPU->MEM[ STACK + CPU->S ] = CPU->PC & 0xFF;
    --CPU->S;
    CPU->MEM[ STACK + CPU->S ] = (CPU->PC >> 8) & 0xFF;
    --CPU->S;
    CPU->MEM[ STACK + CPU->S ] = ((CPU->P.N << 7) & 0x80) | ((CPU->P.V << 6) & 0x40) |
      ((0x01 << 5)) | ((0x01 << 4) & 0x10) | ((CPU->P.D << 3) & 0x08) |
      ((CPU->P.I << 2) & 0x04) | ((CPU->P.Z << 1) & 0x02) | ((CPU->P.C) & 0x01);
    --CPU->S;
    CPU->PC = (CPU->MEM[0xFFFE]) | (CPU->MEM[0xFFFF] << 8);
    printf("Breaking into reset vector: %x ", CPU->PC);
    printf("BRK!\n");
    CPU->T = 7;
    break;

    // ######################## BVC #######################
  case 0x50: // REL
    if(CPU->P.V == 0)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    printf("BCV!\n");
    break;

    // ######################## BVS #######################
  case 0x70: // REL
    if(CPU->P.V == 1)
    {
      CPU->PC += CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    printf("BVS!\n");
    break;

    // ######################### CLC ######################
  case 0x18: // IMP
    CPU->P.C = 0;
    //++CPU->PC;
    printf("CLC!\n");
    CPU->T = 2;
    break;

    // ######################### CLD ######################
  case 0xD8: // IMP
    CPU->P.D = 0;
    //++CPU->PC;
    printf("CLD!\n");
    CPU->T = 2;
    break;

    // ####################### CLI ########################
  case 0x58: // IMP
    CPU->P.I = 0;
    //++CPU->PC;
    printf("CLI!\n");
    CPU->T = 2;
    break;

    // ######################### CLV ######################
  case 0xB8: // IMP
    CPU->P.V = 0;
    //++CPU->PC;
    printf("CLV!\n");
    CPU->T = 2;
    break;

    // ######################### BIT ######################
  case 0x24: // ZP
    //printf("BIT on %x and %x ", CPU->A, CPU->MEM[ CPU->MEM[ CPU->PC  ] ] );


    temp = CPU->A & CPU->MEM[ CPU->MEM[CPU->PC++] ];
    CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
    CPU->P.V = ((temp & 0x40) > 0) ? 1 : 0;
    CPU->P.Z = (temp == 0) ? 1 : 0;
    printf("BIT!\n");
    CPU->T = 3;
    break;
  case 0x2C: // ABS
	temp2 = CPU->MEM[ CPU->PC ++ ];
    temp = CPU->A & (CPU->MEM[ temp2 | (CPU->MEM[CPU->PC++] << 8) ]);
    CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
    CPU->P.V = ((temp & 0x40) > 0) ? 1 : 0;
    CPU->P.Z = (temp == 0) ? 1 : 0;
    printf("BIT!\n");
    CPU->T = 4;
    break;

    // ######################### CMP ######################
  case 0xCD: // ABS
    operand = ABS(); CMP(operand); CPU->T = 4; break;
  case 0xDD: // ABSX
    operand = ABSX(); CMP(operand); CPU->T = 4; break;
  case 0xD9: // ABSY
    operand = ABSY(); CMP(operand); CPU->T = 4; break;
  case 0xC9: // IMM
    operand = IMM(); CMP(operand); CPU->T = 2; break;
  case 0xD1: // INDY
    operand = INDY(); CMP(operand); CPU->T = 5; break;
  case 0xC1: // XIND
    operand = XIND(); CMP(operand); CPU->T = 6; break;
  case 0xC5: // ZP
    operand = ZP(); CMP(operand); CPU->T = 3; break;
  case 0xD5: // ZPX
    operand = ZPX(); CMP(operand); CPU->T = 4; break;

    // ####################### CPX ########################
  case 0xEC: // ABS
    operand = ABS(); CPX(operand); CPU->T = 4; break;
  case 0xE0: // IMM
    operand = IMM(); CPX(operand); CPU->T = 2; break;
  case 0xE4: // ZP
    operand = ZP(); CPX(operand); CPU->T = 3; break;

    // ###################### CPY #########################
  case 0xCC: // ABS
    operand = ABS(); CPY(operand); CPU->T = 4; break;
  case 0xC0: // IMM
    operand = IMM(); CPY(operand); CPU->T = 2; break;
  case 0xC4: // ZP
    operand = ZP(); CPY(operand); CPU->T = 3; break;

    // ########################### DEC ####################
  case 0xCE: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    DEC( &CPU->MEM[ temp | temp2 ] );  CPU->T = 6; break;
  case 0xDE: // ABSX
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    DEC( &CPU->MEM[ ((temp | temp2 ) + CPU->X) & 0xFFFF ]); CPU->T = 7; break;
  case 0xC6: // ZP
    DEC( &CPU->MEM[ CPU->MEM[CPU->PC++] ] ); CPU->T = 5; break;
  case 0xD6: // ZPX
    DEC( &CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF] ); CPU->T = 6; break;

    // ############################ DEX ###################
  case 0xCA: // IMP
    --CPU->X;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    printf("DEX!\n");
    CPU->T = 2;
    break;

    // ########################## DEY #####################
  case 0x88:
    --CPU->Y;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
    printf("DEY!\n");
    CPU->T = 2;
    break;

    // ######################## EOR #######################
  case 0x4D: // ABS
    CPU->A = CPU->A ^ ABS(); printf("EOR!\n"); CPU->T = 4; break;
  case 0x5D: // ABSX
    CPU->A = CPU->A ^ ABSX(); printf("EOR!\n"); CPU->T = 4; break;
  case 0x59: // ABSY
    CPU->A = CPU->A ^ ABSY(); printf("EOR!\n"); CPU->T = 4; break;
  case 0x49: // IMM
    CPU->A = CPU->A ^ IMM(); printf("EOR!\n"); CPU->T = 2; break;
  case 0x51: // INDY
    CPU->A = CPU->A ^ INDY(); printf("EOR!\n"); CPU->T = 5; break;
  case 0x41: // XIND
    CPU->A = CPU->A ^ XIND(); printf("EOR!\n"); CPU->T = 6; break;
  case 0x45: // ZP
    temp = ZP();
    CPU->A = CPU->A ^ temp; printf("EOR with %x and %x = %x, at PC: %x!\n", CPU->A, temp, CPU->A ^ temp, CPU->PC); CPU->T = 3; break;
  case 0x55: // ZPX
    CPU->A = CPU->A ^ ZPX(); printf("EOR!\n"); CPU->T = 4; break;

    // ######################## INC #######################
  case 0xEE: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    INC( &CPU->MEM[ temp | temp2 ] ); CPU->T = 6; break;
  case 0xFE: // ABSX
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    INC( &CPU->MEM[ ( ( temp | temp2 ) + CPU->X) & 0xFFFF ] ); CPU->T = 7; break;
  case 0xE6: // ZP
    INC( &CPU->MEM[ CPU->MEM[CPU->PC++] ] ); CPU->T = 5; break;
  case 0xF6: // ZPX
    INC( &CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ] ); CPU->T = 6; break;

    // ########################### INX #####################
  case 0xE8:
    ++CPU->X;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    printf("INX!\n");
    CPU->T = 2;
    break;

    // ############################### INY ###################
  case 0xC8:
    ++CPU->Y;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
    printf("INY!\n");
    CPU->T = 2;
    break;

    // ############################## JMP #####################
  case 0x4C: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    CPU->PC = temp | temp2; printf("JMP!\n"); CPU->T = 3; break;
  case 0x6C: // IND
    temp = CPU->MEM[ CPU->PC++ ];
    CPU->PC = CPU->MEM[ temp | ((temp+1) << 8) ]; printf("JMP!\n"); CPU->T = 5; break;

    // ############################## JSR #####################
  case 0x20: // ABS
    /* Jump to subroutine:
       Push PC +1 to stack and set the PC to the operand. PC + 1
       is pushed to the STACK becuase and previous two bytes are
       from the operands of JSR, and we wish to return to the next
       opcode when we Return from Subroutine (RTS)*/

    temp_addr = CPU->PC + 1;  // The address to be pushed to Stack
    CPU->MEM [ STACK + CPU->S ] = (temp_addr >> 8) & 0xFF; // Push PCh
    --CPU->S;
    CPU->MEM [ STACK + CPU->S ] = (temp_addr & 0xFF);      // Push PCl
    --CPU->S;
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    CPU->PC = temp | temp2;
    printf("JSR!\n");
    CPU->T = 6;
    break;

    // ########################## LDA #######################
  case 0xAD: // ABS
    operand = ABS(); LDA( operand ); CPU->T = 4; break;
  case 0xBD: // ABSX
    operand = ABSX(); LDA( operand ); CPU->T = 4; break;
  case 0xB9: // ABSY
    operand = ABSY(); LDA( operand ); CPU->T = 4; break;
  case 0xA9: // IMM
    LDA ( CPU->MEM[ CPU->PC++] ); CPU->T = 2; break;
  case 0xB1: // INDY
    operand = INDY(); LDA( operand ); CPU->T = 5; break;
  case 0xA1: // XIND
    operand = XIND(); LDA( operand ); CPU->T = 6; break;
  case 0xA5: // ZP
    operand = ZP(); LDA( operand ); CPU->T = 3; break;
  case 0xB5: // ZPX
    operand = ZPX(); LDA( operand ); CPU->T = 4; break;

    // ########################## LDX #######################
  case 0xAE: // ABS
    operand = ABS(); LDX( operand ); CPU->T = 4; break;
  case 0xBE: // ABSY
    operand = ABS(); LDX( operand ); CPU->T = 4; break;
  case 0xA2: // IMM
    LDX( CPU->MEM[ CPU->PC++ ] ); CPU->T = 2; break;
  case 0xA6: // ZP
    operand = ZP(); LDX( operand ); CPU->T = 3; break;
  case 0xB6: // ZPY
    operand = CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->Y) & 0xFF ]; LDX( operand ); CPU->T = 4; break;

    // ########################## LDY ######################
  case 0xAC: // ABS
    operand = ABS(); LDY( operand ); CPU->T = 4; break;
  case 0xBC: // ABSX
    operand = ABSX(); LDY( operand ); CPU->T = 4; break;
  case 0xA0: // IMM
    LDY( CPU->MEM[ CPU->PC++] ); CPU->T = 2; break;
  case 0xA4: // ZP
    operand = ZP(); LDY( operand ); CPU->T = 3; break;
  case 0xB4: // ZPX
    operand = ZPX(); LDY( operand ); CPU->T = 4; break;

    // ####################### LSR #########################
  case 0x4E: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    LSR( &CPU->MEM[  ( temp | temp2 ) ]); CPU->T = 6; break;
  case 0x5E: // ABSX
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    LSR( &CPU->MEM[  (( temp | temp2) + CPU->X ) & 0xFFFF  ] );
    CPU->T = 7;
    break;
  case 0x4A: // ACC
    LSR( &CPU->A ); CPU->T = 2; break;
  case 0x46: // ZP
    LSR( &CPU->MEM[ CPU->MEM[ CPU->PC++ ] ] ); CPU->T = 5; break;
  case 0x56: // ZPX
    LSR( &CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->X) & 0xFF ] ); CPU->T = 6; break;

    // ######################### NOP #######################
  case 0xEA:
    printf("NOP!\n");
    CPU->T = 2;
    break;

    // ########################## ORA ######################
  case 0x0D: // ABS
    operand = ABS(); ORA( operand ); CPU->T = 4; break;
  case 0x1D: // ABSX
    operand = ABSX(); ORA( operand ); CPU->T = 4; break;
  case 0x19: // ABSY
    operand = ABSY(); ORA( operand ); CPU->T = 4; break;
  case 0x09: // IMM
   ORA( CPU->MEM[ CPU->PC++ ] ); CPU->T = 2; break;
  case 0x11: // INDY
    operand = INDY(); ORA( operand ); CPU->T = 5; break;
  case 0x01: // XIND
    operand = XIND(); ORA( operand ); CPU->T = 6; break;
  case 0x05: // ZP
    operand = ZP(); ORA( operand ); CPU->T = 2; break;
  case 0x15: // ZPX
    operand = ZPX(); ORA( operand ); CPU->T = 3; break;

    // ######################### PHA #######################
  case 0x48: // IMP
    CPU->MEM[ STACK + CPU->S ] = CPU->A;
    --CPU->S;
    CPU->T = 3;
    printf("PHA!\n");
    break;

    // ########################### PHP #####################
  case 0x08: // IMP
    /* Pushes P (Status Register) onto the Stack, thus decremented it after. Fixed wrong push bug. */
    CPU->MEM[ STACK + CPU->S ] = ((CPU->P.N << 7) & 0x80) | ((CPU->P.V << 6) & 0x40) |
      ((0x01 << 5)) | ((0x01 << 4) & 0x10) | ((CPU->P.D << 3) & 0x08) |
      ((CPU->P.I << 2) & 0x04) | ((CPU->P.Z << 1) & 0x02) | ((CPU->P.C) & 0x01);
    --CPU->S;
    CPU->T = 3;
    printf("PHP!\n");
    break;

    // ########################## PLA ######################
  case 0x68: // IMP
    /* Pulls Accumulator from the stack, which is incremented after. Fixed wrong pulling bug. */
    ++CPU->S;
    CPU->A = CPU->MEM[ STACK + CPU->S ];
    CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    CPU->T = 4;
    printf("PLA!\n");
    break;

    // ########################## PLP ########################
  case 0x28:
    /* Pulls P (Status Register) from the Stack. Note B flag is not
       copied after, since it only exists on Stack. Fixed wrong flag pulling bug. */
    ++CPU->S;
    operand = CPU->MEM[ STACK + CPU->S ];
    CPU->P.N = (operand >> 7) & 0x01;
    CPU->P.V = (operand >> 6) & 0x01;
    //CPU->P.B = (operand >> 4) & 0x01;
    CPU->P.I = (operand >> 2) & 0x01;
    CPU->P.Z = (operand >> 1) & 0x01;
    CPU->P.C = (operand) & 0x01;
    CPU->T = 4;
    printf("PLP!\n");
    break;

    // ######################## ROL #######################
  case 0x2E: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    ROL( &CPU->MEM[ ( temp | temp2 ) ] ); CPU->T = 6; break;
  case 0x3E: // ABSX
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    ROL( &CPU->MEM[ ( ( temp | temp2 ) + CPU->X) & 0xFFFF] ); CPU->T = 7; break;
  case 0x2A: // ACC
    ROL( &CPU->A ); CPU->T = 2; break;
  case 0x26: // ZP
    ROL( &CPU->MEM[ CPU->MEM[ CPU->PC++ ] ] ); CPU->T = 5; break;
  case 0x36: // ZPX
    ROL( &CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->X) & 0xFF ] ); CPU->T = 6; break;

    // ########################## ROR ########################
  case 0x6E: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    ROR( &CPU->MEM[ ( temp | temp2 ) ] ); CPU->T = 6; break;
  case 0x7E: // ABSX
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    ROR( &CPU->MEM[ ( ( temp | temp2 ) + CPU->X) & 0xFFFF] ); CPU->T = 7; break;
  case 0x6A: // ACC
    ROR( &CPU->A ); CPU->T = 2; CPU->T = 2; break;
  case 0x66: // ZP
    ROR( &CPU->MEM[ CPU->MEM[ CPU->PC++ ] ]) ; CPU->T = 5; break;
  case 0x76: // ZPX
    ROR( &CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->X) & 0xFF ] ); CPU->T = 6; break;


    // ######################## RTI ##########################
  case 0x40:
    ++CPU->S;
    operand = CPU->MEM[ STACK + CPU->S ];
    printf("Pushing flag %x ", operand);
    CPU->P.N = (operand >> 7) & 0x01;
    CPU->P.V = (operand >> 6) & 0x01;
    CPU->P.B = (operand >> 4) & 0x01;
    CPU->P.I = (operand >> 2) & 0x01;
    CPU->P.Z = (operand >> 1) & 0x01;
    CPU->P.C = (operand) & 0x01;
    ++CPU->S;
    CPU->PC = (CPU->MEM[ STACK + CPU->S] );

    ++CPU->S;
    CPU->PC = CPU->PC | (CPU->MEM[ STACK + CPU->S ] << 8);
    printf("Pushed %x to PC! ", CPU->PC);
    printf("RTI!\n");
    CPU->T = 6;
    break;

    // ############################# RTS #######################
  case 0x60:
    ++CPU->S;
    CPU->PC = CPU->MEM[ STACK + CPU->S ];
    ++CPU->S;
    CPU->PC = (CPU->PC | ( CPU->MEM[ STACK + CPU->S ] << 8 )) + 1;
    printf("RTS!\n");
    CPU->T = 6;
    break;

    // ####################### SBC ############################
  case 0xED: // ABS
    operand = ABS(); SBC( operand ); CPU->T = 4; break;
  case 0xFD: // ABSX
    operand = ABSX(); SBC( operand ); CPU->T = 4; break;
  case 0xF9: // ABSY
    operand = ABSY(); SBC( operand ); CPU->T = 4; break;
  case 0xE9: // IMM
    SBC( CPU->MEM[ CPU->PC++ ] ); CPU->T = 2; break;
  case 0xF1: // INDY
    operand = INDY(); SBC( operand ); CPU->T = 5; break;
  case 0xE1: // XIND
    operand = XIND(); SBC( operand ); CPU->T = 6; break;
  case 0xE5: // ZP
    operand = ZP(); SBC( operand ); CPU->T = 3; break;
  case 0xF5: // ZPX
    operand = ZPX(); SBC( operand ); CPU->T = 4; break;

    // ############################ SEC ########################
  case 0x38: // IMP
    CPU->P.C = 1;
    printf("SEC!\n");
    CPU->T = 2;
    break;

    // ############################ SED ########################
  case 0xF8: // IMP
    CPU->P.D = 1;
    printf("SED!\n");
    CPU->T = 2;
    break;

    // ############################ SEI #########################
  case 0x78:
    CPU->P.I = 1;
    printf("SEI!\n");
    CPU->T = 2;
    break;

    // ############################## STA ########################
  case 0x8D: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
	CPU->MEM[ temp | temp2 ] = CPU->A;
    printf("STA! Storing %x into %x%x\n", CPU->MEM[ temp | temp2], temp2, temp); CPU->T = 4; break;
  case 0x9D: // ABSX
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
	CPU->MEM[ (( temp | temp2) + CPU->X) & 0xFFFF ] = CPU->A;
    printf("STA!\n"); CPU->T = 5; break;
  case 0x99: // ABSY
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    CPU->MEM[ (( temp | temp2 ) + CPU->Y) & 0xFFFF ] = CPU->A;
    printf("STA!\n"); CPU->T = 5; break;
  case 0x91: // INDY
    temp_addr = CPU->MEM[ (CPU->MEM[CPU->PC++]) ];
    temp_addr = temp_addr | ((temp_addr+1) << 8);
    CPU->MEM[ (temp_addr + CPU->Y) & 0xFFFF ] = CPU->A;
    printf("STA!\n"); CPU->T = 6; break;
  case 0x81: // XIND
    temp_addr = CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ];
    temp_addr = temp_addr | ((temp_addr+1) << 8);
    CPU->MEM[ temp_addr ] = CPU->A;
    printf("STA!\n"); CPU->T = 6; break;
  case 0x85: // ZP
    CPU->MEM[ (CPU->MEM[CPU->PC++]) ] = CPU->A;
    printf("STA!\n"); CPU->T = 3; break;
  case 0x95: // ZPX
    CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ] = CPU->A;
    printf("STA!\n"); CPU->T = 4; break;

    // ############################### STX ###########################
  case 0x8E: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    CPU->MEM[ ( temp | temp2 ) ] = CPU->X;
    printf("STX!\n"); CPU->T = 4; break;
  case 0x86: // ZP
    CPU->MEM[ (CPU->MEM[CPU->PC++]) ] = CPU->X;
    printf("STX!\n"); CPU->T = 3; break;
  case 0x96: // ZPY
    CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->Y) & 0xFF ] = CPU->X;
    printf("STX!\n"); CPU->T = 4; break;

    // ############################ STY ################################
  case 0x8C: // ABS
	temp = (CPU->MEM[CPU->PC++]);
	temp2 = (CPU->MEM[CPU->PC++]) << 8;
    CPU->MEM[ ( temp | temp2 ) ] = CPU->Y;
    printf("STY!\n"); CPU->T = 4; break;
  case 0x84: // ZP
    CPU->MEM[ (CPU->MEM[CPU->PC++]) ] = CPU->Y;
    printf("STY!\n"); CPU->T = 3; break;
  case 0x94: // ZPX
    CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ] = CPU->Y;
    printf("STY!\n"); CPU->T = 4; break;

    // ########################## TAX #################################
  case 0xAA: // IMP
    CPU->X = CPU->A;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    printf("TAX!\n"); CPU->T = 2; break;

    // ########################### TAY ################################
  case 0xA8: // IMP
    CPU->Y = CPU->A;
    CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    printf("TAY!\n"); CPU->T = 2; break;


    // ############################# TSX ##############################
  case 0xBA:
    CPU->X = CPU->S;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    printf("TSX!\n"); CPU->T = 2; break;

    // ########################## TXA ################################
  case 0x8A:
    CPU->A = CPU->X;
    CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    printf("TXA!\n"); CPU->T = 2; break;

    // ############################# TXS ################################
  case 0x9A:
    CPU->S = CPU->X;
    printf("TXS!\n"); CPU->T = 2; break;

    // ############################### TYA ##############################
  case 0x98:
    /* Transfer Y register to Accumulator. Fixed opcode bug. */
    CPU->A = CPU->Y;
    CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    printf("TYA!\n"); CPU->T = 2; break;


  default:
    printf("Invalid opcode!\n");
    break;
  }

  return;
}

inline void cpu_reset()
{
	// Set all registers to initial states
	CPU->S = 0xFD;
	CPU->P.N = 0x00;
	CPU->P.V = 0x00;
	CPU->P.B = 0x00;
	CPU->P.D = 0x00;
	CPU->P.I = 0x01;
	CPU->P.C = 0x00;
	CPU->P.Z = 0x00;
	CPU->PC = CPU->MEM[RESL] | (CPU->MEM[ RESH ] << 8); // RESET vector
	CPU->A = 0x00;
	CPU->X = 0x00;
	CPU->Y = 0x00;
	CPU->AB = 0x0000;
	CPU->DB = 0x00;
	CPU->IR = 0x00;
	CPU->RES = 0;
	CPU->NMI = 0;
	CPU->IRQ = 0;
	//CPU->T = 0x00;

  return;
}

inline void cpu_nmi()
{
	// Throw away next opcodes
	++CPU->PC; ++CPU->PC;
	CPU->P.B = 0;

	// Push PC onto Stack
	CPU->MEM[ STACK + CPU->S ] = CPU->PC >> 8;
	--CPU->S;
	CPU->MEM[ STACK + CPU->S ] = CPU->PC & 0xFF;
	--CPU->S;

	// Push P onto Stack
    CPU->MEM[ STACK + CPU->S ] = ((CPU->P.N << 7) & 0x80) | ((CPU->P.V << 6) & 0x40) |
      ((0x01 << 5)) | ((0x01 << 4) & 0x10) | ((CPU->P.D << 3) & 0x08) |
      ((CPU->P.I << 2) & 0x04) | ((CPU->P.Z << 1) & 0x02) | ((CPU->P.C) & 0x01);
    --CPU->S;

    // Interrupt
    CPU->P.I = 1;
    CPU->PC = CPU->MEM[ NMIL ];
    CPU->PC = CPU->PC | (CPU->MEM[ NMIH] << 8);

    // Turn off NMI after
    CPU->NMI = 0;

    printf("NMI!\n");
}

inline void cpu_irq()
{
	// Note: Similar process to NMI, except that it's up to the
	//		 game to disable IRQ themselves. Else, IRQ will continue
	//		 to be called.
	// Throw away next opcodes
	++CPU->PC; ++CPU->PC;
	CPU->P.B = 0;

	// Push PC onto Stack
	CPU->MEM[ STACK + CPU->S ] = CPU->PC >> 8;
	--CPU->S;
	CPU->MEM[ STACK + CPU->S ] = CPU->PC & 0xFF;
	--CPU->S;

	// Push P onto Stack
    CPU->MEM[ STACK + CPU->S ] = ((CPU->P.N << 7) & 0x80) | ((CPU->P.V << 6) & 0x40) |
      ((0x01 << 5)) | ((0x01 << 4) & 0x10) | ((CPU->P.D << 3) & 0x08) |
      ((CPU->P.I << 2) & 0x04) | ((CPU->P.Z << 1) & 0x02) | ((CPU->P.C) & 0x01);
    --CPU->S;

    // Interrupt
    CPU->P.I = 1;
    CPU->PC = CPU->MEM[ NMIL ];
    CPU->PC = CPU->PC | (CPU->MEM[ NMIH] << 8);

    printf("IRQ!\n");
}


inline void cpu_init()
{
  CPU = (NMOS6502*) malloc(sizeof(NMOS6502));
  CPU->MEM = (byte*) malloc(sizeof(byte)*64*1024); // Allocate memory
  CPU->RES = 1;

  // Initialize CPU Memory
  int i;
  for(i = 0; i < 0xFFFF+1; ++i)
	  CPU->MEM[i] = 0;

  return;
}

inline void cpu_status()
{
  printf("A: %x X: %x Y: %x P: %x%x1%x %x%x%x%x SP: %x PC: %x IR: %x [Next Instruction] ",
	 CPU->A, CPU->X, CPU->Y, CPU->P.N, CPU->P.V, CPU->P.B, CPU->P.D, CPU->P.I,
	 CPU->P.Z, CPU->P.C, CPU->S, CPU->PC, CPU->IR);

  printf("\n$2000: %x $2001: %x  $2002: %x $2003: %x $2004: %x  $2005: %x  $2006: %x  $2007: %x ",
  	  CPU->MEM[0x2000], CPU->MEM[0x2001], CPU->MEM[0x2002], CPU->MEM[0x2003], CPU->MEM[0x2004],
  	  CPU->MEM[0x2005], CPU->MEM[0x2006], CPU->MEM[0x2007] );
  return;
}


/* Read the contents of PC, then increment it */
inline byte cpu_read()
{
	return (CPU->MEM[CPU->PC++]);
}

/* Read the contents of the address in CPU memory */
inline byte cpu_mem_read( word addr )
{
	return (CPU->MEM[ addr ]);
}

/* Write contents to address in CPU memory */
inline void cpu_mem_write( byte data, word addr )
{
	CPU->MEM[ addr ] = data;
	return;
}

/* Addressing Mode and Instruction Functions */
byte ABS()
{
  t1 = (cpu_read());
  t2 = (cpu_read()) << 8;
  word temp_addr = t1 | t2;  // Grab lower and upper byte
  return cpu_mem_read( temp_addr );
}

byte ABSX()
{
  t1 = (cpu_read());
  t2 = (cpu_read()) << 8;
  word temp_addr = t1 | t2;  // Grab lower and upper byte
  return cpu_mem_read( (temp_addr + CPU->X) & 0xFFFF ); // Wrap occurs if base + X > 0xFFFF
}

byte ABSY()
{
  t1 = (cpu_read());
  t2 = (cpu_read()) << 8;
  word temp_addr = t1 | t2;  // Grab lower and upper byte
  return cpu_mem_read( (temp_addr + CPU->Y) & 0xFFFF );
}


byte XIND()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ] + CPU->X);  // Fetch low byte from ZP+X
  temp_addr = (temp_addr | (CPU->MEM[ (temp_addr+1) & 0xFF ] << 8)); // Fetch high byte from ZP+1+X
  return cpu_mem_read( temp_addr & 0xFFFF );
}

byte INDY()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ]);  // Fetch low byte from ZP
  temp_addr = (temp_addr | (CPU->MEM[ (temp_addr+1) & 0xFF ] << 8)); // Fetch high byte from ZP+1. Wrap occurs if offset is > $FF
  return cpu_mem_read( (temp_addr + CPU->Y) & 0xFFFF );  // Fetch contents of ($ZP)+Y
}


byte IMM()
{
  return cpu_read(); // operand = #$MEM[PC]
}

byte ZP()
{
  return cpu_mem_read( (cpu_read()) ); // operand = $(MEM[PC])
}

byte ZPX()
{
  return cpu_mem_read( ((cpu_read()) + CPU->X) & 0xFF ); // operand = $(MEM[PC])
}



void ADC(byte operand)
{
  byte temp = CPU->A + operand + CPU->P.C;
  CPU->P.V = ((CPU->A & 0x80) != (temp & 0x80)) ? 1 : 0;
  CPU->P.N = (((CPU->A & 0x80)) > 0) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  CPU->A = temp & 0xFF;
  printf("ADC!\n");
  return;
}

void AND(byte operand)
{
  //printf(" AND #%x with %x ", operand, CPU->A);
  CPU->A = CPU->A & operand;
  CPU->P.N = (((CPU->A & 0x80)) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->A == 0) ? 1 : 0;
  printf("AND!\n");
  return;
}

void ASL(byte* operand)
{
  CPU->P.C = (*operand) & 0x80;
  (*operand) = ((*operand) << 1) & 0xFE;
  CPU->P.N = (((*operand) & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  printf("ASL!\n");
  return;
}

void CMP( byte operand )
{
  byte temp = CPU->A - operand;
  CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
  CPU->P.C = (CPU->A >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  printf("CMP!\n");
  return;
}

void CPX( byte operand )
{
  byte temp = CPU->X - operand;
  CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
  CPU->P.C = (CPU->X >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  printf("CPX!\n");
  return;
}

void CPY( byte operand )
{
  byte temp = CPU->Y - operand;
  CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
  CPU->P.C = (CPU->Y >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  printf("CPY!\n");
  return;
}


void DEC( byte* operand )
{
  (*operand) = ((*operand)-1) & 0xFF;
  CPU->P.N = (*operand) & 0x80;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  printf("DEC!\n");
  return;
}


void INC( byte* operand )
{
  (*operand) = ((*operand)+1) & 0xFF;
  CPU->P.N = (((*operand) & 0x80) > 0) ? 1 :0;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  printf("INC!\n");
  return;
}

void LDA( byte operand )
{
  CPU->A = operand;
  CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->A == 0) ? 1 :0;
  printf("LDA! With %x\n", operand);
  return;
}

void LDX( byte operand )
{
  CPU->X = operand;
  CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->X == 0) ? 1 :0;
  printf("LDX!\n");
  return;
}

void LDY( byte operand )
{
  CPU->Y = operand;
  CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->Y == 0) ? 1 :0;
  printf("LDY!\n");
  return;
}

void LSR( byte* operand )
{
  CPU->P.N = 0x00;
  CPU->P.C = (*operand) & 0x01;
  (*operand) = ((*operand) >> 1) & 0x7F;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  printf("LSR!\n");
  return;
}

void ORA( byte operand )
{
  CPU->A = CPU->A | (operand);
  CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->A == 0 ) ? 1 : 0;
  printf("ORA!\n");
  return;
}


void ROL( byte* operand )
{
  byte temp = (*operand) & 0x80;
  (*operand) = ((*operand) << 1) & 0xFE;
  (*operand) = (*operand) | CPU->P.C;
  CPU->P.C = (temp > 0) ? 1 : 0;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  CPU->P.N = (((*operand) & 0x80) > 0) ? 1 : 0;
  printf("ROL!\n");
  return;
}

void ROR( byte* operand )
{
  byte temp = (*operand) & 0x01;
  (*operand) = ((*operand) >> 1) & 0x7F;
  (*operand) = (*operand) | ((CPU->P.C) ? 0x80 : 0x00);
  CPU->P.C = temp;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  CPU->P.N = (((*operand) & 0x80) > 0) ? 1 : 0;  printf("ROR!\n");
  return;
}

void SBC( byte operand )
{
  int temp = CPU->A - operand - (!CPU->P.C);
  CPU->P.V = ( temp > 127 || temp < -128 )  ? 1 : 0;
  CPU->P.C = ((byte)temp > 0 ) ? 1 : 0;
  CPU->P.N = (((byte)temp & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (temp == 0 ) ? 1 : 0;
  CPU->A = (byte)temp & 0xFF;
  printf("SBC!\n");
  return;
}

