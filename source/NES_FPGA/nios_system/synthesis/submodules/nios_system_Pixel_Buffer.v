/******************************************************************************
 * License Agreement                                                          *
 *                                                                            *
 * Copyright (c) 1991-2012 Altera Corporation, San Jose, California, USA.     *
 * All rights reserved.                                                       *
 *                                                                            *
 * Any megafunction design, and related net list (encrypted or decrypted),    *
 *  support information, device programming or simulation file, and any other *
 *  associated documentation or information provided by Altera or a partner   *
 *  under Altera's Megafunction Partnership Program may be used only to       *
 *  program PLD devices (but not masked PLD devices) from Altera.  Any other  *
 *  use of such megafunction design, net list, support information, device    *
 *  programming or simulation file, or any other related documentation or     *
 *  information is prohibited for any other purpose, including, but not       *
 *  limited to modification, reverse engineering, de-compiling, or use with   *
 *  any other silicon devices, unless such use is explicitly licensed under   *
 *  a separate agreement with Altera or a megafunction partner.  Title to     *
 *  the intellectual property, including patents, copyrights, trademarks,     *
 *  trade secrets, or maskworks, embodied in any such megafunction design,    *
 *  net list, support information, device programming or simulation file, or  *
 *  any other related documentation or information provided by Altera or a    *
 *  megafunction partner, remains with Altera, the megafunction partner, or   *
 *  their respective licensors.  No other licenses, including any licenses    *
 *  needed under any third party's intellectual property, are provided herein.*
 *  Copying or modifying any file, or portion thereof, to which this notice   *
 *  is attached violates this copyright.                                      *
 *                                                                            *
 * THIS FILE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    *
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   *
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    *
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    *
 * FROM, OUT OF OR IN CONNECTION WITH THIS FILE OR THE USE OR OTHER DEALINGS  *
 * IN THIS FILE.                                                              *
 *                                                                            *
 * This agreement shall be governed in all respects by the laws of the State  *
 *  of California and by the laws of the United States of America.            *
 *                                                                            *
 ******************************************************************************/

/******************************************************************************
 *                                                                            *
 * This module reads and writes to the ssram chip on the DE2-70 board,        *
 *  with 4-cycle read latency and one cycle write latency.                    *
 *                                                                            *
 ******************************************************************************/


module nios_system_Pixel_Buffer (
	// Inputs
	clk,
	reset,

	address,
	byteenable,
	read,
	write,
	writedata,

	// Bi-Directional
	SRAM_DQ,
	SRAM_DPA,

	// Outputs
	readdata,
	readdatavalid,
	waitrequest,

	SRAM_CLK,
	SRAM_ADDR,
	SRAM_ADSC_N,
	SRAM_ADSP_N,
	SRAM_ADV_N,
	SRAM_BE_N,
	SRAM_CE1_N,
	SRAM_CE2,
	SRAM_CE3_N,
	SRAM_GW_N,
	SRAM_OE_N,
	SRAM_WE_N	
);


/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input						clk;
input						reset;

input			[18: 0]	address;
input			[ 3: 0]	byteenable;
input						read;
input						write;
input			[31: 0]	writedata;

// Bi-Directional
inout			[31: 0]	SRAM_DQ;		//	SRAM Data Bus 32 Bits
inout			[ 3: 0]	SRAM_DPA; 		//  SRAM Parity Data Bus

// Outputs
output reg	[31: 0]	readdata;
output					readdatavalid;
output					waitrequest;

output					SRAM_CLK;		//	SRAM Clock
output reg	[18: 0]	SRAM_ADDR;		//	SRAM Address bus 21 Bits
output reg				SRAM_ADSC_N;	//	SRAM Controller Address Status 	
output reg				SRAM_ADSP_N;	//	SRAM Processor Address Status
output reg				SRAM_ADV_N;		//	SRAM Burst Address Advance
output reg	[ 3: 0]	SRAM_BE_N;		//	SRAM Byte Write Enable
output reg				SRAM_CE1_N;		//	SRAM Chip Enable
output reg				SRAM_CE2;		//	SRAM Chip Enable
output reg				SRAM_CE3_N;		//	SRAM Chip Enable
output reg				SRAM_GW_N;		//  SRAM Global Write Enable
output reg				SRAM_OE_N;		//	SRAM Output Enable
output reg				SRAM_WE_N;		//	SRAM Write Enable

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/


/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire			[ 3: 0]	internal_byteenable;
wire						start_write;

// Internal Registers
reg			[ 3: 0]	read_pipeline;
reg			[ 3: 0]	byteenable_reg;
reg			[31: 0]	writedata_reg;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

// Output Registers
always @(posedge clk)
begin
	readdata				<= SRAM_DQ;

	SRAM_ADDR			<= address;
	SRAM_ADSP_N			<= 1'b1;
	SRAM_ADSC_N			<= ~(read | start_write);
	SRAM_ADV_N			<= 1'b1;
	SRAM_BE_N[3]		<= ~internal_byteenable[3];
	SRAM_BE_N[2]		<= ~internal_byteenable[2];
	SRAM_BE_N[1]		<= ~internal_byteenable[1];
	SRAM_BE_N[0]		<= ~internal_byteenable[0];
	SRAM_CE1_N			<= ~(read | start_write);
	SRAM_CE2				<= (read | start_write);
	SRAM_CE3_N			<= ~(read | start_write);
	SRAM_GW_N			<= 1'b1;
	SRAM_OE_N			<= ~(read_pipeline[1]);
	SRAM_WE_N			<= ~start_write;
end

// Internal Registers
always @(posedge clk)
begin
	if (reset)
		read_pipeline	<= 4'h0;
	else
		read_pipeline	<= {read_pipeline[2:0], read};
end

always @(posedge clk)
begin
	if (reset)
		byteenable_reg	<= 4'h0;
	else
		byteenable_reg	<= internal_byteenable;
end

always @(posedge clk)
begin
	writedata_reg		<= writedata;
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

// Output Assignments
assign readdatavalid	= read_pipeline[3];
assign waitrequest		= write & (|(read_pipeline[2:0]));

assign SRAM_DQ[31:24]	= (internal_byteenable[3]) ? writedata_reg[31:24] : 8'hzz;
assign SRAM_DQ[23:16]	= (internal_byteenable[2]) ? writedata_reg[23:16] : 8'hzz;
assign SRAM_DQ[15: 8]	= (internal_byteenable[1]) ? writedata_reg[15: 8] : 8'hzz;
assign SRAM_DQ[ 7: 0]	= (internal_byteenable[0]) ? writedata_reg[ 7: 0] : 8'hzz;

assign SRAM_DPA			= 4'hz;

assign SRAM_CLK			= clk;

// Internal Assignments
assign internal_byteenable[3]	= byteenable[3] & start_write;
assign internal_byteenable[2]	= byteenable[2] & start_write;
assign internal_byteenable[1]	= byteenable[1] & start_write;
assign internal_byteenable[0]	= byteenable[0] & start_write;

assign start_write				= write & ~(|(read_pipeline[2:0]));

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

