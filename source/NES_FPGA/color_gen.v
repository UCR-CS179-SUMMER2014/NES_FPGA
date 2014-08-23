/* Module:      color_gen
	Description: Generates an "image" on 
					 screen when VIDON is enabled */
module color_gen(
	VIDON,
	HC,
	VC,
	R,
	G,
	B
	);

// |--------------------|
// | Port Declarations  |
// | -------------------|
input VIDON;
input [9:0] HC;
input [9:0] VC;
output reg [7:0] R;
output reg [7:0] G;
output reg [7:0] B;





// |---------------------|
// | Signal Declarations |
// | --------------------|


always @ (VIDON, VC)
begin
	// When VIDON is not enabled
	R <= 8'b00000000;
	G <= 8'b00000000;
	B <= 8'b00000000;

	// When VIDON is enabled
	if( VIDON == 1'b1 )
	begin
		// Begin color generation
		G <= VC;
		R <= HC;
		B <= VC;
	end
end
	
endmodule

