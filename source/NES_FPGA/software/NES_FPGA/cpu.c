#include "cpu.h"
#include "sdcard.h"
#include "ppu.h"


void prg_test()
{
	cpu_status();
	int i = 0;
	int c = 0;
	for(i = 0; i < 0x8000; ++i)
	{
	//printf("%x ", CPU->MEM[PRG + i ]);
	if(c >= 50)
	{
		//printf("\n");
		c = 0;
	}
	else
		++c;
	}
	//printf("\n\n");

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
	t1 = ABSw(); cpu_mem_write( ASL( cpu_mem_read(t1) ), t1 ); CPU->T = 6; break; // Perform ASL, and update it in memory.
  case 0x1E: // ABSX
	t1 = ABSXw(); cpu_mem_write( ASL( cpu_mem_read(t1) ), t1 ); CPU->T = 7; break;
  case 0x0A: // ACC
    CPU->A = ASL( CPU->A ); CPU->T = 2; break;
  case 0x06: // ZP
	t1 = cpu_read();
    CPU->MEM[ t1 ] = ASL( CPU->MEM[ t1 ] ); CPU->T = 5; break;
  case 0x16: // ZPX
	temp = (cpu_read() + CPU->X) & 0xFF;
	CPU->MEM[ temp ] = ASL( CPU->MEM[ temp ] ); CPU->T = 6; break;
    break;

    // ########################## BCC #####################
  case 0x90: // REL
    if(CPU->P.C == 0)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
     //printf("BCC!\n");
    break;

    // ####################### BCS ########################
  case 0xB0: // REL
    if(CPU->P.C == 1)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1; // Added 1 because PC increments
      CPU->T = 3;
    }
     else
     {
      ++CPU->PC;
      CPU->T = 2;
     }
    //printf("BCS!\n");
    break;

    // ######################## BEQ #######################
  case 0xF0: // REL
    if(CPU->P.Z == 1)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
    	++CPU->PC;
    	CPU->T = 2;
    }
    //printf("BEQ!\n");
    break;

    // ########################## BMI #####################
  case 0x30: // REL
    if(CPU->P.N == 1)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    //printf("BMI!\n");
    break;

    // ######################## BNE #######################
  case 0xD0: // REL
    if(CPU->P.Z == 0)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    //printf("BNE!\n");
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
    //printf("BPL!\n");
    break;

    // ######################### BRK ######################
    // TODO: Confirm that we are storing the right value of PC onto Stack
  case 0x00: // IMP
    /* Simulate Interrupt ReQuest (IRQ)
       Note: Do we increment PC at first? */
    ++CPU->PC; // This matters because we're saving PC in Stack
    cpu_mem_write( CPU->PC & 0xFF, STACK + CPU->S );
    --CPU->S;

    cpu_mem_write( (CPU->PC >> 8) & 0xFF, STACK + CPU->S );
    --CPU->S;

    cpu_mem_write( cpu_join_flags(), STACK + CPU->S );
    --CPU->S;

    CPU->PC = (CPU->MEM[0xFFFE]) | (CPU->MEM[0xFFFF] << 8);
    //printf("Breaking into reset vector: %x ", CPU->PC);
    //printf("BRK!\n");
    CPU->T = 7;
    break;

    // ######################## BVC #######################
  case 0x50: // REL
    if(CPU->P.V == 0)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    //printf("BCV!\n");
    break;

    // ######################## BVS #######################
  case 0x70: // REL
    if(CPU->P.V == 1)
    {
      CPU->PC += (signed char)CPU->MEM[CPU->PC] + 1;
      CPU->T = 3;
    }
    else
    {
      ++CPU->PC;
      CPU->T = 2;
    }
    //printf("BVS!\n");
    break;

    // ######################### CLC ######################
  case 0x18: // IMP
    CPU->P.C = 0;
    //++CPU->PC;
    //printf("CLC!\n");
    CPU->T = 2;
    break;

    // ######################### CLD ######################
  case 0xD8: // IMP
    CPU->P.D = 0;
    //++CPU->PC;
    //printf("CLD!\n");
    CPU->T = 2;
    break;

    // ####################### CLI ########################
  case 0x58: // IMP
    CPU->P.I = 0;
    //++CPU->PC;
    //printf("CLI!\n");
    CPU->T = 2;
    break;

    // ######################### CLV ######################
  case 0xB8: // IMP
    CPU->P.V = 0;
    //++CPU->PC;
    //printf("CLV!\n");
    CPU->T = 2;
    break;

    // ######################### BIT ######################
  case 0x24: // ZP
    ////printf("BIT on %x and %x ", CPU->A, CPU->MEM[ CPU->MEM[ CPU->PC  ] ] );

    temp = CPU->A & cpu_mem_read( cpu_read() );
    CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
    CPU->P.V = ((temp & 0x40) > 0) ? 1 : 0;
    CPU->P.Z = (temp == 0) ? 1 : 0;
    //printf("BIT!\n");
    CPU->T = 3;
    break;
  case 0x2C: // ABS
	temp2 = ABS();
    temp = CPU->A & temp2;
    CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
    CPU->P.V = ((temp & 0x40) > 0) ? 1 : 0;
    CPU->P.Z = (temp == 0) ? 1 : 0;
    //printf("BIT!\n");
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
	t1 = ABSw();
    cpu_mem_write( DEC( cpu_mem_read(t1) ), t1 ); CPU->T = 6; break;
  case 0xDE: // ABSX
	t1 = ABSXw();
	cpu_mem_write( DEC( cpu_mem_read(t1) ), t1 ); CPU->T = 7; break;
  case 0xC6: // ZP
	t1 = cpu_read();
	CPU->MEM[ t1 ] = DEC( CPU->MEM[ t1 ] ); CPU->T = 5; break;
  case 0xD6: // ZPX
    temp = (cpu_read() + CPU->X) & 0xFF;
    CPU->MEM[ temp ] = DEC( CPU->MEM[ temp] ); CPU->T = 6; break;

    // ############################ DEX ###################
  case 0xCA: // IMP
    --CPU->X;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    //printf("DEX!\n");
    CPU->T = 2;
    break;

    // ########################## DEY #####################
  case 0x88:
    --CPU->Y;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
    //printf("DEY!\n");
    CPU->T = 2;
    break;

    // ######################## EOR #######################
  case 0x4D: // ABS
    CPU->A = CPU->A ^ ABS(); //printf("EOR!\n");
    CPU->T = 4;
    break;
  case 0x5D: // ABSX
    CPU->A = CPU->A ^ ABSX(); //printf("EOR!\n");
    CPU->T = 4;
    break;
  case 0x59: // ABSY
    CPU->A = CPU->A ^ ABSY(); //printf("EOR!\n");
    CPU->T = 4;
    break;
  case 0x49: // IMM
    CPU->A = CPU->A ^ IMM(); //printf("EOR!\n");
    CPU->T = 2;
    break;
  case 0x51: // INDY
    CPU->A = CPU->A ^ INDY(); //printf("EOR!\n");
    CPU->T = 5;
    break;
  case 0x41: // XIND
    CPU->A = CPU->A ^ XIND(); //printf("EOR!\n");
    CPU->T = 6;
    break;
  case 0x45: // ZP
    temp = ZP();
    CPU->A = CPU->A ^ temp; //printf("EOR with %x and %x = %x, at PC: %x!\n", CPU->A, temp, CPU->A ^ temp, CPU->PC);
    CPU->T = 3;
    break;
  case 0x55: // ZPX
    CPU->A = CPU->A ^ ZPX(); //printf("EOR!\n"); CPU->T = 4;
    break;

    // ######################## INC #######################
  case 0xEE: // ABS
	t1 = ABSw();
    cpu_mem_write( INC( cpu_mem_read(t1) ), t1 ); CPU->T = 6; break;
  case 0xFE: // ABSX
	t1 = ABSXw();
	cpu_mem_write( INC( cpu_mem_read(t1) ), t1 ); CPU->T = 7; break;
  case 0xE6: // ZP
	t1 = cpu_read();
	CPU->MEM[ t1 ] = INC( CPU->MEM[ t1 ] ); CPU->T = 5; break;
  case 0xF6: // ZPX
	t1 = (cpu_read() + CPU->X) & 0xFF;
    CPU->MEM[ t1 ] = INC( CPU->MEM[ t1 ] ); CPU->T = 6; break;

    // ########################### INX #####################
  case 0xE8:
    ++CPU->X;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    //printf("INX!\n");
    CPU->T = 2;
    break;

    // ############################### INY ###################
  case 0xC8:
    ++CPU->Y;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
    //printf("INY!\n");
    CPU->T = 2;
    break;

    // ############################## JMP #####################
  case 0x4C: // ABS
    CPU->PC = ABSw(); //printf("JMP!\n");
    CPU->T = 3;
    break;
  case 0x6C: // IND
    temp = cpu_read();	// Fetch operand byte
    l = cpu_mem_read( temp ); // Fetch lower byte address
    h = cpu_mem_read( (temp +1) & 0xFF ) << 8;
    CPU->PC = cpu_mem_read( l | h ); //printf("JMP!\n");
    CPU->T = 5;
    break;

    // ############################## JSR #####################
  case 0x20: // ABS
    /* Jump to subroutine:
       Push PC + 1 to stack and set the PC to the operand. PC + 1
       is pushed to the STACK becuase and previous two bytes are
       from the operands of JSR, and we wish to return to the next
       opcode when we Return from Subroutine (RTS)*/
	l = cpu_read();				// Fetch lower byte address
	h = (cpu_read()) << 8;		// Fetch higher byte address

    temp_addr = CPU->PC - 1;  // The address to be pushed to Stack
    cpu_mem_write( (temp_addr >> 8) & 0xFF, STACK + CPU->S); // Push PCh
    --CPU->S;
    cpu_mem_write( (temp_addr & 0xFF), STACK + CPU->S);      // Push PCl
    --CPU->S;

    CPU->PC = l | h;
    //printf("JSR!\n");
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
    operand = CPU->MEM[ ( cpu_read() + CPU->Y) & 0xFF ]; LDX( operand ); CPU->T = 4; break;

    // ########################## LDY ######################
  case 0xAC: // ABS
    operand = ABS(); LDY( operand ); CPU->T = 4; break;
  case 0xBC: // ABSX
    operand = ABSX(); LDY( operand ); CPU->T = 4; break;
  case 0xA0: // IMM
    LDY( cpu_read() ); CPU->T = 2; break;
  case 0xA4: // ZP
    operand = ZP(); LDY( operand ); CPU->T = 3; break;
  case 0xB4: // ZPX
    operand = ZPX(); LDY( operand ); CPU->T = 4; break;

    // ####################### LSR #########################
  case 0x4E: // ABS
	t1 = ABSw();
    cpu_mem_write( LSR( cpu_mem_read(t1) ), t1 ); CPU->T = 6; break;
  case 0x5E: // ABSX
	t1 = ABSXw();
	cpu_mem_write( LSR( cpu_mem_read(t1) ), t1 ); CPU->T = 7;
    break;
  case 0x4A: // ACC
    CPU->A = LSR( CPU->A ); CPU->T = 2; break;
  case 0x46: // ZP
	t1 = cpu_read();
    CPU->MEM[ t1 ] = LSR( CPU->MEM[ t1 ] ); CPU->T = 5; break;
  case 0x56: // ZPX
	t1 = (cpu_read() + CPU->X) & 0xFF;
    CPU->MEM[ t1 ] = LSR( CPU->MEM[ t1 ] ); CPU->T = 6; break;

    // ######################### NOP #######################
  case 0xEA:
    //printf("NOP!\n");
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
   ORA( cpu_read() ); CPU->T = 2; break;
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
	cpu_mem_write( CPU->A, STACK + CPU->S );
    --CPU->S;
    CPU->T = 3;
    //printf("PHA!\n");
    break;

    // ########################### PHP #####################
  case 0x08: // IMP
    /* Pushes P (Status Register) onto the Stack, thus decremented it after. Fixed wrong push bug. */
    CPU->MEM[ STACK + CPU->S ] = cpu_join_flags();
    --CPU->S;
    CPU->T = 3;
    //printf("PHP!\n");
    break;

    // ########################## PLA ######################
  case 0x68: // IMP
    /* Pulls Accumulator from the stack, which is incremented after. Fixed wrong pulling bug. */
    ++CPU->S;
    CPU->A = cpu_mem_read( STACK + CPU->S );
    CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    CPU->T = 4;
    //printf("PLA!\n");
    break;

    // ########################## PLP ########################
  case 0x28:
    /* Pulls P (Status Register) from the Stack. Note B flag is not
       copied after, since it only exists on Stack. Fixed wrong flag pulling bug. */
    ++CPU->S;
    cpu_split_flags( cpu_mem_read( STACK + CPU->S ) );
    CPU->T = 4;
    //printf("PLP!\n");
    break;

    // ######################## ROL #######################
  case 0x2E: // ABS
	t1 = ABSw();
	cpu_mem_write( ROL( cpu_mem_read(t1) ), t1); CPU->T = 6; break;
  case 0x3E: // ABSX
	t1 = ABSXw();
	cpu_mem_write( ROL( cpu_mem_read(t1) ), t1);  CPU->T = 7; break;
  case 0x2A: // ACC
    CPU->A = ROL( CPU->A ); CPU->T = 2; break;
  case 0x26: // ZP
	t1 = cpu_read();
	CPU->MEM[ t1 ] = ROL( CPU->MEM[ t1 ] ); CPU->T = 5; break;
  case 0x36: // ZPX
	t1 = (cpu_read() + CPU->X) & 0xFF;
	CPU->MEM[ t1 ] = ROL( CPU->MEM[ t1 ] ); CPU->T = 6; break;

    // ########################## ROR ########################
  case 0x6E: // ABS
	t1 = ABSw();
	cpu_mem_write( ROR( cpu_mem_read(t1) ), t1 ); CPU->T = 6; break;
  case 0x7E: // ABSX
   t1 = ABSXw();
   cpu_mem_write( ROR( cpu_mem_read(t1) ), t1 ); CPU->T = 7; break;
  case 0x6A: // ACC
    CPU->A = ROR( CPU->A ); CPU->T = 2; CPU->T = 2; break;
  case 0x66: // ZP
	t1 = cpu_read();
	CPU->MEM[ t1 ] = ROR( CPU->MEM[ t1 ]); CPU->T = 5; break;
  case 0x76: // ZPX
	t1 = (CPU->PC + CPU->X) & 0xFF;
    CPU->MEM[ t1 ] = ROR( CPU->MEM[ t1 ] ); ++CPU->PC; CPU->T = 6; break;


    // ######################## RTI ##########################
  case 0x40:
    ++CPU->S;
    cpu_split_flags( cpu_mem_read( STACK + CPU->S ) );

    ++CPU->S;
    CPU->PC = cpu_mem_read( STACK + CPU->S );

    ++CPU->S;
    CPU->PC = CPU->PC | (cpu_mem_read( STACK + CPU->S ) << 8);
    //printf("Pushed %x to PC! ", CPU->PC);
    //printf("RTI!\n");
    CPU->T = 6;
    break;

    // ############################# RTS #######################
  case 0x60:
    ++CPU->S;
    CPU->PC = cpu_mem_read( STACK + CPU->S );

    ++CPU->S;
    CPU->PC = (CPU->PC | ( cpu_mem_read( STACK + CPU->S ) << 8 )) + 1;
    //printf("RTS!\n");
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
    //printf("SEC!\n");
    CPU->T = 2;
    break;

    // ############################ SED ########################
  case 0xF8: // IMP
    CPU->P.D = 1;
    //printf("SED!\n");
    CPU->T = 2;
    break;

    // ############################ SEI #########################
  case 0x78:
    CPU->P.I = 1;
    //printf("SEI!\n");
    CPU->T = 2;
    break;

    // ############################## STA ########################
  case 0x8D: // ABS
	cpu_mem_write( CPU->A, ABSw() );
    //printf("STA!");
	CPU->T = 4;
	break;
  case 0x9D: // ABSX
	cpu_mem_write( CPU->A, ABSXw());
    //printf("STA!\n");
	CPU->T = 5;
	break;
  case 0x99: // ABSY
	cpu_mem_write( CPU->A, ABSYw() );
    //printf("STA!\n");
	CPU->T = 5;
	break;
  case 0x91: // INDY
    cpu_mem_write( CPU->A,  INDYw() );
    //printf("STA!\n");
    CPU->T = 6;
    break;
  case 0x81: // XIND
	cpu_mem_write( CPU->A, XINDw() );
    //printf("STA!\n");
    CPU->T = 6;
    break;
  case 0x85: // ZP
    CPU->MEM[ cpu_read() ] = CPU->A;
    //printf("STA!\n");
    CPU->T = 3;
    break;
  case 0x95: // ZPX
    CPU->MEM[ ( cpu_read() + CPU->X) & 0xFF ] = CPU->A;
    //printf("STA!\n");
    CPU->T = 4;
    break;

    // ############################### STX ###########################
  case 0x8E: // ABS
    cpu_mem_write( CPU->X, ABSw() );
    //printf("STX!\n");
    CPU->T = 4;
    break;
  case 0x86: // ZP
    CPU->MEM[ cpu_read() ] = CPU->X;
    //printf("STX!\n");
    CPU->T = 3;
    break;
  case 0x96: // ZPY
    CPU->MEM[ (cpu_read() + CPU->Y) & 0xFF ] = CPU->X;
    //printf("STX!\n");
    CPU->T = 4;
    break;

    // ############################ STY ################################
  case 0x8C: // ABS
	cpu_mem_write( CPU->Y, ABSw() );
    //printf("STY!\n");
	CPU->T = 4;
	break;
  case 0x84: // ZP
    CPU->MEM[ cpu_read() ] = CPU->Y;
    //printf("STY!\n");
    CPU->T = 3;
    break;
  case 0x94: // ZPX
    CPU->MEM[ (cpu_read() + CPU->X) & 0xFF ] = CPU->Y;
    //printf("STY!\n");
    CPU->T = 4;
    break;

    // ########################## TAX #################################
  case 0xAA: // IMP
    CPU->X = CPU->A;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    //printf("TAX!\n");
    CPU->T = 2;
    break;

    // ########################### TAY ################################
  case 0xA8: // IMP
    CPU->Y = CPU->A;
    CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    //printf("TAY!\n");
    CPU->T = 2;
    break;


    // ############################# TSX ##############################
  case 0xBA:
    CPU->X = CPU->S;
    CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    //printf("TSX!\n");
    CPU->T = 2;
    break;

    // ########################## TXA ################################
  case 0x8A:
    CPU->A = CPU->X;
    CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    //printf("TXA!\n");
    CPU->T = 2;
    break;

    // ############################# TXS ################################
  case 0x9A:
    CPU->S = CPU->X;
    //printf("TXS!\n");
    CPU->T = 2;
    break;

    // ############################### TYA ##############################
  case 0x98:
    /* Transfer Y register to Accumulator. Fixed opcode bug. */
    CPU->A = CPU->Y;
    CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    //printf("TYA!\n");
    CPU->T = 2;
    break;


  default:
    printf("Invalid opcode!\n");
    cpu_status();
    ppu_status();
    printf("Disassembly: \n");
    int i = 0;
    for( i = 0; i < 30; ++i)
    {
    	printf("%x ", CPU->MEM[CPU->PC+i-5]);
    }
    break;
  }

  return;
}

