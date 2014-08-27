module prom_DMH(
	addr,
	M
);

input  [3:0]  addr;  // Specifies what byte to output for sprite
output [15:0] M;     // Holds sprite byte


wire [3:0] j = addr;    // Get index for accessing sprite
assign M = one[j];

reg [15:0] one [15:0];  //	Sprite example: "A"
initial
begin
	one[0]  = 16'b0000000000000000;
	one[1]  = 16'b0000000000000000;
	one[2]  = 16'b0000001111000000;
	one[3]  = 16'b0000110000110000;
	one[4]  = 16'b0001100000011000;
	one[5]  = 16'b0001100000011000;
	one[6]  = 16'b0001100000011000;
	one[7]  = 16'b0001111111111000;
	one[8]  = 16'b0001111111111000;
	one[9]  = 16'b0001100000011000;
	one[10] = 16'b0001100000011000;
	one[11] = 16'b0001100000011000;
	one[12] = 16'b0001100000011000;
	one[13] = 16'b0001100000011000;
	one[14] = 16'b0000000000000000;
	one[15] = 16'b0000000000000000;
end

endmodule
