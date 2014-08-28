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
 * This module scales down the frame size of video streams for the DE boards. *
 *                                                                            *
 ******************************************************************************/

module altera_up_video_scaler_shrink (
	// Inputs
	clk,
	reset,

	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_valid,

	stream_out_ready,
	
	// Bidirectional

	// Outputs
	stream_in_ready,


	stream_out_data,
	stream_out_startofpacket,
	stream_out_endofpacket,
	stream_out_valid
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/

parameter DW					=  15; // Image's Data Width
parameter WW					=   9; // Image In: width's address width
parameter HW					=   9; // Image In: height's address width

parameter WIDTH_IN			= 640; // Image In's width in pixels

parameter WIDTH_DROP_MASK	= 4'b0101;
parameter HEIGHT_DROP_MASK	= 4'b0000;

/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input						clk;
input						reset;

input			[DW: 0]	stream_in_data;
input						stream_in_startofpacket;
input						stream_in_endofpacket;
input						stream_in_valid;

input						stream_out_ready;

// Bidirectional

// Outputs
output					stream_in_ready;

output reg	[DW: 0]	stream_out_data;
output reg				stream_out_startofpacket;
output reg				stream_out_endofpacket;
output reg				stream_out_valid;

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/


/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire 						drop;

wire						capture_inputs;

wire						transfer_data;

// Internal Registers
reg						saved_startofpacket;

reg			[DW: 0]	data;
reg						startofpacket;
reg						endofpacket;
reg						valid;

reg			[WW: 0]	width_counter;
reg			[HW: 0]	height_counter;
reg			[ 3: 0]	drop_pixel;
reg			[ 3: 0]	drop_line;

// State Machine Registers

// Integers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

// Output Registers
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data				<=  'h0;
		stream_out_startofpacket	<= 1'b0;
		stream_out_endofpacket		<= 1'b0;
		stream_out_valid				<= 1'b0;
	end
	else if (transfer_data)
	begin
		stream_out_data				<= data;
		stream_out_startofpacket	<= startofpacket;
		stream_out_endofpacket		<= endofpacket;
		stream_out_valid				<= valid;
	end
	else if (stream_out_ready & stream_out_valid)
	begin
		stream_out_data				<=  'h0;
		stream_out_startofpacket	<= 1'b0;
		stream_out_endofpacket		<= 1'b0;
		stream_out_valid				<= 1'b0;
	end
end

// Internal Registers
always @(posedge clk)
	if (reset)
		saved_startofpacket	<= 1'b0;
	else if (capture_inputs)
		saved_startofpacket	<= 1'b0;
	else if (stream_in_ready)
		saved_startofpacket	<= saved_startofpacket | stream_in_startofpacket;
		
always @(posedge clk)
begin
	if (reset)
	begin
		data				<=  'h0;
		startofpacket	<= 1'b0;
		endofpacket		<= 1'b0;
		valid				<= 1'b0;
	end
	else if (capture_inputs)
	begin
		data				<= stream_in_data;
		startofpacket	<= stream_in_startofpacket | saved_startofpacket;
		endofpacket		<= stream_in_endofpacket;
		valid				<= stream_in_valid;
	end
	else if (stream_in_ready)
		endofpacket		<= endofpacket | stream_in_endofpacket;
end

always @(posedge clk)
begin
	if (reset)
		width_counter		<= 'h0;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket | (width_counter == (WIDTH_IN - 1)))
			width_counter	<= 'h0;
		else
			width_counter	<= width_counter + 1;
	end
end

always @(posedge clk)
begin
	if (reset)
		height_counter		<= 'h0;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket)
			height_counter	<= 'h0;
		else if (width_counter == (WIDTH_IN - 1))
			height_counter	<= height_counter + 1;
	end
end

always @(posedge clk)
begin
	if (reset)
		drop_pixel		<= 4'b0000;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket)
			drop_pixel	<= WIDTH_DROP_MASK;
		else if (width_counter == (WIDTH_IN - 1))
			drop_pixel	<= WIDTH_DROP_MASK;
		else
			drop_pixel	<= {drop_pixel[2:0], drop_pixel[3]};		
	end
end

always @(posedge clk)
begin
	if (reset)
		drop_line		<= 4'b0000;
	else if (stream_in_ready)
	begin
		if (stream_in_startofpacket)
			drop_line	<= HEIGHT_DROP_MASK;
		else if (width_counter == (WIDTH_IN - 1))
			drop_line	<= {drop_line[2:0], drop_line[3]};
	end
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

// Output Assignments
assign stream_in_ready	= stream_in_valid & (drop | ~valid | transfer_data);

// Internal Assignments
assign drop					= drop_pixel[0] | drop_line[0];

assign capture_inputs	= stream_in_ready & ~drop;

assign transfer_data		= ~stream_out_valid & stream_in_valid & ~drop;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

