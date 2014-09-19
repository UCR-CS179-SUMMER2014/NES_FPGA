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
 * This module contains counter for the width and height of frames for the    *
 *   video clipper core.                                                      *
 *                                                                            *
 ******************************************************************************/

module altera_up_video_clipper_counters (
	// Inputs
	clk,
	reset,

	increment_counters,

	// Bi-Directional

	// Outputs
	start_of_outer_frame,
	end_of_outer_frame,

	start_of_inner_frame,
	end_of_inner_frame,
	inner_frame_valid
);


/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/

parameter IMAGE_WIDTH	= 640; // Final image width in pixels
parameter IMAGE_HEIGHT	= 480; // Final image height in lines
parameter WW				=   9; // Final image width address width
parameter HW				=   8; // Final image height address width

parameter LEFT_OFFSET	=   0;
parameter RIGHT_OFFSET	=   0;
parameter TOP_OFFSET		=   0;
parameter BOTTOM_OFFSET	=   0;

/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/

// Inputs
input						clk;
input						reset;

input						increment_counters;

// Bi-Directional

// Outputs
output					start_of_outer_frame;
output					end_of_outer_frame;

output					start_of_inner_frame;
output					end_of_inner_frame;
output					inner_frame_valid;

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/


/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires

// Internal Registers
reg			[WW: 0]	width;
reg			[HW: 0]	height;

reg						inner_width_valid;
reg						inner_height_valid;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

// Output registers

// Internal registers
always @(posedge clk)
begin
	if (reset)
		width <= 'h0;
	else if (increment_counters & (width == (IMAGE_WIDTH - 1)))
		width <= 'h0;
	else if (increment_counters)
		width <= width + 1;	
end
always @(posedge clk)
begin
	if (reset)
		height <= 'h0;
	else if (increment_counters & (width == (IMAGE_WIDTH - 1)))
	begin
		if (height == (IMAGE_HEIGHT - 1))
			height <= 'h0;
		else
			height <= height + 1;
	end
end

always @(posedge clk)
begin
	if (reset)
		inner_width_valid <= (LEFT_OFFSET == 0);
	else if (increment_counters)
	begin
		if (width == (IMAGE_WIDTH - 1))
			inner_width_valid <= (LEFT_OFFSET == 0);
		
		else if (width == (IMAGE_WIDTH - RIGHT_OFFSET - 1))
			inner_width_valid <= 1'b0;
		
		else if (width == (LEFT_OFFSET - 1))
			inner_width_valid <= 1'b1;
	end
end
always @(posedge clk)
begin
	if (reset)
		inner_height_valid <= (TOP_OFFSET == 0);
	else if (increment_counters & (width == (IMAGE_WIDTH - 1)))
	begin
		if (height == (IMAGE_HEIGHT - 1))
			inner_height_valid <= (TOP_OFFSET == 0);
		
		else if (height == (IMAGE_HEIGHT - BOTTOM_OFFSET - 1))
			inner_height_valid <= 1'b0;
		
		else if (height == (TOP_OFFSET - 1))
			inner_height_valid <= 1'b1;
	end
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

// Output assignments
assign start_of_outer_frame	=	(width == 'h0) & (height == 'h0);
assign end_of_outer_frame		=	(width == (IMAGE_WIDTH - 1)) & 
											(height == (IMAGE_HEIGHT - 1));

assign start_of_inner_frame	=	(width == LEFT_OFFSET) & 
											(height == TOP_OFFSET);
assign end_of_inner_frame		=	(width == (IMAGE_WIDTH - RIGHT_OFFSET - 1)) & 
											(height == (IMAGE_HEIGHT - BOTTOM_OFFSET - 1));
assign inner_frame_valid		=	inner_width_valid & inner_height_valid;

// Internal assignments


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule

