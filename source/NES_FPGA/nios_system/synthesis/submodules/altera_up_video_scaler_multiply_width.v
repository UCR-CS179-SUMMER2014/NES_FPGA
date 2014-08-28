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
 * This module replicates pixels in video data to enlarge the image.          *
 *                                                                            *
 ******************************************************************************/

module altera_up_video_scaler_multiply_width (
	// Inputs
	clk,
	reset,

	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_valid,

	stream_out_ready,

	// Bi-Directional

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

parameter DW	=  15; // Image's data width

parameter CW	=   0; // Multiply width's counter width

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

// Bi-Directional

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

// Internal Registers
reg			[DW: 0]	data;
reg						startofpacket;
reg						endofpacket;
reg						valid;

reg			[CW: 0]	enlarge_width_counter;

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
	if (reset)
	begin
		stream_out_data					<=  'h0;
		stream_out_startofpacket		<= 1'b0;
		stream_out_endofpacket			<= 1'b0;
		stream_out_valid					<= 1'b0;
	end
	else if (stream_out_ready | ~stream_out_valid)
	begin
		stream_out_data					<= data;

		if (|(enlarge_width_counter))
			stream_out_startofpacket	<= 1'b0;
		else
			stream_out_startofpacket	<= startofpacket;

		if (&(enlarge_width_counter))
			stream_out_endofpacket		<= endofpacket;
		else
			stream_out_endofpacket		<= 1'b0;

		stream_out_valid					<= valid;
	end
end

// Internal Registers
always @(posedge clk)
begin
	if (reset)
	begin
		data									<=  'h0;
		startofpacket						<= 1'b0;
		endofpacket							<= 1'b0;
		valid									<= 1'b0;
	end
	else if (stream_in_ready)
	begin
		data									<= stream_in_data;
		startofpacket						<= stream_in_startofpacket;
		endofpacket							<= stream_in_endofpacket;
		valid									<= stream_in_valid;
	end
end

always @(posedge clk)
begin
	if (reset)
		enlarge_width_counter <= 'h0;
	else if ((stream_out_ready | ~stream_out_valid) & valid)
		enlarge_width_counter <= enlarge_width_counter + 1;
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

// Output assignments
assign stream_in_ready	= (~valid) | 
	((&(enlarge_width_counter)) & (stream_out_ready | ~stream_out_valid));

// Internal assignments
		
/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

