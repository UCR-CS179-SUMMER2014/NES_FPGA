#ifndef _ROM_DATA_H_
#define _ROM_DATA_H_

#include <malloc.h>
#include <stdio.h>

//=========================================================
//GLOBAL HEADER INFORMATION AND SUROUTINES
#define NES_HEADER_SIZE 16
char NES_HEADER[NES_HEADER_SIZE];

//GLOBAL PGR INFORMATION AND SUBROUTINES
#define PRG_temp_size 16384; //This is equivalent to 1x16Kb.
unsigned int PRG_size = 0;
unsigned char* PRG_DATA = NULL;

//GLOBAL CHR INFORMATION AND SUBROUTINES
#define CHR_temp_size 8192; //This is equivalent to 1x16Kb.
unsigned short int CHR_size = 0;
unsigned char* CHR_DATA = NULL;
//==========================================================
//FUNCTIONS PROTOTYPES
//==========================================================
void NES_HEADER_INSERT(char* header, int counter, int data);
void NES_HEADER_PRINT(char* header);
void NES_PRG_INSERT(char* PRG, int counter, int data);
void NES_PRG_PRINT();
void SET_PRG_SIZE();
void SNES_PRINT_PRG_SIZE();
void NES_CHR_INSERT(char* CHR, int counter, int data);
void NES_CHR_PRINT();
void SET_CHR_SIZE();
void SNES_PRINT_CHR_SIZE();
//==========================================================
//fUNCTION IMPLEMENTATION
//==========================================================
void NES_HEADER_INSERT(char* header, int counter, int data)
{
	header[counter] = data;
}
void NES_HEADER_PRINT(char* header)
{
	int i = 0;
	for(i = 0; i < NES_HEADER_SIZE; ++i)
    	printf("%d\n", NES_HEADER[i]);
}
//==================================================
void NES_PRG_INSERT(char* PRG, int counter, int data)
{
	PRG[counter] = data;
}
void NES_PRG_PRINT()
{
	int i = 0;
	int counter = 1;
	for(i = 0; i < PRG_size; ++i)
	{
	    if( (i % 16) == 0)
		{
	    	counter++;
			printf("->%d\n", counter);
		}
    	printf("%x ", PRG_DATA[i]);
	}
}

void SET_PRG_SIZE()
{
	PRG_size = NES_HEADER[4] * PRG_temp_size;
	PRG_DATA = malloc(PRG_size * sizeof(char));
	int i = 0;
	for(i = 0; i < PRG_size; ++i)
		PRG_DATA[i] = 0;
}
void SNES_PRINT_PRG_SIZE()
{
	printf("CHR Size: %d\n", PRG_size);
}
//=========================================================
void NES_CHR_INSERT(char* CHR, int counter, int data)
{
	CHR[counter] = data;
}
void NES_CHR_PRINT()
{
	int i = 0;
	for(i = 0; i < CHR_size; ++i)
    	printf("%d ", CHR_DATA[i]);
}

void SET_CHR_SIZE()
{
	CHR_size = NES_HEADER[5] * CHR_temp_size;
	CHR_DATA = malloc(CHR_size * sizeof(char));
	int i = 0;
	for(i = 0; i < CHR_size; ++i)
		CHR_DATA[i] = 0;
	printf("CHR Size: %d\n", CHR_size);
}
void SNES_PRINT_CHR_SIZE()
{
	printf("CHR Size: %d\n", CHR_size);
}
//=========================================================




#endif


