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

	/*if( CPU->PC == 0xF4F3 )
	{
		cpu_status();
		ppu_status();

		// Output stack
		printf("\nSTACK: ");
		int i = 0;
		for(i = 0xFF - CPU->S; i > 0; --i)
		{
			printf("%x ", CPU->MEM[ STACK + CPU->S + i ]);
		}

		printf("\n\n");
	}*/


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


/*
	// Print out Name Table tiles
	int i = 0;
	for(i = 0x2000; i < 0x23C0; ++i)
	{
		if( (i - 0x2000) % 30 == 0 && (i - 0x2000) > 1)
			printf("\n");
		printf("%x ", PPU->MEM[i]);
	}
 */


