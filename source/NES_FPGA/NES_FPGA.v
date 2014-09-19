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
	SSRAM_ADSC_N, SSRAM_ADSP_N, SSRAM_ADV_N,			 // SSRAM
	SSRAM_BE, SSRAM_CLK, SSRAM_GW_N, SSRAM_OE_N,
	SSRAM_WE_N, SSRAM0_CE_N, SSRAM1_CE_N,
	FL_CE_N, FL_OE_N, FL_RESET_N, FL_RY, 				 // FLASH
	FL_WE_N, FL_WP_N,
	FS_ADDR, FS_DQ,											 // Flash/SSRAM Shared
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
output		  SSRAM_ADSC_N, 				// SSRAM
              SSRAM_ADSP_N,
        		  SSRAM_ADV_N; 
output [3:0]  SSRAM_BE;
output		  SSRAM_CLK, SSRAM_GW_N,
   		     SSRAM_OE_N, SSRAM_WE_N,
  		        SSRAM0_CE_N,
				  SSRAM1_CE_N;	
output		  FL_CE_N, FL_OE_N,			// Flash
   		     FL_RESET_N, FL_RY,
				  FL_WE_N, FL_WP_N;
output [26:1] FS_ADDR;						// SSRAM/Flash
inout  [31:0] FS_DQ;

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
assign FAN_CTRL = 1'b1;

assign LEDG = output_one;


/* VGA Assignments */
//assign VGA_BLANK_N = 1; // VGA reset? Disable.
//assign VGA_SYNC_N = 0;  // Not sure what this is, keep active though.
//assign VGA_CLK = pclock_w;



//=======================================================
//  Structural coding
//=======================================================

/*
	Video Display (VGA) 
	-------------------
*/
//pixel_clock PCLOCK(		  // Altera PLL 
//	.inclk0( CLOCK_50 ),   // 50Mhz input
//	.c0( pclock_w)	        // Outputs 25Mhz clock. Goes to NIOS System
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

 nios_system u0 (
	 
	  .SRAM_DQ_to_and_from_the_Pixel_Buffer                        (FS_DQ),                        //                  Pixel_Buffer_external_interface.DQ
	  .Pixel_Buffer_external_interface_DPA                         (),                         //                                                 .DPA
	  .SRAM_ADDR_from_the_Pixel_Buffer                             (FS_ADDR),                             //                                                 .ADDR
	  .Pixel_Buffer_external_interface_ADSC_N                      (SSRAM_ADSC_N),                      //                                                 .ADSC_N
	  .Pixel_Buffer_external_interface_ADSP_N                      (SSRAM_ADSP_N),                      //                                                 .ADSP_N
	  .Pixel_Buffer_external_interface_ADV_N                       (SSRAM_ADV_N),                       //                                                 .ADV_N
	  .Pixel_Buffer_external_interface_BE_N                        (SSRAM_BE),                        //                                                 .BE_N
	  .Pixel_Buffer_external_interface_CE1_N                       (SSRAM0_CE_N),                       //                                                 .CE1_N
	  .Pixel_Buffer_external_interface_CE2                         (),                         //                                                 .CE2
	  .Pixel_Buffer_external_interface_CE3_N                       (SSRAM1_CE_N),                       //                                                 .CE3_N
	  .Pixel_Buffer_external_interface_GW_N                        (SSRAM_GW_N),                        //                                                 .GW_N
	  .SRAM_OE_N_from_the_Pixel_Buffer                             (SSRAM_OE_N),                             //                                                 .OE_N
	  .SRAM_WE_N_from_the_Pixel_Buffer                             (SSRAM_WE_N),                             //                                                 .WE_N
	  .Pixel_Buffer_external_interface_CLK                         (SSRAM_CLK),                         //                                                 .CLK
  
	  .VGA_CLK_from_the_VGA_Controller                             (VGA_CLK),                             //                VGA_Controller_external_interface.CLK
	  .VGA_HS_from_the_VGA_Controller                              (VGA_HS),                              //                                                 .HS
	  .VGA_VS_from_the_VGA_Controller                              (VGA_VS),                              //                                                 .VS
	  .VGA_BLANK_from_the_VGA_Controller                           (VGA_BLANK_N),                           //                                                 .BLANK
	  .VGA_SYNC_from_the_VGA_Controller                            (VGA_SYNC_N),                            //                                                 .SYNC
	  .VGA_R_from_the_VGA_Controller                               (VGA_R),                               //                                                 .R
	  .VGA_G_from_the_VGA_Controller                               (VGA_G),                               //                                                 .G
	  .VGA_B_from_the_VGA_Controller                               (VGA_B),                               //                                                 .B
	  .clk_0                                                       (CLOCK_50),                                                       //                                     clk_0_clk_in.clk
	  .reset_n                                                     (KEY[0]),                                                     //                               clk_0_clk_in_reset.reset_n
	  .sdram_0_wire_addr                                           (DRAM_ADDR),                                           //                                     sdram_0_wire.addr
	  .sdram_0_wire_ba                                             (DRAM_BA),                                             //                                                 .ba
	  .sdram_0_wire_cas_n                                          (DRAM_CAS_N),                                          //                                                 .cas_n
	  .sdram_0_wire_cke                                            (DRAM_CKE),                                            //                                                 .cke
	  .sdram_0_wire_cs_n                                           (DRAM_CS_N),                                           //                                                 .cs_n
	  .sdram_0_wire_dq                                             (DRAM_DQ),                                             //                                                 .dq
	  .sdram_0_wire_dqm                                            (DRAM_DQM),                                            //                                                 .dqm
	  .sdram_0_wire_ras_n                                          (DRAM_RAS_N),                                          //                                                 .ras_n
	  .sdram_0_wire_we_n                                           (DRAM_WE_N),                                           //                                                 .we_n
	  .altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd   (SD_CMD),   // altera_up_sd_card_avalon_interface_0_conduit_end.b_SD_cmd
	  .altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat   (SD_DAT[0]),   //                                                 .b_SD_dat
	  .altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3  (SD_DAT[3]),  //                                                 .b_SD_dat3
	  .altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock (SD_CLK), //                                                 .o_SD_clock
     .clock_signals_sdram_clk_clk                                 (DRAM_CLK)
	  );
endmodule