// CPU Reset interrupt handler
inline void cpu_reset()
{
	// Set all registers to initial states
	CPU->S = 0xFD;
	CPU->P.N = 0x00;
	CPU->P.V = 0x00;
	CPU->P.B = 0x00;
	CPU->P.D = 0x00;
	CPU->P.I = 0x01; // Interrupt Disable is on
	CPU->P.C = 0x00;
	CPU->P.Z = 0x00;
	CPU->A = 0x00;
	CPU->X = 0x00;
	CPU->Y = 0x00;
	CPU->AB = 0x0000;
	CPU->DB = 0x00;
	CPU->IR = 0x00;
	CPU->RES = 0;
	CPU->NMI = 0;
	CPU->IRQ = 0;
	CPU->T = 0;
	CPU->instructions = 0;

	// Finally, push RESET vector to PC to start Reset handler (AKA when you 'turn on' the NES)
	CPU->PC = CPU->MEM[RESL] | (CPU->MEM[ RESH ] << 8);
	return;
}

// CPU Non-maskable Interrupt handler
inline void cpu_nmi()
{
	// Throw away next opcodes
	++CPU->PC; ++CPU->PC;
	CPU->P.B = 0;

	// Push PC onto Stack
	cpu_mem_write( CPU->PC >> 8, STACK + CPU->S );
	--CPU->S;
	cpu_mem_write( CPU->PC & 0xFF, STACK + CPU->S );
	--CPU->S;

	// Push P onto Stack
    CPU->MEM[ STACK + CPU->S ] = cpu_join_flags();
    --CPU->S;

    // Interrupt
    CPU->P.I = 1;
    CPU->PC = CPU->MEM[ NMIL ];
    CPU->PC = CPU->PC | (CPU->MEM[ NMIH] << 8);

    // Turn off NMI after, as the system is supposed to automatically flip NMI off.
    CPU->NMI = 0;

    printf("NMI!\n");
}

