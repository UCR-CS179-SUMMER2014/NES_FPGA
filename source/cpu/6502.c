#include "6502.h"

#define DEBUG        // Enables methods for debugging functions

// Declare CPU struct, which contains all required registers
NMOS6502* CPU;


/* 
   Function: decode_instruction( byte )
   Description: Reads in byte to decode into corresponding 
	  	instruction with addressing mode.
*/
void execute_instruction()
{
  switch(CPU->IR)
  {
    // ADC
    case 0x6D:
    case 0x7D:
    case 0x79:
    case 0x69:
    case 0x71:
    case 0x61:
    case 0x65:
    case 0x75:
      printf("ADC!\n");
      break;
		
    // AND
    case 0x2D:
    case 0x3D: 
    case 0x39:
    case 0x29:
    case 0x31:
    case 0x21:
    case 0x25:
    case 0x35:
      printf("AND!\n");
      break;

    // ASL
    case 0x0E:
    case 0x1E:
    case 0x0A:
    case 0x06:
    case 0x16:
      printf("ASL!\n");
      break;
	
    // BCC
    case 0x90:
      printf("BCC!\n");
      break;
			
    // BCS
    case 0xB0:
      printf("BCS!\n");
      break;
			
    // BEQ
    case 0xF0:
      printf("BEQ!\n");
      break;
		
    // BMI
    case 0x30:
      printf("BMI!\n");
      break;
		
    // BNE
    case 0xD0:
      printf("BNE!\n");
      break;
			
    // BPL 
    case 0x10:
      printf("BPL!\n");
      break;
    
    // BRK
    case 0x00:
      printf("BRK!\n");
      break;
			
    // BVC
    case 0x50:
      printf("BCV!\n");
      break;
		
    // BVS
    case 0x70:
      printf("BVS!\n");
      break;

    // CLC
    case 0x18:
      printf("CLC!\n");
      break;
		
    // CLD
    case 0xD8:
      printf("CLD!\n");
      break;
	       
      // CLI
    case 0x58:
      printf("CLI!\n");
      break;
		  
      // CLV
    case 0xB8:
      printf("CLV!\n");
      break;
	

      // BIT 
    case 0x2C:
    case 0x24:
      printf("BIT!\n");
      break;

      // CMP
    case 0xCD:
    case 0xDD:
    case 0xD9:
    case 0xC9:
    case 0xD1:
    case 0xC1:
    case 0xC5:
    case 0xD5:
      printf("CMP!\n");
      break;		

      // CPX
    case 0xEC:
    case 0xE0:
    case 0xE4:
      printf("CPX!\n");
      break;

      // CPY
    case 0xCC:
    case 0xC0:
    case 0xC4:
      printf("CPY!\n");
      break;

      // DEC
    case 0xCE:
    case 0xDE:
    case 0xC6:
    case 0xD6:
      printf("DEC!\n");
      break;

      // DEX
    case 0xCA:
      printf("DEX!\n");
      break;
		
      // DEY
    case 0x88:
      printf("DEY!\n");
      break;

      // EOR
    case 0x4D:
    case 0x5D:
    case 0x59:
    case 0x49:
    case 0x51:
    case 0x41:
    case 0x45:
    case 0x55:
      printf("EOR!\n");
      break;

      // INC
    case 0xEE:
    case 0xFE:
    case 0xE6:
    case 0xF6:
      printf("INC!\n");
      break;

      // INX
    case 0xE8:
      printf("INX!\n");
      break;
					
      // INY
    case 0xC8:
      printf("INY!\n");
      break;

      // JMP
    case 0x4C:
    case 0x6C:
      printf("JMP!\n");
      break;

      // JSR
    case 0x20:
      printf("JSR!\n");
      break;

      // LDA
    case 0xAD:
    case 0xBD:
    case 0xB9:
    case 0xA9:
    case 0xB1:
    case 0xA1:
    case 0xA5:
    case 0xB5:
      printf("LDA!\n");
      break;

      // LDX
    case 0xAE:
    case 0xBE:
    case 0xA2:
    case 0xA6:
    case 0xB6:
      printf("LDX!\n");
      break;

      // LDY
    case 0xAC:
    case 0xBC:
    case 0xA0:
    case 0xA4:
    case 0xB4:
      printf("LDY!\n");
      break;

      // LSR
    case 0x4E:
    case 0x5E:
    case 0x4A:
    case 0x46:
    case 0x56:
      printf("LSR!\n");
      break;

      // NOP
    case 0xEA:
      printf("NOP!\n");
      break;

      // ORA
    case 0x0D:
    case 0x1D:
    case 0x19:
    case 0x09:
    case 0x11:
    case 0x01:
    case 0x05:
    case 0x15:
      printf("ORA!\n");
      break;

      // PHA
    case 0x48:
      printf("PHP!\n");
      break;

      // PHP
    case 0x08:
      printf("PHP!\n");
      break;

      // PLA
    case 0x68:
      printf("PLA!\n");
      break;

      // PLP
    case 0x28:
      printf("PLP!\n");
      break;

      // ROL
    case 0x2E:
    case 0x3E:
    case 0x2A:
    case 0x26:
    case 0x36:
      printf("ROL!\n");
      break;

      // ROR
    case 0x6E:
    case 0x7E:
    case 0x6A:
    case 0x66:
    case 0x76:
      printf("ROR!\n");
      break;

      // RTI
    case 0x40:
      printf("RTI!\n");
      break;
	
      // RTS
    case 0x60:
      printf("RTS!\n");
      break;

      // SBC
    case 0xED:
    case 0xFD:
    case 0xF9:
    case 0xE9:
    case 0xF1:
    case 0xE1:
    case 0xE5:
    case 0xF5:
      printf("SBC!\n");
      break;
		
      // SEC
    case 0x38:
      printf("SEC!\n");
      break;
		
      // SED
    case 0xF8:
      printf("SED!\n");
      break;
		
      // SEI
    case 0x78:
      printf("SEI!\n");
      break;
		

      // STA
    case 0x8D:
    case 0x9D:
    case 0x99:
    case 0x91:
    case 0x81:
    case 0x85:
    case 0x95:
      printf("STA!\n");
      break;
		
      // STX	
    case 0x8E:
    case 0x86:
    case 0x96:
      printf("STX!\n");
      break;

      // STY
    case 0x8C:
    case 0x84:
    case 0x94:
      printf("STY!\n");
      break;

      // TAX
    case 0xAA:
      printf("TAX!\n");
      break;

      // TAY
    case 0xA8:
      printf("TAY!\n");
      break;


      // TSX
    case 0xBA:
      printf("TSX!\n");
      break;

      // TXA
    case 0x8A:
      printf("TXA!\n");
      break;
		
      // TXS
    case 0x9A:
      printf("TXS!\n");
      break;

      // TYA
    case 0x9B:
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


inline void cpu_init()
{
  CPU = (NMOS6502*) malloc(sizeof(NMOS6502));

  CPU->S = 0xFF;
  CPU->P = 0x00;
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
  printf("\nA: %x X: %x Y: %x P: %x SP: %x PC: %x IR: %x\n",
	 CPU->A, CPU->X, CPU->Y, CPU->P, CPU->S, CPU->PC, CPU->IR);

  return;
}

int main()
{
  // Declare appropriate arrays and variables
  char* file_name = "../../roms/nestest.nes";
  byte* PRG_ROM = NULL;	// Supports 1 PRG Bank currently
  byte* CHR_ROM = NULL; // Supports 1 CHR Bank currently
  byte prg_size = 0, chr_size = 0;

  // Load NES rom from file
  load_rom(file_name, &PRG_ROM, &CHR_ROM, &prg_size, &chr_size);


  // Display contents of PRG and CHR ROM
  #ifdef DEBUG
  {
    int i = 0;
    int x = 0;
    printf("############# PRG ROM #############\n");
    for(i = 0; i < 16384; ++i)
    {
      printf("%x ", PRG_ROM[i]);
      if(x >= 50)
      {
	printf("\n");
	x = 0;
      }
      else
	++x;
    }
    /*printf("\n\n\n\n\n############# CHR ROM #############\n");
    for(i = 0; i < 8192; ++i)
    {
      printf("%x ", CHR_ROM[i]);
      if(x >= 50)
      {
	printf("\n");
	x = 0;
      }
      else
	++x;
    }

    printf("\n");*/
  }
  #endif

  // Set up CPU struct
  cpu_init();


  #ifdef DEBUG
  cpu_status();
  #endif

  // Execute CPU instructions



  // Free up allocated memory in heap
  free( PRG_ROM );
  free( CHR_ROM );
  free( CPU );
  return 0;
}
