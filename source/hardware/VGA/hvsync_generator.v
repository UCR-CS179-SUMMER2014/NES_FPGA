/*module hvsync_generator(clk, vga_h_sync, vga_v_sync, inDisplayArea, CounterX, CounterY);
input clk;
output vga_h_sync, vga_v_sync;
output inDisplayArea;
output [9:0] CounterX;
output [8:0] CounterY;

//////////////////////////////////////////////////
reg [9:0] CounterX;
reg [8:0] CounterY;
wire CounterXmaxed = (CounterX==10'h2FF);

always @(posedge clk)
if(CounterXmaxed)
	CounterX <= 0;
else
	CounterX <= CounterX + 1;

always @(posedge clk)
if(CounterXmaxed) CounterY <= CounterY + 1;

reg	vga_HS, vga_VS;
always @(posedge clk)
begin
	vga_HS <= (CounterX[9:4]==6'h2D); // change this value to move the display horizontally
	vga_VS <= (CounterY==500); // change this value to move the display vertically
end

reg inDisplayArea;
always @(posedge clk)
if(inDisplayArea==0)
	inDisplayArea <= (CounterXmaxed) && (CounterY<480);
else
	inDisplayArea <= !(CounterX==639);
	
assign vga_h_sync = ~vga_HS;
assign vga_v_sync = ~vga_VS;

endmodule*/
/*
module hvsync_generator(clk, vga_h_sync, vga_v_sync, Red, Green, Blue);
//Inputs/Outputs
input clk;
output vga_h_sync;
output vga_v_sync;
output Red;
output Green;
output Blue;

//REGISTERS
reg [9:0] CounterX;
reg [8:0] CounterY;
reg vga_HS;
reg vga_VS;

//Assigning
assign vga_h_sync = ~vga_HS;
assign vga_v_sync = ~vga_VS;
assign Red = 100;
assign Green = 0;
assign Blue = 0;

//assign vga_h_sync = (hc < hpulse) ? 0:1;
//assign vga_h_sync = (vc < vpulse) ? 0:1;

initial begin
	CounterX = 0;
	CounterY = 0;
end

always @(posedge clk)
begin
	if(CounterX == 767) begin
		CounterX <= 0;
		if(CounterY == 510)
			CounterY <= 0;
		else
			CounterY <= CounterY + 1;
	end
	else begin
		CounterX <= CounterX + 1;
	end
end
	 
always @(posedge clk)
begin
  //vga_HS <= (CounterX[9:4]==0);   // active for 16 clocks
  //vga_VS <= (CounterY==0);   // active for 768 clocks
  
	vga_HS = (CounterX < 96) ? 0:1;
	vga_VS = (CounterY < 2) ? 0:1;
end

endmodule*/
/*
module hvsync_generator(
	input wire dclk,			//pixel clock: 25MHz
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [7:0] red,	//red vga output
	output reg [7:0] green, //green vga output
	output reg [7:0] blue	//blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 525; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 16; 	// beginning of horizontal front porch
parameter vbp = 34; 		// end of vertical back porch
parameter vfp = 11; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk)
begin
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin
	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
		// now display different colors every 80 pixels
		// while we're within the active horizontal range
		// -----------------
		// display white bar
		if (hc >= hbp && hc < (hbp+80))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end
		// display yellow bar
		else if (hc >= (hbp+80) && hc < (hbp+160))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b00;
		end
		// display cyan bar
		else if (hc >= (hbp+160) && hc < (hbp+240))
		begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b11;
		end
		// display green bar
		else if (hc >= (hbp+240) && hc < (hbp+320))
		begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b00;
		end
		// display magenta bar
		else if (hc >= (hbp+320) && hc < (hbp+400))
		begin
			red = 3'b111;
			green = 3'b000;
			blue = 2'b11;
		end
		// display red bar
		else if (hc >= (hbp+400) && hc < (hbp+480))
		begin
			red = 3'b111;
			green = 3'b000;
			blue = 2'b00;
		end
		// display blue bar
		else if (hc >= (hbp+480) && hc < (hbp+560))
		begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b11;
		end
		// display black bar
		else if (hc >= (hbp+560) && hc < (hbp+640))
		begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
		end
		// we're outside active horizontal range so display black
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

endmodule

*/

