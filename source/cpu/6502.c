#include "6502.h"

#define DEBUG        // Enables methods for debugging functions

// Declare CPU struct, which contains all required registers
NMOS6502* CPU;

int main()
{
  // Declare appropriate arrays and variables
  char* file_name = "../../roms/nestest.nes";
  byte* PRG_ROM = NULL;	// Supports 1 PRG Bank currently
  byte* CHR_ROM = NULL; // Supports 1 CHR Bank currently
  byte prg_size = 0, chr_size = 0;

  // Load NES rom from file
  load_rom(file_name, &PRG_ROM, &CHR_ROM, &prg_size, &chr_size);
	

  // Set up CPU struct
  cpu_init();
  
  // Set up CPU Memory Map
  mmap_init(&PRG_ROM);

  /*// Display contents of PRG_ROM
  #ifdef DEBUG
  cpu_status();
  int i = 0;
  int c = 0;
  for(i = 0; i < 0x4000; ++i)
  {
    printf("%x ", CPU->MEM[i+PRG+0x4000]);
    if(c >= 50)
    {
      printf("\n");
      c = 0;
    }
    else
      ++c;
  }
  #endif*/
  
  // Initially, set PC to contents of RESET vector
  CPU->PC = CPU->MEM[ RESL ] | (CPU->MEM[ RESH ] << 8);
  CPU->IR = CPU->MEM[ CPU->PC ];
  cpu_status(); // Debug CPU

  char* en = (char*) malloc(sizeof(char)*2);
  // Execute CPU instructions
  while(1)
  {
    // Check for interrupts
    // n/a

    // Load next instruction
    CPU->IR = CPU->MEM[ CPU->PC++ ];

    // Execute instruction
    cpu_exec();
    cpu_status(); // Debug CPU

    // Wait until enter is pressed to step-through
    fgets(en, 2, stdin);
  }


  // Free up allocated memory in heap
  free( PRG_ROM );
  free( CHR_ROM );
  free( CPU );
  return 0;
}



