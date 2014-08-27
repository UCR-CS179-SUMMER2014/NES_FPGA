//===========================================================
// UCR's CS179J Nintendo Entertainment System - FPGA Emulator
// ----------------------------------------------------------
//       _        __   _____    ______         _______
//      / \      / /  / ___/  /  ____/        |   ____|
//     /   \    / /  / /__    \  \      ___   |  |___
//		/ / \ \  / /  / ___/     \  \    |___|  |   ___|
//   / /   \ \/ /  / /___   ____\  \          |  |
//	 /_/     \__/  /_____/  /_______/          |__|
// ----------------------------------------------------------
//	Date:    August 28, 2014
// Authors: Sergio Morales,
//				Randy Truong,
//				Omar Torres,
//				Hector Dominguez,
//				Kevin Mitton;
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
/* SNES Controllers */
wire [11:0] controller1_w;	  // SNES Controller 1 Buttons

/* VGA Wires */
wire       pclock_w;  // Pixel Clock [25Mhz for 640x480 res]
wire       vidon_w;   // Data enable for RGB (when high)
wire [9:0] hc_w;		 // Horizontal Counter (AKA X position)
wire [9:0] vc_w;      // Vertical Counter (AKA Y Position)

wire [3:0] addr_w;
wire [15:0] M_w;

/* NIOS I/O Ports */
reg [7:0] input_one, output_one;

//=======================================================
//  Wire/Port assignments
//=======================================================
assign LEDR[11:0] = controller1_w;
assign FAN_CTRL = 1'bz;

assign LEDG = output_one;


/* VGA Assignments */
assign VGA_BLANK_N = 1; // VGA reset? Disable.
assign VGA_SYNC_N = 0;  // Not sure what this is, keep active though.
assign VGA_CLK = pclock_w;



//=======================================================
//  Structural coding
//=======================================================

always @ *
begin
	input_one = SW;
end
/* 
	Video Display (VGA) 
	-------------------
*/
pixel_clock PCLOCK(		  // Altera PLL 
	.inclk0( CLOCK_50 ),   // 50Mhz input
	.c0( pclock_w)	        // Outputs 25Mhz clock
);

vga640x480 VGA(       // 640x480 signal generator
	.CLK( pclock_w ),  // Pixel Clock
	.CLR( ~KEY[0] ),   // Clear, aka Reset
	.HSYNC( VGA_HS ),  // Horizontal Sync
	.VSYNC( VGA_VS ),  // Vertical Sync
	.HC( hc_w ),       // Horizontal Counter/Position
	.VC( vc_w ),       // Vertical Counter/Position
	.VIDON( vidon_w )  // VIDON enable signal
);

prom_DMH CHAR_ROM(		// Grabs an 8x8 sprite
	.addr(addr_w),
	.M(M_w)
);

vga_text  VGA_TEXT_DISP (	// Displays text on VGA
	.vidon( vidon_w ),
	.hc( hc_w ),
	.vc( vc_w),
	.M( M_w ),        	// The byte from the sprite to be sent
	.SW( SW[7:0] ),		// Sets the starting x,y position of sprite
	.rom_addr( addr_w ),
	.R( VGA_R ),
	.G( VGA_G ),
	.B( VGA_B )
);
//color_gen  IMG_GEN(    // Display generator. Display THIS or VGA_TEXT_DISP. Comment one out.
//	.VIDON( vidon_w ),  // VIDON enable signa;
//	.HC( hc_w ),        // Horizontal Counter/Position
//	.VC( vc_w ),        // Vertical Counter/Position
//	.R( VGA_R ),        // Red data
//	.G( VGA_G ),        // Green data
//	.B( VGA_B )         // Blue data
//);



/* 
	Player A and B controllers 
	--------------------------
*/
snes_controller  CONTROLLER1(
	.LATCH( GPIO[0] ),		// GPIO[x]
	.DATA(  GPIO[1] ),			// GPIO[x]
	.PULSE( GPIO[2] ),      // GPIO[x]
	.CLOCK( CLOCK_50 ),		// eg. CLOCK_50 (50MHz)
	.BUTTONS( controller1_w )     // Array of buttons
);


/*
	NIOS System
	-----------
*/
nios_system NIOS(
	.b_SD_cmd_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0  (SD_CMD),			// SD Card
	.b_SD_dat3_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0 (SD_DAT[3]),
	.b_SD_dat_to_and_from_the_Altera_UP_SD_Card_Avalon_Interface_0  (SD_DAT[0]),
	.clk_0                                                          (CLOCK_50),      // CLOCK
	.clocks_SDRAM_CLK_out                                           (DRAM_CLK),      
	.clocks_sys_clk_out                                             (),  // Unused
	.in_port_to_the_input1                                          (input_one),     // I/O IN
	.o_SD_clock_from_the_Altera_UP_SD_Card_Avalon_Interface_0       (SD_CLK),
	.out_port_from_the_output1                                      (output_one),    // I/O OUT
	.reset_n                                                        (1),
	.zs_addr_from_the_sdram_0                                       (DRAM_ADDR),     // DRAM
	.zs_ba_from_the_sdram_0                                         (DRAM_BA),
	.zs_cas_n_from_the_sdram_0                                      (DRAM_CAS_N),
	.zs_cke_from_the_sdram_0                                        (DRAM_CKE),
	.zs_cs_n_from_the_sdram_0                                       (DRAM_CS_N),
	.zs_dq_to_and_from_the_sdram_0                                  (DRAM_DQ),
	.zs_dqm_from_the_sdram_0                                        (DRAM_DQM),
	.zs_ras_n_from_the_sdram_0                                      (DRAM_RAS_N),
	.zs_we_n_from_the_sdram_0                                       (DRAM_WE_N)
 );


endmodule