// CPU Interrupt Request handler
inline void cpu_irq()
{
	// Note: Similar process to NMI, except that it's up to the
	//		 game to disable IRQ themselves. Else, IRQ will continue
	//		 to be called.
	// Throw away next opcodes
	++CPU->PC; ++CPU->PC;
	CPU->P.B = 0;

	// Push PC onto Stack
	cpu_mem_write( CPU->PC >> 8, STACK + CPU->S );
	--CPU->S;
	cpu_mem_write( CPU->PC & 0xFF, STACK + CPU->S );
	--CPU->S;

	// Push P onto Stack
    CPU->MEM[ STACK + CPU->S ] = cpu_join_flags();
    --CPU->S;

    // Interrupt
    CPU->P.I = 1;
    CPU->PC = CPU->MEM[ IRQL ];
    CPU->PC = CPU->PC | (CPU->MEM[ IRQH] << 8);

    printf("IRQ!\n");
}


// Initializes all registers and memory.
inline void cpu_init()
{
  CPU = (RP2A03*) malloc(sizeof(RP2A03));
  CPU->MEM = (byte*) malloc(sizeof(byte)*64*1024); // Allocate memory
  CPU->RES = 1;

  // Initialize CPU Memory
  int i;
  for(i = 0; i < 0xFFFF+1; ++i)
	  CPU->MEM[i] = 0;

  return;
}