/*****************************************************/
/*
module vsync(line_clk, vsync_out, blank_out);
   input line_clk;
   output vsync_out;
   output blank_out;
   
   reg [10:0] count = 10'b0000000000;
   reg vsync  = 0;
   reg blank  = 0;

   always @(posedge line_clk)
	 if (count < 666)
	   count <= count + 1;
	 else
	   count <= 0;
   
   always @(posedge line_clk)
	 if (count < 600)
	   blank 		<= 0;
	 else
	   blank 		<= 1;
      
   always @(posedge line_clk)
	 begin
		if (count < 637)
		  vsync 	<= 1;
		else if (count >= 637 && count < 643)
		  vsync 	<= 0;
		else if (count >= 643)
		  vsync 	<= 1;
	 end

   assign vsync_out  = vsync;
   assign blank_out  = blank;
   
endmodule // hsync   

module hsync(clk50, hsync_out, blank_out, newline_out);
   input clk50;
   output hsync_out, blank_out, newline_out;
   
   reg [10:0] count = 10'b0000000000;
   reg hsync 	= 0;
   reg blank 	= 0;
   reg newline 	= 0;

   always @(posedge clk50)
	 begin
		if (count < 1040)
		  count  <= count + 1;
		else
		  count  <= 0;
	 end
   
   always @(posedge clk50)
	 begin
		if (count == 0)
		  newline <= 1;
		else
		  newline <= 0;
	 end

   always @(posedge clk50)
	 begin
		if (count >= 800)
		  blank  <= 1;
		else
		  blank  <= 0;
	 end

   always @(posedge clk50)
	 begin
		if (count < 856) // pixel data plus front porch
		  hsync <= 1;
		else if (count >= 856 && count < 976)
		  hsync <= 0;
		else if (count >= 976)
		  hsync <= 1;
	 end // always @ (posedge clk50)
				 
   assign hsync_out    = hsync;
   assign blank_out    = blank;
   assign newline_out  = newline;
   
endmodule // hsync


module color(clk, blank, red_out, green_out, blue_out);
   input clk, blank;
   output red_out, green_out, blue_out;

   reg [8:0] count;
   
   always @(posedge clk)
	 begin
		if (blank)
		  count 	<= 0;
		else
		  count 	<= count + 1;
	 end

   assign red_out 	 = 1;
   assign green_out  = 1;
   assign blue_out 	 = 0;
   
endmodule // color


module hvsync_generator(clk50, hsync_out, vsync_out, red_out, blue_out, green_out);
   input clk50;
   output hsync_out, vsync_out, red_out, blue_out, green_out;
   wire line_clk, blank, hblank, vblank;
   
   hsync   hs(clk50, hsync_out, hblank, line_clk);
   vsync   vs(line_clk, vsync_out, vblank);   
   color   cg(clk50, blank, red_out, green_out, blue_out);

   assign blank 	 = hblank || vblank;

endmodule 

// top
/*
parameter hori_line  = 800;                           
parameter hori_back  = 144;
parameter hori_front = 16;
parameter vert_line  = 525;
parameter vert_back  = 34;
parameter vert_front = 11;
parameter H_sync_cycle = 96;
parameter V_sync_cycle = 2;
*/

/*******************************************************************/


module hvsync_generator(
	clk, 
	hsync_out, 
	vsync_out, 
	blank_n
);

input clk;
output reg hsync_out;
output reg vsync_out;
output reg blank_n;

parameter hori_line  = 800;                           
parameter hori_back  = 144;
parameter hori_front = 16;
parameter vert_line  = 525;
parameter vert_back  = 34;
parameter vert_front = 11;
parameter H_sync_cycle = 96;
parameter V_sync_cycle = 2;

reg [10:0] h_count;
reg [9:0]  v_count;
wire h_display;
wire v_display;
wire blank_wire;
wire hori_blank;
wire vert_blank;

//Assigning variables
assign h_display = (h_count < H_sync_cycle) ? 1'b0 : 1'b1;
assign v_display = (v_count < V_sync_cycle) ? 1'b0 : 1'b1;