/* 
   Function: decode_instruction( byte )
   Description: Reads in byte to decode into corresponding 
	  	instruction with addressing mode.
*/
void cpu_exec()
{
  // Declare variables
  byte temp;
  word temp_addr;
  byte operand;

  // Execute OPCODE. Note: BCD-related actions are ignored.
  switch(CPU->IR)
  {
    // ###################### ADC #########################
  case 0x6D: // ABS
      operand = ABS(); ADC(operand); break;
  case 0x7D: // ABSX
      operand = ABSX(); ADC( operand ); break;     
  case 0x79: // ABSY
      operand = ABSY(); ADC(operand); break;
  case 0x69: // IMM
    operand = IMM(); ADC(operand); break;
  case 0x71: // INDY
    operand = INDY(); ADC(operand); break;
  case 0x61: // XIND
    operand = XIND(); ADC(operand); break;
  case 0x65: // ZP
    operand = ZP(); ADC(operand); break;
  case 0x75: // ZPX
    operand = ZPX(); ADC(operand); break;

    // ###################### AND #########################
  case 0x2D: // ABS
    operand = ABS(); AND(operand); break;
  case 0x3D: // ABSX
    operand = ABSX(); AND(operand); break;
  case 0x39: // ABSY
    operand = ABSY(); AND(operand); break;
  case 0x29: // IMM
    operand = IMM(); AND(operand); break;
  case 0x31: // INDY
    operand = INDY(); AND(operand); break;
  case 0x21: // XIND
    operand = XIND(); AND(operand); break;
  case 0x25: // ZP
    operand = ZP(); AND(operand); break;    
  case 0x35: // ZPX
    operand = ZPX(); AND(operand); break;

    // ###################### ASL #########################
  case 0x0E: // ABS
    ASL( &CPU->MEM[(CPU->MEM[ CPU->PC++] | (CPU->MEM[ CPU->PC++] << 8))]); break;

  case 0x1E: // ABSX
    ASL( &CPU->MEM[( (CPU->MEM[ CPU->PC++] | (CPU->MEM[ CPU->PC++] << 8)) + CPU->X)]); break;
  case 0x0A: // ACC
    ASL( &CPU->A ); break;
  case 0x06: // ZP
    ASL( &CPU->MEM[ CPU->MEM[ CPU->PC++] ] ); break;
  case 0x16: // ZPX
    ASL( &CPU->MEM[ (CPU->MEM[ CPU->PC++] + CPU->X) & 0xFF] ); break;
    break;
	
    // ########################## BCC #####################
  case 0x90: // REL
    if(CPU->P.C == 0)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
    printf("BCC!\n");
    break;
			
    // ####################### BCS ########################
  case 0xB0: // REL
    if(CPU->P.C == 1)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else	
      ++CPU->PC;*/
    printf("BCS!\n");
    break;
			
    // ######################## BEQ #######################
  case 0xF0: // REL
    if(CPU->P.Z == 1)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
    printf("BEQ!\n");
    break;
		
    // ########################## BMI #####################
  case 0x30: // REL
    if(CPU->P.N == 1)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
		
    printf("BMI!\n");
    break;
		
    // ######################## BNE #######################
  case 0xD0: // REL
    if(CPU->P.Z == 0)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
	
    printf("BNE!\n");
    break;
			
    // ####################### BPL ########################
  case 0x10: // REL
    if(CPU->P.N == 0)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
	
    printf("BPL!\n");
    break;
    
    // ######################### BRK ######################
  case 0x00: // IMP
    //++CPU->PC;
    CPU->MEM[ STACK + CPU->S ] = CPU->PC & 0xFF;
    --CPU->S;
    CPU->MEM[ STACK + CPU->S ] = (CPU->PC >> 8) & 0xFF;
    --CPU->S;
    CPU->MEM[ STACK + CPU->S ] = (CPU->P.N << 7) | (CPU->P.V << 6) | (0x01 << 4) |
      (CPU->P.I << 2) | (CPU->P.Z << 1) | (CPU->P.C);
    --CPU->S;
    CPU->PC = (CPU->MEM[0xFFFE]) | (CPU->MEM[0xFFFF] << 8);
    printf("BRK!\n");
    break;
			
    // ######################## BVC #######################
  case 0x50: // REL
    if(CPU->P.V == 0)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
    printf("BCV!\n");
    break;
		
    // ######################## BVS #######################
  case 0x70: // REL
    if(CPU->P.V == 1)
      CPU->PC += CPU->MEM[CPU->PC];
    /*else
      ++CPU->PC;*/
    printf("BVS!\n");
    break;

    // ######################### CLC ######################
  case 0x18: // IMP
    CPU->P.C = 0;
    //++CPU->PC;
    printf("CLC!\n");
    break;
		
    // ######################### CLD ######################
  case 0xD8: // IMP
    CPU->P.D = 0;
    //++CPU->PC;
    printf("CLD!\n");
    break;
	       
    // ####################### CLI ########################
  case 0x58: // IMP
    CPU->P.I = 0;
    //++CPU->PC;
    printf("CLI!\n");
    break;
		  
    // ######################### CLV ######################
  case 0xB8: // IMP
    CPU->P.V = 0;
    //++CPU->PC;
    printf("CLV!\n");
    break;
	
    // ######################### BIT ######################
  case 0x24: // ZP
    temp = CPU->A & CPU->MEM[ CPU->MEM[CPU->PC++] ];
    CPU->P.N = temp & 0x80;
    CPU->P.V = temp & 0x40;
    CPU->P.Z = (temp == 0) ? 1 : 0;
    printf("BIT!\n");
    break;
  case 0x2C: // ABS
    temp = CPU->A & (CPU->MEM[ CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8) ]);
    CPU->P.N = temp & 0x80;
    CPU->P.V = temp & 0x40;
    CPU->P.Z = (temp == 0) ? 1 : 0;
    printf("BIT!\n");
    break;

    // ######################### CMP ######################
  case 0xCD: // ABS
    operand = ABS(); CMP(operand); break;
  case 0xDD: // ABSX
    operand = ABSX(); CMP(operand); break;
  case 0xD9: // ABSY
    operand = ABSY(); CMP(operand); break;
  case 0xC9: // IMM
    operand = IMM(); CMP(operand); break;
  case 0xD1: // INDY
    operand = INDY(); CMP(operand); break;
  case 0xC1: // XIND
    operand = XIND(); CMP(operand); break;
  case 0xC5: // ZP
    operand = ZP(); CMP(operand); break;
  case 0xD5: // ZPX
    operand = ZPX(); CMP(operand); break;

    // ####################### CPX ########################
  case 0xEC: // ABS
    operand = ABS(); CPX(operand); break;
  case 0xE0: // IMM
    operand = IMM(); CPX(operand); break;
  case 0xE4: // ZP
    operand = ZP(); CPX(operand); break;
	  
    // ###################### CPY #########################
  case 0xCC: // ABS
    operand = ABS(); CPY(operand); break;
  case 0xC0: // IMM
    operand = IMM(); CPY(operand); break;
  case 0xC4: // ZP
    operand = ZP(); CPY(operand); break;

    // ########################### DEC ####################
  case 0xCE: // ABS
    DEC( &CPU->MEM[ CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8) ] ); break;
  case 0xDE: // ABSX
    DEC( &CPU->MEM[ ((CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) + CPU->X) & 0xFFFF ]); break;
  case 0xC6: // ZP
    DEC( &CPU->MEM[ CPU->MEM[CPU->PC++] ] ); break;
  case 0xD6:
    DEC( &CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF] ); break;
    
    // ############################ DEX ###################
  case 0xCA: // IMP
    --CPU->X;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    CPU->P.N = CPU->X & 0x80;
    printf("DEX!\n");
    break;
    
    // ########################## DEY #####################
  case 0x88:
    --CPU->Y;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    CPU->P.N = CPU->Y & 0x80;
    printf("DEY!\n");
    break;
    
    // ######################## EOR #######################
  case 0x4D: // ABS
    CPU->A = CPU->A ^ ABS(); printf("EOR!\n"); break;
  case 0x5D: // ABSX
    CPU->A = CPU->A ^ ABSX(); printf("EOR!\n"); break;    
  case 0x59: // ABSY
    CPU->A = CPU->A ^ ABSY(); printf("EOR!\n"); break;
  case 0x49: // IMM
    CPU->A = CPU->A ^ IMM(); printf("EOR!\n"); break;
  case 0x51: // INDY
    CPU->A = CPU->A ^ INDY(); printf("EOR!\n"); break;
  case 0x41: // XIND
    CPU->A = CPU->A ^ XIND(); printf("EOR!\n"); break;
  case 0x45: // ZP
    CPU->A = CPU->A ^ ZP(); printf("EOR!\n"); break;
  case 0x55: // ZPX
    CPU->A = CPU->A ^ ZPX(); printf("EOR!\n"); break;
    
    // ######################## INC #######################
  case 0xEE: // ABS
    INC( &CPU->MEM[ CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8) ] ); break;
  case 0xFE: // ABSX
    INC( &CPU->MEM[ (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8) + CPU->X) & 0xFFFF ] ); break;
  case 0xE6: // ZP
    INC( &CPU->MEM[ CPU->MEM[CPU->PC++] ] )  ; break;
  case 0xF6: // ZPX
    INC( &CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ] ); break;

    // ########################### INX #####################
  case 0xE8:
    ++CPU->X;
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    CPU->P.N = (CPU->X & 0x80);
    printf("INX!\n");
    break;
					
    // ############################### INY ###################
  case 0xC8:
    ++CPU->Y;
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    CPU->P.N = (CPU->Y & 0x80);
    printf("INY!\n");
    break;

    // ############################## JMP #####################
  case 0x4C: // ABS
    CPU->PC = CPU->MEM[ CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8) ]; printf("JMP!\n"); break;
  case 0x6C: // IND
    temp = CPU->MEM[ CPU->PC++ ];
    CPU->PC = CPU->MEM[ temp | ((temp+1) << 8) ]; printf("JMP!\n"); break;

    // ############################## JSR #####################
  case 0x20: // ABS
    temp_addr = CPU->PC - 1;
    CPU->S = (temp_addr >> 8) & 0xFF; // Push to Stack
    --CPU->S;
    CPU->S = (temp_addr & 0xFF);
    --CPU->S;
    CPU->PC = CPU->MEM[ CPU->PC++ ] | (CPU->MEM[ CPU->PC++] << 8);
    printf("JSR!\n");
    break;

    // ########################## LDA #######################
  case 0xAD: // ABS
    operand = ABS(); LDA( operand ); break;
  case 0xBD: // ABSX
    operand = ABSX(); LDA( operand ); break;
  case 0xB9: // ABSY
    operand = ABSY(); LDA( operand ); break; 
  case 0xA9: // IMM
    LDA ( CPU->MEM[ CPU->PC++] ); break;
  case 0xB1: // INDY
    operand = INDY(); LDA( operand ); break;
  case 0xA1: // XIND
    operand = XIND(); LDA( operand ); break;
  case 0xA5: // ZP
    operand = ZP(); LDA( operand ); break;
  case 0xB5: // ZPX
    operand = ZPX(); LDA( operand ); break;

    // ########################## LDX #######################
  case 0xAE: // ABS
    operand = ABS(); LDX( operand ); break;
  case 0xBE: // ABSY
    operand = ABS(); LDX( operand ); break;
  case 0xA2: // IMM
    LDX( CPU->MEM[ CPU->PC++ ] ); break;
  case 0xA6: // ZP
    operand = ZP(); LDX( operand ); break;
  case 0xB6: // ZPY
    operand = CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->Y) & 0xFF ]; LDX( operand ); break;

    // ########################## LDY ######################
  case 0xAC: // ABS
    operand = ABS(); LDY( operand ); break;
  case 0xBC: // ABSX
    operand = ABSX(); LDY( operand ); break;
  case 0xA0: // IMM
    LDY( CPU->MEM[ CPU->PC++] ); break;
  case 0xA4: // ZP
    operand = ZP(); LDY( operand ); break;
  case 0xB4: // ZPX
    operand = ZPX(); LDY( operand ); break;

    // ####################### LSR #########################
  case 0x4E: // ABS
    LSR( &CPU->MEM[  (CPU->MEM[ CPU->PC++ ] | (CPU->MEM[ CPU->PC++ ] << 8)) ]); break;
  case 0x5E: // ABSX
    LSR( &CPU->MEM[  ((CPU->MEM[ CPU->PC++ ] | (CPU->MEM[ CPU->PC++ ] << 8)) + CPU->X ) & 0xFFFF  ] ); 
    break;
  case 0x4A: // ACC
    LSR( &CPU->A ); break;
  case 0x46: // ZP
    LSR( &CPU->MEM[ CPU->MEM[ CPU->PC++ ] ] ); break;
  case 0x56: // ZPX
    LSR( &CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->X) & 0xFF ] ); break;

    // ######################### NOP #######################
  case 0xEA:
    printf("NOP!\n");
    break;

    // ########################## ORA ######################
  case 0x0D: // ABS
    operand = ABS(); ORA( operand ); break;
  case 0x1D: // ABSX 
    operand = ABSX(); ORA( operand ); break;
  case 0x19: // ABSY
    operand = ABSY(); ORA( operand ); break;
  case 0x09: // IMM
   ORA( CPU->MEM[ CPU->PC++ ] ); break;
  case 0x11: // INDY
    operand = INDY(); ORA( operand ); break;
  case 0x01: // XIND
    operand = XIND(); ORA( operand ); break;
  case 0x05: // ZP
    operand = ZP(); ORA( operand ); break;
  case 0x15: // ZPX
    operand = ZPX(); ORA( operand ); break;

    // ######################### PHA #######################
  case 0x48: // IMP
    CPU->MEM[ STACK + CPU->S ] = CPU->A;
    --CPU->S;
    printf("PHA!\n");
    break;

    // ########################### PHP #####################
  case 0x08: // IMP
    CPU->MEM[ STACK + CPU->S ] = (CPU->P.N << 7) | (CPU->P.V << 6) | (0x01 << 4) |
      (CPU->P.I << 2) | (CPU->P.Z << 1) | (CPU->P.C);
    --CPU->S;
    printf("PHP!\n");
    break;

    // ########################## PLA ######################
  case 0x68: // IMP
    ++CPU->S;
    CPU->A = CPU->MEM[ STACK + CPU->S ];
    CPU->P.N = CPU->A & 0x80;
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    printf("PLA!\n");
    break;

    // ########################## PLP ########################
  case 0x28:
    ++CPU->S;
    operand = CPU->MEM[ STACK + CPU->S ];
    CPU->P.N = (operand >> 7) & 0x01; 
    CPU->P.V = (operand >> 6) & 0x01;
    CPU->P.B = (operand >> 4) & 0x01;
    CPU->P.I = (operand >> 2) & 0x01;
    CPU->P.Z = (operand >> 1) & 0x01;
    CPU->P.C = (operand) & 0x01;
    printf("PLP!\n");
    break;

    // ######################## ROL #######################
  case 0x2E: // ABS
    ROL( &CPU->MEM[ (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8 )) ] ); break; 
  case 0x3E: // ABSX
    ROL( &CPU->MEM[ ( (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) + CPU->X) & 0xFFFF] ); break;
  case 0x2A: // ACC
    ROL( &CPU->A ); break;
  case 0x26: // ZP
    ROL( &CPU->MEM[ CPU->MEM[ CPU->PC++ ] ] ); break;
  case 0x36: // ZPX
    ROL( &CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->X) & 0xFF ] ); break;

    // ########################## ROR ########################
  case 0x6E: // ABS
    ROR( &CPU->MEM[ (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8 )) ] ); break; 
  case 0x7E: // ABSX
    ROR( &CPU->MEM[ ( (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) + CPU->X) & 0xFFFF] ); break;
  case 0x6A: // ACC
    ROR( &CPU->A ); break;
  case 0x66: // ZP
    ROR( &CPU->MEM[ CPU->MEM[ CPU->PC++ ] ] ); break;
  case 0x76: // ZPX
    ROR( &CPU->MEM[ (CPU->MEM[ CPU->PC++ ] + CPU->X) & 0xFF ] ); break;


    // ######################## RTI ##########################
  case 0x40:
    --CPU->S;
    operand = CPU->MEM[ STACK + CPU->S ];
    CPU->P.N = (operand >> 7) & 0x01; 
    CPU->P.V = (operand >> 6) & 0x01;
    CPU->P.B = (operand >> 4) & 0x01;
    CPU->P.I = (operand >> 2) & 0x01;
    CPU->P.Z = (operand >> 1) & 0x01;
    CPU->P.C = (operand) & 0x01;
    --CPU->S;
    CPU->PC = (CPU->MEM[ STACK + CPU->S] );
    --CPU->S;
    CPU->PC = CPU->PC | (CPU->MEM[ STACK + CPU->S ] << 8);
    printf("RTI!\n");
    break;
	
    // ############################# RTS #######################
  case 0x60:
    ++CPU->S;
    CPU->PC = CPU->MEM[ STACK + CPU->S ];
    ++CPU->S;
    CPU->PC = (CPU->PC | ( CPU->MEM[ STACK + CPU->S ] << 8 )) + 1;
    printf("RTS!\n");
    break;

    // ####################### SBC ############################
  case 0xED: // ABS
    operand = ABS(); SBC( operand ); break;
  case 0xFD: // ABSX
    operand = ABSX(); SBC( operand ); break;
  case 0xF9: // ABSY
    operand = ABSY(); SBC( operand ); break;
  case 0xE9: // IMM
    SBC( CPU->MEM[ CPU->PC++ ] ); break;
  case 0xF1: // INDY
    operand = INDY(); SBC( operand ); break;
  case 0xE1: // XIND
    operand = XIND(); SBC( operand ); break;
  case 0xE5: // ZP
    operand = ZP(); SBC( operand ); break;
  case 0xF5: // ZPX
    operand = ZPX(); SBC( operand ); break;
		
    // ############################ SEC ########################
  case 0x38: // IMP
    CPU->P.C = 1;
    printf("SEC!\n");
    break;
		
    // ############################ SED ########################
  case 0xF8: // IMP
    CPU->P.D = 1;
    printf("SED!\n");
    break;
		
    // ############################ SEI #########################
  case 0x78:
    CPU->P.I = 1;
    printf("SEI!\n");
    break;
		

    // ############################## STA ########################
  case 0x8D: // ABS
    CPU->MEM[ (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) ] = CPU->A; 
    printf("STA!\n"); break;
  case 0x9D: // ABSX
    CPU->MEM[ ((CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) + CPU->X) & 0xFFFF ] = CPU->A; 
    printf("STA!\n"); break;
  case 0x99: // ABSY
    CPU->MEM[ ((CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) + CPU->Y) & 0xFFFF ] = CPU->A; 
    printf("STA!\n"); break;
  case 0x91: // INDY
    temp_addr = CPU->MEM[ (CPU->MEM[CPU->PC++]) ];
    temp_addr = temp_addr | ((temp_addr+1) << 8);
    CPU->MEM[ (temp_addr + CPU->Y) & 0xFFFF ] = CPU->A;
    printf("STA!\n"); break;
  case 0x81: // XIND
    temp_addr = CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ];
    temp_addr = temp_addr | ((temp_addr+1) << 8);
    CPU->MEM[ temp_addr ] = CPU->A;
    printf("STA!\n"); break;
  case 0x85: // ZP
    CPU->MEM[ (CPU->MEM[CPU->PC++]) ] = CPU->A; 
    printf("STA!\n"); break;
  case 0x95: // ZPX
    CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->X) & 0xFF ] = CPU->A; 
    printf("STA!\n"); break;
		
    // ############################### STX ###########################
  case 0x8E: // ABS
    CPU->MEM[ (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) ] = CPU->X;
    printf("STX!\n"); break;
  case 0x86: // ZP
    CPU->MEM[ (CPU->MEM[CPU->PC++]) ] = CPU->X;
    printf("STX!\n"); break;
  case 0x96: // ZPY
    CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->Y) & 0xFF ] = CPU->X;
    printf("STX!\n"); break;

    // ############################ STY ################################
  case 0x8C: // ABS
    CPU->MEM[ (CPU->MEM[CPU->PC++] | (CPU->MEM[CPU->PC++] << 8)) ] = CPU->Y;
    printf("STY!\n"); break;
  case 0x84: // ZP
    CPU->MEM[ (CPU->MEM[CPU->PC++]) ] = CPU->Y;
    printf("STY!\n"); break;
  case 0x94: // ZPY
    CPU->MEM[ (CPU->MEM[CPU->PC++] + CPU->Y) & 0xFF ] = CPU->Y;
    printf("STY!\n"); break;

    // ########################## TAX #################################
  case 0xAA: // IMP
    CPU->X = CPU->A;
    CPU->P.N = (CPU->X & 0x80);
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    printf("TAX!\n"); break;

    // ########################### TAY ################################
  case 0xA8: // IMP
    CPU->Y = CPU->A;
    CPU->P.N = (CPU->Y & 0x80);
    CPU->P.Z = (CPU->Y == 0) ? 1 : 0;
    printf("TAY!\n"); break;


    // ############################# TSX ##############################
  case 0xBA:
    CPU->X = CPU->S;
    CPU->P.N = (CPU->X & 0x80);
    CPU->P.Z = (CPU->X == 0) ? 1 : 0;
    printf("TSX!\n"); break;

    // ########################## TXA ################################
  case 0x8A:
    CPU->A = CPU->X;
    CPU->P.N = (CPU->A & 0x80);
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    printf("TXA!\n"); break;
		
    // ############################# TXS ################################
  case 0x9A:
    CPU->S = CPU->X;
    printf("TXS!\n");
    break;

    // ############################### TYA ##############################
  case 0x9B:
    CPU->A = CPU->Y;
    CPU->P.N = (CPU->A & 0x80);
    CPU->P.Z = (CPU->A == 0) ? 1 : 0;
    printf("TYA!\n");
    break;

          	
  default:
    printf("Invalid opcode!\n");
    break;
  }
  
  return;
}


