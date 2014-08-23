/* Module: vga640x480
   Displays resolution mode on screen. */
module vga640x480(
	CLK,
	CLR,
	HSYNC,
	VSYNC,
	HC,
	VC,
	VIDON
);

input CLK;  // Clock
input CLR;  // Clear

output HSYNC; // Horizontal Sync
output VSYNC; // Vertical Sync

output [9:0] HC; // Horizontal Counter
output [9:0] VC; // Vertical Counter

output VIDON;

localparam hpixels = 800 /*10'b1100100000*/, // Pixels in horizontal line = 800
		      vlines = 521 /*10'b1000001001*/, // Horizontal lines = 521
			      hbp = 144 /*10'b1100010000*/, // Horizontal Back Porch = 144 (128+16)
			      hfp = 784 /*10'b1100010000*/, // Horizontal Front Porch = 784 (128+16+640)
			   
			      vbp = 31  /*10'b0000011111*/, // Vertical Back Porch = 31 (2+29)
			      vfp = 511 /*10'b0111111111*/; // Vertical Front Porch = 511 (2+29+480)
			   
reg [9:0] HCS, VCS; // Horizontal and Vertical counters
reg VSenable;		// Enable for Vertical counter


assign HC    = HCS;
assign VC    = VCS;
assign HSYNC = (HCS < 128) ? 1'b0 : 1'b1; // HS Pulse is low for HCS from 0-127
assign VSYNC = (VCS < 2)   ? 1'b0 : 1'b1; // VS Pulse is low for VCS from 0-1
assign VIDON = (((HCS < hfp) && (HCS >= hbp)) && ((VCS < vfp) && (VCS >= vbp))) ? 1 : 0;


// Counter for the horizontal sync signal
always @ (posedge CLK)
begin
	/*if(CLR == 1'b1)
		HCS <= 10'b0000000000;
	else */
	if(CLK == 1'b1) 
	begin
		if(HCS < (hpixels - 1'b1) )
		begin
			HCS <= HCS + 1'b1;
			VSenable <= 1'b0;  // Leave VSenable off
		end
		else
		begin	
			// Counter reached end of the pixel count
			HCS <= 10'b0000000000; // Reset counter, then,
			VSenable <= 1'b1; 	  // Enable vertical counter
		end	
	end
end



// Counter for the vertical sync signal
always @ (posedge CLK)
begin
	/*if(CLR == 1'b1)
		VCS <= 10'b0000000000;
	else */if(CLK == 1'b1 && VSenable == 1'b1)
	begin
		// Increment when enabled
		if( VCS < (vlines - 1'b1) )
		begin
			VCS <= VCS + 1'b1; // Increment vertical counter
		end
		else
		begin
			VCS <= 10'b0000000000; 
		end
	end
end

endmodule

