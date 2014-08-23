/* Module:      vga_stripes
	Description: Generates an "image" on 
					 screen when VIDON is enabled */
module vga_stripes(
	VIDON,
	HC,
	VC,
	R,
	G,
	B,
	SW
	);

// |--------------------|
// | Port Declarations  |
// | -------------------|
input VIDON;
input [9:0] HC;
input [9:0] VC;
output [7:0] R;
output [7:0] G;
output [7:0] B;

input [17:0] SW;	




// |---------------------|
// | Signal Declarations |
// | --------------------|
reg [7:0] Rr, Gg, Bb;
assign R = Rr;
assign G = Gg;
assign B = Bb;

always @ (VIDON, VC)
begin
	Rr <= 8'b00000000;
	Gg <= 8'b00000000;
	Bb <= 8'b00000000;
	
	if( VIDON == 1'b1 )
	begin
		/*if (VC > 400) begin
			Bb <= 0;
			Rr <= 233;
			Gg <= 0;
		end
		else if (VC > 300 && VC < 400)begin
			Bb <= 0;
			Rr <= 0;
			Gg <= 244;
		end
		else if (VC > 200 && VC < 300)begin
			Bb <= 254;
			Rr <= 0;
			Gg <= 0;
		end
		else begin
			Bb <= 0;
			Rr <= 0;
			Gg <= 0;
		end*/
		
		/*if( (VC > 250 && VC < 350) && (HC > 450 && HC < 550 ))
		begin
		/* Switch-Color test. Works! 
		Rr <= SW[17:10];
		Bb <= SW[9:2];
		Gg[1:0] <= {SW[1:0],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		end*/
		
		Gg <= VC;
		Rr <= HC;
		Bb <= VC;
	end
end
	
endmodule