void load_rom(char* file, byte** prg_array, byte** chr_array, byte* prg_size, byte* chr_size)
{
  // Open ROM
  FILE* NES_ROM = fopen(file, "r"); // Grab ROM

 
  printf("Opening rom...");
  if(NES_ROM)
  {
    printf("done! Reading bytes...\n");
    byte bytes = 0;
    int wcounter = 0;
    int i = 0;
    
    
    // Grab proper data from NES rom
    for(i = 0; i < 4; ++i)	// Remove junk iNES header
      bytes = getc(NES_ROM);
    
    
    *prg_size = getc(NES_ROM);	// PRG_ROM count
    printf("Found PRG_ROM count to be: %u\n", *prg_size);
 
    // Initialize prg_array with bank count grabbed
    *prg_array = (byte*) malloc(sizeof(byte)*1024*16*(*prg_size));
   
    *chr_size = getc(NES_ROM);	// CHR_ROM count
    printf("Found CHR_ROM count to be: %u\n", *chr_size);
    
    // Do the same for chr_array
    *chr_array = (byte*) malloc(sizeof(byte)*1024*8*(*chr_size));
    
    // Remove more junk bytes. Note: First two bytes exist for 
    // trainer/ROM control bytes (horizontal mirroring)
    for(i = 0; i < 10; ++i)	
      bytes = getc(NES_ROM);
    
    
    // Begin reading relevant data from ROM		
    printf("Reading PRG_ROM...");
    for(i = 0; i < 1024*16*(*prg_size); ++i)	// Grab PRG_ROM
    {
      bytes = getc(NES_ROM);
      (*prg_array)[i] = bytes;		
    }

    printf("...done!\nReading CHR_ROM...");
    for(i = 0; i < 1024*8*(*chr_size); ++i)	// Grab CHR_ROM
    {
      bytes = getc(NES_ROM);
      (*chr_array)[i] = bytes;		
    }
    printf("...done!\n");
    
    
  }
  else
    printf("Error opening ROM...\n");


  return;
}

