/* Currently this code works perfectly adding everything to the RAM
 * However, it is set up so that only SMB.nes work. Make sure the ROM
 * name is SMB.nes. this will change at the end to make it work with any
 * ROM.
 */

#include <stdio.h>
#include <altera_up_sd_card_avalon_interface.h>
#include "system.h"
#include "sys/alt_irq.h"
#include "alt_types.h"
#include "sys/alt_sys_init.h"
#include "Rom_data.h"

short int sd_fileh;

int main()
{
  //This functions links the verilog modules with C
  alt_up_sd_card_dev *sd_card_dev = alt_up_sd_card_open_dev(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_NAME);

  //Checks if it was able to obtain the address of the SD Card Socket
  if(sd_card_dev != 0)
  {
	  //Checks if the SD Card is Present in the Socket
      if(alt_up_sd_card_is_Present())
      {
    	  //Check if the Card is Fat16
          if(alt_up_sd_card_is_FAT16())
          {
			  //opens the file to be read - 0 if successful
			  sd_fileh = alt_up_sd_card_fopen("SMB.nes", false);
			  if(sd_fileh == 0)
			  {

				  char data = 0;
				  unsigned int Counter = 0;

				 //Extracting the 16 Byte Header
				  for(Counter = 0; Counter < NES_HEADER_SIZE; Counter++)
				  {
					  data = alt_up_sd_card_read(sd_fileh);
					  NES_HEADER_INSERT(NES_HEADER,Counter,(unsigned)data);
				  }

				  //Compute PGR and CHR Sizes
				  SET_PRG_SIZE();
				  SET_CHR_SIZE();

				  //Extract the PRG Data
				  for(Counter = 0; Counter < PRG_size; Counter++)
				  {
					  data = alt_up_sd_card_read(sd_fileh);
					  PRG_DATA[Counter] = (unsigned)data;
				  }

				  //Extract the CHR Data
				  for(Counter = 0; Counter < PRG_size; Counter++)
				  {
					  data = alt_up_sd_card_read(sd_fileh);
					  CHR_DATA[Counter] = (unsigned)data;
				  }
				  printf("Successfully Completed\n");
			  }
			  else printf("ERROR: OPENING FILE\n");
          }
          else printf("ERROR: SD CARD NOT FAT16 FORMAT\n");
      }
      else printf("ERROR: SD CARD NOT PRESENT\n");
  }
  else printf("ERROR: UNABLE TO OBATIN SD SOCKET ADDRESS\n");

  return 0;
}