// Prints out the following: (left-right)
// 	   Accumulator, X, Y, Processor Flags, Stack Pointer, T/Cycle Count, Instruction Register,
//	   and PPU Registers. Note IR is for the instruction to be execute for the next CPU tick.
inline void cpu_status()
{
  printf("A: %x X: %x Y: %x P: %x%x1%x %x%x%x%x SP: %x PC: %x T: %x IR: %x ",
	 CPU->A, CPU->X, CPU->Y, CPU->P.N, CPU->P.V, CPU->P.B, CPU->P.D, CPU->P.I,
	 CPU->P.Z, CPU->P.C, CPU->S, CPU->PC, CPU->T, CPU->IR);

  printf("\n$2000: %x $2001: %x  $2002: %x $2003: %x $2004: %x  $2005: %x  $2006: %x  $2007: %x PPUADDR: %x INS: %d",
  	  CPU->MEM[0x2000], CPU->MEM[0x2001], CPU->MEM[0x2002], CPU->MEM[0x2003], CPU->MEM[0x2004],
  	  CPU->MEM[0x2005], CPU->MEM[0x2006], CPU->MEM[0x2007], PPU->ppuaddr, CPU->instructions );
  return;
}


// Read the contents of PC, then increment it */
inline byte cpu_read()
{
	return (CPU->MEM[CPU->PC++]);
}