void mmap_init(byte** prg_array)
{  
  int i = 0;

  // Initialize Zero Page - SRAM ($0000-$07FF)
  for(i = 0; i < 0x8000; ++i)
    CPU->MEM[i] = 0x00;

  // Fill PRG_ROM lower bank
  for(i = 0; i < 0x4000; ++i)
    CPU->MEM[i+PRG] = (*prg_array)[i];

  // Fill PRG_ROM upper bank
  // NOTE: for now, we're assuming PRG_ROM is only one bank,
  //       so we simply copy the contents of first onto second.
  for(i = 0; i < 0x4000; ++i)
    CPU->MEM[i+PRG+0x4000] = (*prg_array)[i];
  
  return;
}

inline void cpu_init()
{
  CPU = (NMOS6502*) malloc(sizeof(NMOS6502));

  CPU->S = 0xFF;
  CPU->P.N = 0x00;
  CPU->P.V = 0x00;  
  CPU->P.I = 0x00;
  CPU->P.D = 0x00;  
  CPU->P.C = 0x00;
  CPU->P.B = 0x00;  
  CPU->P.Z = 0x00;
  CPU->PC = 0xFFFC;     // Start at RESET vector

  CPU->A = 0x00;
  CPU->X = 0x00;
  CPU->Y = 0x00;
  
  CPU->AB = 0x0000;
  CPU->DB = 0x00;
  
  CPU->IR = 0x00;
  CPU->T = 0x00;
  
  CPU->MEM = (byte*) malloc(sizeof(byte)*64*1024);

  return;
}

