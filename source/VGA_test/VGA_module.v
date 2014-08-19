/*
module VGA_module(
	clk, 
	origin_HS, 
	origin_VS, 
	R_out, 
	G_out, 
	B_out,
	origin_blank
);

input clk;
output origin_HS;
output origin_VS;
output reg [7:0] R_out;
output reg [7:0] G_out;
output reg [7:0] B_out;
output origin_blank;

wire cBLANK_n;
wire cHS;
wire cVS;

hvsync_generator syncing(
	.clk(clk), 
	.hsync_out(cHS), 
	.vsync_out(cVS), 
	.blank_n(cBLANK_n)
);


always@(negedge clk)
begin
	R_out <= 8'b11111100;
	G_out <= 0;
	B_out <= 0;
end

//assign R_out = 8'b11111100;
//assign G_out = 0;
//assign B_out = 0;

reg [4:0] delay_bus;
reg [4:0] delay_busv;
reg [4:0] delay_bush;

always@(negedge clk)
begin
	delay_bus <= {delay_bus[3:0],cBLANK_n};
	delay_bush <= {delay_bush[3:0],cHS};
	delay_busv <= {delay_busv[3:0],cVS};
end

assign origin_blank = delay_bus[1];
assign origin_HS = delay_bush[1];
assign origin_VS = delay_busv[1];

endmodule
*/

/*
module VGA_module(
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data);
input iVGA_CLK;
output oBLANK_n;
output oHS;
output oVS;
output reg [7:0] b_data;
output reg [7:0] g_data;  
output reg [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS;
////
hvsync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));

always@(posedge VGA_CLK_n)
begin

			b_data <= 0;
			g_data <= 0;
			r_data <= 8'b11110000;
		
end

//assign b_data = bgr_data[23:16];
//assign g_data = bgr_data[15:8];
//assign r_data = bgr_data[7:0];
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
//always@(negedge iVGA_CLK)
//begin
//  oHS<=cHS;
//  oVS<=cVS;
////  oBLANK_n<=cBLANK_n;
//end

reg [4:0] delay_bus;
reg [4:0] delay_busv;
reg [4:0] delay_bush;

always@(posedge VGA_CLK_n)

		begin
			delay_bus <= {delay_bus[3:0],cBLANK_n};
			delay_bush <= {delay_bush[3:0],cHS};
			delay_busv <= {delay_busv[3:0],cVS};
end

assign oBLANK_n = delay_bus[1];
assign oHS = delay_bush[1];
assign oVS = delay_busv[1];

endmodule
 	
*/

module VGA_module
    (
        CLOCK_50,
        VGA_RED,
        VGA_GREEN,
        VGA_BLUE,
        VGA_HS,
        VGA_VS
    );
    input CLOCK_50;
    output reg [7:0] VGA_RED;
    output reg [7:0] VGA_GREEN;
    output reg [7:0] VGA_BLUE;
    output VGA_HS;
    output VGA_VS;

    /* Internal registers for horizontal signal timing */
    reg [10:0] hor_reg;
    reg hor_sync;
    wire hor_max = (hor_reg == 1039);

    /* Internal registers for vertical signal timing */
    reg [9:0] ver_reg;
    reg ver_sync;
    wire ver_max = (ver_reg == 665);

    // Code
	 /* Running through line */
	always @ (posedge CLOCK_50) begin

		 if (hor_max) begin
			  hor_reg <= 0;

			  /* Running through frame */
			  if (ver_max)
					ver_reg <= 0;
			  else
			  ver_reg <= ver_reg + 1;

		 end else
			  hor_reg <= hor_reg + 1;

	end
	
	always @ (posedge CLOCK_50) begin

    /* Generating the horizontal sync signal */
    if (hor_reg == 856)
        hor_sync <= 1;
    else if (hor_reg == 976)
        hor_sync <= 0;

    /* Generating the vertical sync signal */
    if (ver_reg == 637)
        ver_sync <= 1;
    else if (ver_reg == 643)
        ver_sync <= 0;

end

assign VGA_HS = ~hor_sync;
assign VGA_VS = ~ver_sync;

always @ (posedge CLOCK_50) begin
	VGA_RED = (!hor_reg[0] && !ver_reg[0] && ver_reg < 600 && hor_reg < 800);
	VGA_GREEN = (!hor_reg[1] && !ver_reg[1] && ver_reg < 600 && hor_reg < 800);
	VGA_BLUE = (!hor_reg[2] && !ver_reg[2] && ver_reg < 600 && hor_reg < 800);
end

endmodule















