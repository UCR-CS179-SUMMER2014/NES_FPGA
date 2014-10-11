#include "cpu.h"
#include "ppu.h"
#include "vga.h"
#include "sdcard.h"

#define DEBUG        // Enables methods for debugging functions

int main()
{
  // Declare appropriate arrays and variables
  file_name = "Pinball.nes";
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
  //vga_test();


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
	if( PPU->ppuaddr == 0x2000 )
	{
		cpu_status();
		ppu_status();
	}

	if( CPU->instructions > 50000 )
		CPU->MEM[ 0x4016 ] = ~CPU->MEM[ 0x4016 ];
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