inline void cpu_status()
{
  printf("\nA: %x X: %x Y: %x P: %x %x %x %x %x %x %x SP: %x PC: %x IR: %x\n",
	 CPU->A, CPU->X, CPU->Y, CPU->P.N, CPU->P.V, CPU->P.I, CPU->P.D, CPU->P.C, 
	 CPU->P.B, CPU->P.Z, CPU->S, CPU->PC, CPU->IR);

  return;
}




/* Addressing Mode and Instruction Functions */
byte ABS()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ]) | (CPU->MEM[ CPU->PC++ ] << 8);  // Grab lower and upper byte
  return CPU->MEM[ temp_addr ];
}

byte ABSX()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ]) | (CPU->MEM[ CPU->PC++ ] << 8);  // Grab lower and upper byte
  return CPU->MEM[ (temp_addr + CPU->X) & 0xFFFF ]; // Wrap occurs if base + X > 0xFFFF
}

byte ABSY()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ]) | (CPU->MEM[ CPU->PC++ ] << 8);  // Grab lower and upper byte
  return CPU->MEM[ (temp_addr + CPU->Y) & 0xFFFF ];
}


byte XIND()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ] + CPU->X);  // Fetch low byte from ZP+X
  temp_addr = (temp_addr | (CPU->MEM[ (temp_addr+1) & 0xFF ] << 8)); // Fetch high byte from ZP+1+X
  return CPU->MEM[ temp_addr & 0xFFFF ];  
}