// Read the contents of the address in CPU memory */
inline byte cpu_mem_read( word addr )
{
	//printf(" $%x => ", addr);

	// Addresses within $0800 - $1FFF are RAM mirrors
	if( (addr > 0x07FF) && ( addr < 0x2000))
	{
		t1 = (CPU->MEM[ (addr & 0x07FF) ]);
		//printf( "%x ", t1);
		return t1;
	}
	// Addresses within $2008 - $4000 are PPU Register mirrors
	else if( (addr > 0x2007) && ( addr < 0x4000) )
	{
		t1 = (CPU->MEM[ PPUREG + (addr & 0x07) ] );
		//printf("%x ", t1);
		return t1;
	}

	// Regular, non-mirrored memory read
	else
	{
		t1 = (CPU->MEM[ addr ]);
		//printf("%x ", t1);
		return t1;
	}
}

// Write contents to address in CPU memory */
inline void cpu_mem_write( byte data, word addr )
{
	//printf(" $%x <= %x ", addr, data);

	// Addresses within $0800 - $1FFF are RAM mirrors
	if( (addr > 0x07FF) && ( addr < 0x2000) )
	{
		CPU->MEM[ (addr & 0x07FF) ] = data;
	}
	// Addresses within $2008 - $4000 are PPU Register mirrors
	else if( (addr > 0x2007) && ( addr < 0x4000) )
	{
		t1 = (PPUREG + (addr & 0x07));
		if( t1 > 0x2003 )
			write_ppu_reg( data, t1);
		else
			CPU->MEM[ t1 ] = data;
	}
	// Regular, non-mirrored memory write
	else
	{
		if( addr > 0x2003 && addr < 0x2008 )
			write_ppu_reg( data, addr );
		else
			CPU->MEM[ addr ] = data;

	}
	return;
}

