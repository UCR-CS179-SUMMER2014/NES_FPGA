#include "cpu.h"
#include "ppu.h"
#include "vga.h"
#include "sdcard.h"

#define DEBUG        // Enables methods for debugging functions

inline void write_card();	// Writes debug info to SD card

int main()
{
  // Declare appropriate arrays and variables
  file_name = "DK.nes";
  //char* en = (char*) malloc(sizeof(char)*2); // Used for stepping into CPU one instruction at a time

  // Initialize CPU
  cpu_init();

  // Initialize PPU/Video
  vga_init();
  ppu_init();

  // Load the ROM. CPU and PPU Memory map will be populated here as well
  // TODO: bootloader();   // Not implemented yet --> Gets filename for ROM
  load_rom();

  // VGA controller test for character and pixel buffer
  vga_test();


  // Start NES execution
  while(1)
  {
	// Check for interrupts
	cpu_int_check();	// Priority: RESET > NMI > IRQ. PC is set to interrupt subroutine if set.

	// Throw an error if found invalid opcode
	if(CPU->exit)		// Debug info will be displayed as well.
		return 0;

	// Fetch next instruction
	CPU->IR = CPU->MEM[ CPU->PC ]; // Note PC is incremented for the next byte

	// Test to see if palette table is being populated
	/*if( PPU->MEM[ 0x3F00] > 0 )
	{
		cpu_status();
		ppu_status();
		printf("$3F00: %x\n\n", PPU->MEM[ 0x3F00 ]  );
	}*/

	// Display debug info
	//cpu_status();
	//ppu_status();
	//printf("\n\n");

	++CPU->PC;				// Increment PC after fetching opcode byte.
	cpu_exec();   			// Tick CPU (Execute Instruction)
	ppu_exec();	  			// Tick PPU (Fetch tile data and render pixels)
	++CPU->instructions; 	// Increment instruction count
  }


  // Free up allocated memory in heap
  free( CPU->MEM );
  free( CPU );
  free( PPU->MEM );
  return 0;

}


char* i;
inline void write_card()
{
  sprintf(data, "A: %x X: %x Y: %x P: %x%x1%x %x%x%x%x SP: %x PC: %x T: %x IR: %x ",
	 CPU->A, CPU->X, CPU->Y, CPU->P.N, CPU->P.V, CPU->P.B, CPU->P.D, CPU->P.I,
	 CPU->P.Z, CPU->P.C, CPU->S, CPU->PC, CPU->T, CPU->IR);

  for(i = data; *i != '\0'; ++i)
	  alt_up_sd_card_write( file_handle, *i );

  print_opcode();

  for(i = data; *i != '\0'; ++i)
	  alt_up_sd_card_write( file_handle, *i );

  sprintf(data, "$2000: %x $2001: %x  $2002: %x $2003: %x $2004: %x  $2005: %x  $2006: %x  $2007: %x PPUADDR: %x INS: %d \n\n ",
  	  CPU->MEM[0x2000], CPU->MEM[0x2001], CPU->MEM[0x2002], CPU->MEM[0x2003], CPU->MEM[0x2004],
  	  CPU->MEM[0x2005], CPU->MEM[0x2006], CPU->MEM[0x2007], PPU->ppuaddr, CPU->instructions );

  for(i = data; *i != '\0'; ++i)
	  alt_up_sd_card_write( file_handle, *i );

  return;
}

/*// Debug
//file_handle = alt_up_sd_card_fopen( "log1.txt", 1 );




if( CPU->instructions > 50000 )
{
	  alt_up_sd_card_fclose( file_handle );
	  printf("Done writing to SD card...! Exiting...\n");
	  return 0;
}
write_card();*/