byte INDY()
{
  word temp_addr = (CPU->MEM[ CPU->PC++ ]);  // Fetch low byte from ZP
  temp_addr = (temp_addr | (CPU->MEM[ (temp_addr+1) & 0xFF ] << 8)); // Fetch high byte from ZP+1. Wrap occurs if offset is > $FF
  return CPU->MEM[ (temp_addr + CPU->Y) & 0xFFFF];  // Fetch contents of ($ZP)+Y
}


byte IMM()
{
  return CPU->MEM[CPU->PC++]; // operand = #$MEM[PC]
}

byte ZP()
{
  return CPU->MEM[ (CPU->MEM[CPU->PC++]) ]; // operand = $(MEM[PC])
}

byte ZPX()
{
  return CPU->MEM[ ((CPU->MEM[CPU->PC++]) + CPU->X) & 0xFF]; // operand = $(MEM[PC])
}



void ADC(byte operand)
{
  byte temp = CPU->A + operand + CPU->P.C; 
  CPU->P.V = ((CPU->A & 0x80) != (temp & 0x80)) ? 1 : 0;
  CPU->P.N = (CPU->A & 0x80);
  CPU->P.Z = (temp == 0) ? 1 : 0;
  CPU->A = temp & 0xFF;
  printf("ADC!\n");
  return;
}

void AND(byte operand)
{
  CPU->A = CPU->A & operand;
  CPU->P.N = (CPU->A & 0x80);
  CPU->P.Z = (CPU->A == 0) ? 1 : 0;
  printf("AND!\n");
  return;
}

void ASL(byte* operand)
{
  CPU->P.C = (*operand) & 0x80;
  (*operand) = ((*operand) << 1) & 0xFE;
  CPU->P.N = (*operand) & 0x80;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  printf("ASL!\n");
  return;
}

void CMP( byte operand )
{
  byte temp = CPU->A - operand;
  CPU->P.N = temp & 0x80;
  CPU->P.C = (CPU->A >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  printf("CMP!\n");
  return;
}

void CPX( byte operand )
{
  byte temp = CPU->X - operand;
  CPU->P.N = temp & 0x80;
  CPU->P.C = (CPU->X >= operand) ? 1 : 0;
  CPU->P.Z = (temp == 0) ? 1 : 0;
  printf("CPX!\n");
  return;
}

void CPY( byte operand )
{
  byte temp = CPU->Y - operand;
  CPU->P.N = temp & 0x80;
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
  CPU->P.N = (*operand) & 0x80;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  printf("INC!\n");
  return;
}

void LDA( byte operand )
{
  CPU->A = operand;
  CPU->P.N = CPU->A & 0x80;
  CPU->P.Z = (CPU->A == 0) ? 1 :0;
  printf("LDA!\n");
  return;
}

void LDX( byte operand )
{
  CPU->X = operand;
  CPU->P.N = CPU->X & 0x80;
  CPU->P.Z = (CPU->X == 0) ? 1 :0;
  printf("LDX!\n");
  return;
}

void LDY( byte operand )
{
  CPU->Y = operand;
  CPU->P.N = CPU->Y & 0x80;
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
  CPU->P.N = (CPU->A & 0x80);
  CPU->P.Z = (CPU->A == 0 ) ? 1 : 0;
  printf("ORA!\n");
  return;
}


void ROL( byte* operand )
{
  byte temp = (*operand) & 0x80;
  (*operand) = ((*operand) << 1) & 0xFE;
  (*operand) = (*operand) | CPU->P.C;
  CPU->P.C = temp;
  CPU->P.Z = ((*operand) == 0) ? 1 : 0;
  CPU->P.N = (*operand) & 0x80;
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
  CPU->P.N = (*operand) & 0x80;
  printf("ROR!\n");
  return;
}

void SBC( byte operand )
{
  byte temp = CPU->A - operand - (!CPU->P.C);
  CPU->P.V = (temp > 127 || temp < -128 ) ? 1 : 0;
  CPU->P.C = (temp >= 0 ) ? 1 : 0;
  CPU->P.N = (temp & 0x80);
  CPU->P.Z = (temp == 0 ) ? 1 : 0;
  CPU->A = temp & 0xFF;
  printf("SBC!\n");
  return;
}
