//===========================================================
// UCR's CS179J Nintendo Entertainment System - FPGA Emulator
// ----------------------------------------------------------
//       _        __   _____    ______         _______
//      / \      / /  / ___/  /  ____/        |   ____|
//     /   \    / /  / /__    \  \      ___   |  |___
//		/ / \ \  / /  / ___/     \  \    |___|  |   ___|
//   / /   \ \/ /  / /___   ____\  \          |  |
//	/_/     \__/  /_____/  /_______/          |__|
// ----------------------------------------------------------
//	Date:    August 23, 2014
// Authors: Sergio Morales,
//			  	Randy Truong,
//			  	Omar Torres,
//			  	Hector Dominguez,
//			  	Kevin Mitton;
//===========================================================

module NES_FPGA(

	CLOCK_50, CLOCK2_50, CLOCK3_50, 						 // Clocks
	LEDG,LEDR, 						  					   	 // LEDs
	KEY, SW,								  				   	 // Switches/Buttons
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,  // 7-Segment
	LCD_DATA, LCD_EN, LCD_ON, LCD_RS, LCD_RW,        // LCD
	SD_CLK, SD_CMD, SD_DAT, SD_WP_N,						 // SD Card
	VGA_B,  VGA_BLANK_N, VGA_CLK, VGA_G, 				 // VGA
	VGA_HS, VGA_R, VGA_SYNC_N, VGA_VS,  
	DRAM_ADDR, DRAM_BA, DRAM_CAS_N, DRAM_CKE,        // SDRAM
	DRAM_CLK, DRAM_CS_N, DRAM_DQ, DRAM_DQM, 
	DRAM_RAS_N, DRAM_WE_N,
	GPIO,															 // GPIO
	FAN_CTRL 
);

//=======================================================
//  PORT declarations
//=======================================================

input         CLOCK_50, 
              CLOCK2_50, CLOCK3_50;    // Clocks
output [8:0]  LEDG;							// LEDs
output [17:0] LEDR;
input  [3:0]  KEY;						   // Keys/Buttons
input  [17:0] SW;
output [6:0]  HEX0, HEX1, HEX2,	      // 7-Segment
		 		  HEX3, HEX4, HEX5,
				  HEX6, HEX7;
inout  [7:0]  LCD_DATA;					   // LCD
output        LCD_EN, LCD_ON, 
				  LCD_RS, LCD_RW;
output        SD_CLK;                  // SD Card
inout         SD_CMD;
inout  [3:0]  SD_DAT;
input         SD_WP_N;
output [7:0]  VGA_B, VGA_G, VGA_R;     // VGA
output        VGA_BLANK_N, VGA_CLK, 
              VGA_HS, VGA_SYNC_N,  
				  VGA_VS;
output [12:0] DRAM_ADDR;			      // SDRAM
output [1:0]  DRAM_BA;
output        DRAM_CAS_N, DRAM_CKE,
              DRAM_CLK, DRAM_CS_N, 
				  DRAM_RAS_N, DRAM_WE_N;
inout  [31:0] DRAM_DQ;
output [3:0]  DRAM_DQM;
inout  [35:0] GPIO;				         // GPIO
inout    	  FAN_CTRL;

//=======================================================
//  PARAMETER declarations
//=======================================================

// N/A

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [11:0] controller1_w;	  // SNES Controller 1 Buttons



//=======================================================
//  Structural coding
//=======================================================
assign LEDR[11:0] = controller1_w;
assign FAN_CTRL = 1'bz;





/* Player A and B controllers */
snes_controller  CONTROLLER1(
	.LATCH( GPIO[0] ),		// GPIO[x]
	.DATA(  GPIO[1] ),			// GPIO[x]
	.PULSE( GPIO[2] ),      // GPIO[x]
	.CLOCK( CLOCK_50 ),		// eg. CLOCK_50 (50MHz)
	.BUTTONS( controller1_w )     // Array of buttons
);


endmodule