// Returns P/Status registers as one byte
inline byte cpu_join_flags()
{
	return (((CPU->P.N << 7) & 0x80) | ((CPU->P.V << 6) & 0x40) |
			((0x01 << 5)) | ((0x01 << 4) & 0x10) | ((CPU->P.D << 3) & 0x08) |
			((CPU->P.I << 2) & 0x04) | ((CPU->P.Z << 1) & 0x02) | ((CPU->P.C) & 0x01));
}


// Retrieves flags as a byte, splits them, and returns to flag registers.
inline void cpu_split_flags( byte operand )
{
    CPU->P.N = (operand >> 7) & 0x01;
    CPU->P.V = (operand >> 6) & 0x01;
    // Note: 5th bit doesn't exist.
    //CPU->P.B = (operand >> 4) & 0x01;
    //CPU->P.D = (operand >> 3) & 0x01;
    CPU->P.I = (operand >> 2) & 0x01;
    CPU->P.Z = (operand >> 1) & 0x01;
    CPU->P.C = (operand) & 0x01;

    return;
}

// ======================= Addressing Modes (reading) ===================================
inline byte ABS()	// Absolute read
{
  t1 = (cpu_read());
  t2 = (cpu_read()) << 8;
  word temp_addr = t1 | t2;  // Grab lower and upper byte
  return cpu_mem_read( temp_addr );
}

