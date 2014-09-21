#include "cpu.h"
#include "ppu.h"
#include "vga.h"
#include "sdcard.h"

//#define DEBUG        // Enables methods for debugging functions

int main()
{
  // Declare appropriate arrays and variables
  file_name = "DK.nes";
  char* en = (char*) malloc(sizeof(char)*2); // Used for stepping into CPU one instruction at a time

  // Initialize CPU
  cpu_init();

  // Initialize PPU
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
	if(CPU->RES == 1) // Reset, also the power-on state
	{
		// Reset CPU
		cpu_reset();

		// Display contents of PRG_ROM
		#ifdef DEBUG
			prg_test();
		#endif

		printf("RES! Into: %x\n", CPU->PC);
	}
	else if(CPU->NMI == 1) // Non-maskable interrupt (PPU)
		cpu_nmi();

	// Note that IRQ will not work if interrupts are disabled
	else if((CPU->IRQ == 1) && (CPU->P.I == 0)) // Interrupt Request
		cpu_irq();

	CPU->IR = CPU->MEM[ CPU->PC ];	// Load next instruction
	cpu_status(); // Debug CPU
	++CPU->PC;	  // Increment PC
	cpu_exec();   // Tick CPU (Execute Instruction)

	// Wait until enter is pressed to step-through
	fgets(en, 2, stdin);
  }

  // Free up allocated memory in heap
  free( CHR_ROM );
  free( CPU->MEM );
  free( CPU );
  return 0;

}

