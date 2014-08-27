/*
 * main.c
 *
 *  Created on: Aug 25, 2014
 *      Author: Sergio
 */


#define SW 0x10
#define LEDS 0x00

int main()
{
	int* SWr = (int*) SW;
	int* LEDSr = (int*) LEDS;
	while(1)
	{
		(*LEDSr) = (*SWr);
		//printf("Your mom's value is: %x", (*LEDSr));
	}
	return 0;
}