inline byte ABSX() // Absolute X read
{
  t1 = (cpu_read());
  t2 = (cpu_read()) << 8;
  word temp_addr = t1 | t2;  // Grab lower and upper byte
  return cpu_mem_read( (temp_addr + CPU->X) & 0xFFFF ); // Wrap occurs if base + X > 0xFFFF
}

inline byte ABSY() // Absolute Y read
{
  l = (cpu_read());
  h = (cpu_read()) << 8;
  t1 = l | h;  // Grab lower and upper byte
  return cpu_mem_read( ( t1 + CPU->Y) & 0xFFFF );
}

inline byte XIND() // [ Indirect, x ] read
{
  t1 = cpu_read();			// Fetch operand byte
  l = cpu_mem_read( (t1 + CPU->X) & 0xFF );				// Fetch lower byte of address
  h = cpu_mem_read( (t1 + 1 + CPU->X) & 0xFF ) << 8; 	// Fetch higher byte of address

  return cpu_mem_read( l | h );							// Get contents of address
}

inline byte INDY() // [ Indirect ], Y read
{
  t1 = cpu_read(); 		  					 // Fetch operand byte
  l = cpu_mem_read( t1 ); 					 // Fetch lower byte of address
  h = cpu_mem_read( (t1 + 1) && 0xFF ) << 8; // Fetch higher byte of address
  t2 = ((l | h) + CPU->Y) & 0xFFFF;			 // Calculate address with Y register, taking into account adress wrapping.

  return cpu_mem_read( t2 );  				 // Get contents of address
}

inline byte IMM()	// Immediate
{
  return cpu_read(); // operand = #$MEM[PC]
}

inline byte ZP()	// Zeropage read. Note: Only 1 byte required, since ZP is $0000 - $00FF
{
  return cpu_mem_read( (cpu_read()) ); // operand = $(MEM[PC])
}

inline byte ZPX() // Zeropage, X read. Note: Wrap-around occurs if +X > $00FF
{
  return cpu_mem_read( ((cpu_read()) + CPU->X) & 0xFF ); // operand = $(MEM[PC])
}

// ======================= Addressing Modes (writing) ===================================
inline word ABSw() // Absolute write
{
  l = cpu_read();
  h = cpu_read() << 8;
  return l | h;
}

inline word ABSXw() // Absolute X write
{
  t1 = (cpu_read());
  t2 = (cpu_read()) << 8;
  word temp_addr = t1 | t2;  // Grab lower and upper byte
  return (temp_addr + CPU->X) & 0xFFFF; // Wrap occurs if base + X > 0xFFFF
}

inline word ABSYw() // Absolute Y write
{
  l = (cpu_read());
  h = (cpu_read()) << 8;
  t1 = l | h;  // Grab lower and upper byte

  return ( t1 + CPU->Y) & 0xFFFF;
}

inline word XINDw() // [ Indirect, x ] write
{
  t1 = cpu_read();			// Fetch operand byte
  l = cpu_mem_read( (t1 + CPU->X) & 0xFF );				// Fetch lower byte of address
  h = cpu_mem_read( (t1 + 1 + CPU->X) & 0xFF ) << 8; 	// Fetch higher byte of address

  return l | h ;
}

inline word INDYw() // [ Indirect ], Y write
{
  t1 = cpu_read(); 		  					 // Fetch operand byte
  l = cpu_mem_read( t1 ); 					 // Fetch lower byte of address
  h = cpu_mem_read( (t1 + 1) && 0xFF ) << 8; // Fetch higher byte of address
  t2 = ((l | h) + CPU->Y) & 0xFFFF;			 // Calculate address with Y register, taking into account adress wrapping.

  return t2;
}

inline word ZPXw() // Zeropage, X write. Note: Wrap-around occurs if +X > $00FF
{
  return ( cpu_read() + CPU->X) & 0xFF;
}

// ======================= Instructions ===================================
inline void ADC(byte operand) // Add w/ Carry
{
  byte temp = CPU->A + operand + CPU->P.C;
  CPU->P.V = ((CPU->A & 0x80) != (temp & 0x80)) ? 1 : 0;
  CPU->P.N = (((CPU->A & 0x80)) > 0) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  CPU->A = temp & 0xFF;
  //printf("ADC!\n");
  return;
}

