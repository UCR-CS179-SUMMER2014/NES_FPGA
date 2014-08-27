module vga_text(
	vidon,
	hc,
	vc,
	M,
	SW,
	rom_addr,
	R,
	G,
	B
);

input vidon;
input [9:0] hc;
input [9:0] vc;
input [15:0] M;
input [7:0] SW;
output [3:0] rom_addr;

output [7:0] R;
output [7:0] G;
output [7:0] B;


 
localparam hbp = 144 /*10'b0010010000*/, // Horizontal Back Porch = 144 (128+16)
			  vbp = 31  /*10'b0000011111*/, // Vertical Back Porch = 31 (2+29)
			  w = 16,								  // Width of the sprite
			  h = 16;								  // Height of the sprite

			  
reg [10:0] C1, R1; // Upper and left-hand corner position of the screen
reg [10:0] rom_addrr, rom_pix; // Rom Address and Rom Pixels
reg spriteon;
reg [7:0] Rr, Gg, Bb;



// Assignments
assign rom_addr = rom_addrr[3:0];
assign R = Rr;
assign G = Gg;
assign B = Bb;
wire [10:0] j = rom_pix;


// Get C1 and R1 using switches
always @(SW)
begin
	C1 <= {2'b00, SW[3:0], 5'b00001};	// Get C1 (Horizontal)
	R1 <= {2'b00, SW[7:4], 5'b00001};   // Get R1 (Vertical))
	rom_addrr <= vc - vbp - R1;			// Determines the address for rom to be displayed
	rom_pix <= hc - hbp - C1;					   // Determines the pixel to be displayed
end


// Set spriteon
always @ *
begin
	spriteon <= (((hc > C1 + hbp) && (hc < C1 + hbp + w) && (vc > R1 + vbp) && (vc < R1 + vbp + h)) ? 1'b1 : 1'b0);
end

// Display Sprite
always @ (spriteon, vidon, rom_pix, M)
begin
	Rr <= 9'bz;
	Gg <= 9'bz;
	Bb <= 9'bz;

	if(spriteon == 1'b1 && vidon == 1'b1)
	begin
		Rr <= {M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j]};
		Gg <= {M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j]};
		Bb <= {M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j]};
	end
end

endmodule