assign hori_blank = (h_count < (hori_line - hori_front)&& h_count >= hori_back) ? 1'b1 : 1'b0;
assign vert_blank = (v_count < (vert_line - vert_front)&& v_count >= vert_back) ? 1'b1 : 1'b0;

assign blank_wire = hori_blank && vert_blank;

//Increments left to right of the screen, as it reached the very end of the right of the screen
//Increments the vertical position down 1 until it reaches to the very bottom of the screen
always@(negedge clk)
begin

	//If the horizontal position reaches to the end of the horizontal screen (right of screen)
	if (h_count == (hori_line - 1)) begin 
		//resets the horizontal counter, restarts at the left of screen
		h_count <= 11'd0;
		
		//if the vertical position reaches to the end of the vertical screen (bottom of screen)
		if (v_count == (vert_line - 1))
			//resets the vertical counter, restarts at the top of screen
			v_count<= 10'd0;
			
		//Increment the vertical counter if it has not reached the end of the bottom of the screen
		else
			v_count <= v_count + 1;
	end
	
	//Increment the horizontal counter if it has not reached the end of the right of the screen.
	else 
		h_count <= h_count + 1;
		
end

//Sets the outputs to the wires
always@(negedge clk)
begin
	hsync_out <= h_display;
	vsync_out <= v_display;
	blank_n <= blank_wire;
end

endmodule


/*
module hvsync_generator(
                            vga_clk,
                            blank_n,
                            HS,
                            VS);
                            
input vga_clk;
output reg blank_n;
output reg HS;
output reg VS;
//////////////////

--VGA Timing
--Horizontal :
--                ______________                 _____________
--               |              |               |
--_______________|  VIDEO       |_______________|  VIDEO (next line)

--___________   _____________________   ______________________
--           |_|                     |_|
--            B <-C-><----D----><-E->
--           <------------A--------->
--The Unit used below are pixels;  
--  B->Sync_cycle                   :H_sync_cycle
--  C->Back_porch                   :hori_back
--  D->Visable Area
--  E->Front porch                  :hori_front
--  A->horizontal line total length :hori_line
--Vertical :
--               ______________                 _____________
--              |              |               |          
--______________|  VIDEO       |_______________|  VIDEO (next frame)
--
--__________   _____________________   ______________________
--          |_|                     |_|
--           P <-Q-><----R----><-S->
--          <-----------O---------->
--The Unit used below are horizontal lines;  
--  P->Sync_cycle                   :V_sync_cycle
--  Q->Back_porch                   :vert_back
--  R->Visable Area
--  S->Front porch                  :vert_front
--  O->vertical line total length :vert_line
//////////////////////////////////////////
////////////////////////                          
//parameter
parameter hori_line  = 800;                           
parameter hori_back  = 144;
parameter hori_front = 16;
parameter vert_line  = 525;
parameter vert_back  = 34;
parameter vert_front = 11;
parameter H_sync_cycle = 96;
parameter V_sync_cycle = 2;

//////////////////////////
reg [10:0] h_cnt;
reg [9:0]  v_cnt;
wire cHD,cVD,cDEN,hori_valid,vert_valid;
///////
always@(negedge vga_clk)

    begin
      if (h_cnt==hori_line-1)
      begin 
         h_cnt<=11'd0;
         if (v_cnt==vert_line-1)
            v_cnt<=10'd0;
         else
            v_cnt<=v_cnt+1;
      end
      else
         h_cnt<=h_cnt+1;
end
/////
assign cHD = (h_cnt<H_sync_cycle)?1'b0:1'b1;
assign cVD = (v_cnt<V_sync_cycle)?1'b0:1'b1;

assign hori_valid = (h_cnt<(hori_line-hori_front)&& h_cnt>=hori_back)?1'b1:1'b0;
assign vert_valid = (v_cnt<(vert_line-vert_front)&& v_cnt>=vert_back)?1'b1:1'b0;

assign cDEN = hori_valid && vert_valid;

always@(negedge vga_clk)
begin
  HS<=cHD;
  VS<=cVD;
  blank_n<=cDEN;
end

endmodule

*/