inline void AND(byte operand) // AND
{
  ////printf(" AND #%x with %x ", operand, CPU->A);
  CPU->A = CPU->A & operand;
  CPU->P.N = (((CPU->A & 0x80)) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->A == 0) ? 1 : 0;
  //printf("AND!\n");
  return;
}

inline byte ASL(byte operand) // Arithmetic Shift Left
{
  CPU->P.C = (operand) & 0x80;
  (operand) = ((operand) << 1) & 0xFE;
  CPU->P.N = (((operand) & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = ((operand) == 0) ? 1 : 0;
  //printf("ASL!\n");
  return operand;
}

inline void CMP( byte operand ) // Compare bits with A
{
  byte temp = CPU->A - operand;
  CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
  CPU->P.C = (CPU->A >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  //printf("CMP!\n");
  return;
}

inline void CPX( byte operand ) // Compare X
{
  byte temp = CPU->X - operand;
  CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
  CPU->P.C = (CPU->X >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  //printf("CPX!\n");
  return;
}

inline void CPY( byte operand ) // Compare Y
{
  byte temp = CPU->Y - operand;
  CPU->P.N = ((temp & 0x80) > 0) ? 1 : 0;
  CPU->P.C = (CPU->Y >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  //printf("CPY!\n");
  return;
}


inline byte DEC( byte operand ) // Decrement
{
  (operand) = ((operand)-1) & 0xFF;
  CPU->P.N = (operand) & 0x80;
  CPU->P.Z = ((operand) == 0) ? 1 : 0;
  //printf("DEC!\n");
  return operand;
}


inline byte INC( byte operand ) // Increment
{
  (operand) = ((operand)+1) & 0xFF;
  CPU->P.N = (((operand) & 0x80) > 0) ? 1 :0;
  CPU->P.Z = ((operand) == 0) ? 1 : 0;
  //printf("INC!\n");
  return operand;
}

inline void LDA( byte operand ) // Load into A
{
  CPU->A = operand;
  CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->A == 0) ? 1 :0;
  //printf("LDA! With %x\n", operand);
  return;
}

inline void LDX( byte operand ) // Load into X
{
  CPU->X = operand;
  CPU->P.N = ((CPU->X & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->X == 0) ? 1 :0;
  //printf("LDX!\n");
  return;
}

inline void LDY( byte operand ) // Load into Y
{
  CPU->Y = operand;
  CPU->P.N = ((CPU->Y & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->Y == 0) ? 1 :0;
  //printf("LDY!\n");
  return;
}

inline byte LSR( byte operand ) // Logical Shift Right
{
  CPU->P.N = 0x00;
  CPU->P.C = (operand) & 0x01;
  (operand) = ((operand) >> 1) & 0x7F;
  CPU->P.Z = ((operand) == 0) ? 1 : 0;
  //printf("LSR!\n");
  return operand;
}

inline void ORA( byte operand ) // OR with A
{
  CPU->A = CPU->A | (operand);
  CPU->P.N = ((CPU->A & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (CPU->A == 0 ) ? 1 : 0;
  //printf("ORA!\n");
  return;
}


inline byte ROL( byte operand ) // Rotate on Left
{
  byte temp = (operand) & 0x80;
  (operand) = ((operand) << 1) & 0xFE;
  (operand) = (operand) | CPU->P.C;
  CPU->P.C = (temp > 0) ? 1 : 0;
  CPU->P.Z = ((operand) == 0) ? 1 : 0;
  CPU->P.N = (((operand) & 0x80) > 0) ? 1 : 0;
  //printf("ROL!\n");
  return operand;
}

inline byte ROR( byte operand ) // Rotate on Right
{
  byte temp = (operand) & 0x01;
  (operand) = ((operand) >> 1) & 0x7F;
  (operand) = (operand) | ((CPU->P.C) ? 0x80 : 0x00);
  CPU->P.C = temp;
  CPU->P.Z = ((operand) == 0) ? 1 : 0;
  CPU->P.N = (((operand) & 0x80) > 0) ? 1 : 0;  //printf("ROR!\n");
  return operand;
}

inline void SBC( byte operand ) // Subtract with Carry
{
  int temp = CPU->A - operand - (!CPU->P.C);
  CPU->P.V = ( temp > 127 || temp < -128 )  ? 1 : 0;
  CPU->P.C = ((byte)temp > 0 ) ? 1 : 0;
  CPU->P.N = (((byte)temp & 0x80) > 0) ? 1 : 0;
  CPU->P.Z = (temp == 0 ) ? 1 : 0;
  CPU->A = (byte)temp & 0xFF;
  //printf("SBC!\n");
  return;
}

