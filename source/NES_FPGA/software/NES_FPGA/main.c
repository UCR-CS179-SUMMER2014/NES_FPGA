#include "NES.h"
#include "sdcard.h"
#include "cpu.h"

//#define DEBUG        // Enables methods for debugging functions

int main()
{
  // Declare appropriate arrays and variables
  char* file_name = "SMB.nes";
  char* en = (char*) malloc(sizeof(char)*2); // Buffer for cpu cycle pauses

  // Initialize CPU
  cpu_init();

  // Execute CPU instructions
  while(1)
  {
	// Check for interrupts
	if(CPU->RES == 1) // Reset
	{
		// Load NES rom from file
		// bootloader(); // Not implemented yet --> Gets filename for ROM
		cpu_reset();
		load_rom(file_name);

		// Display contents of PRG_ROM
		#ifdef DEBUG
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
		#endif
		printf("RES!\n");
	} // end RESET
	else if(CPU->NMI == 1) // Non-maskable interrupt (PPU)
	{
		printf("NMI!\n");
	}
	else if((CPU->IRQ == 1) && (CPU->P.I == 0)) // Interrupt Request
	{
		// Note that IRQ will not work if interrupts are disabled
		printf("IRQ!\n");
	}

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

