/*
	Module:       snes_controller
	Description:  Fetches snes controller buttons
					  and returns them as an array of 16.
					  A FSM is implemented to fetch data,
					  also taking into account the correct
					  clock speed by scaling down the clock
					  slow enough for the controller to read
					  the pulses.
	Author:       Sergio M
	Date:         8/9/14 (Rev1)
*/

module snes_controller(
	LATCH,		// GPIO[x]
	DATA,			// GPIO[x]
	PULSE,      // GPIO[x]
	CLOCK,		// eg. CLOCK_50 (50MHz)
	BUTTONS    // Array of buttons
	);

//=======================================================
//  PORT declarations
//=======================================================
input  DATA;
input  CLOCK;

output        LATCH;
output        PULSE;
output [15:0] BUTTONS;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [15:0]  buttons;        // Holds the buttons to be pressed
reg         latch;          // SNES latch pin
reg         pulse;          // SNES pulse pin
reg         snes_clock;     // Oscillates slower for SNES
reg [17:0]  prescaler;      // For scaling down clock rate
//reg [9:0]   counter;      // Debugging purposes: Output to LED to see clock rate

// FSM
integer     b_counter;     // Keeps track of what button to read
reg [2:0]   states;        // Keeps track of current state   


//=======================================================
//  Structural coding
//=======================================================
assign LATCH = latch;
assign PULSE = pulse;
assign BUTTONS = buttons;


initial
begin
	//counter <= 0;
	prescaler <= 0;
	latch <= 0;
	pulse <= 0;
	b_counter <= 0;
	states <= 0;
	snes_clock <= 0;
end


// Prescales CLOCK_50 to appropriate Hz for controller
always @ (posedge CLOCK)
begin
	// Slow down the clock by a factor of 50.000.000
	if(prescaler < 5000000)
		prescaler <= prescaler + 1;
	else
		prescaler <= 0;

	// Once prescaler reached count, oscillate clk
	if(prescaler == 0)
	begin
		snes_clock <= ~snes_clock;
		/*if(counter < 1023)
			counter <= counter + 1;
		else
			counter <= 0;*/
	end
end

always @ (posedge snes_clock)
begin
	// FSM: Reads buttons from SNES controller and outputs them on LEDR.
	
	// Transitions
	case(states)
		3'b000 : begin  // -1 state
			states <= 3'b001;
		end
		3'b001 : begin  // initialize
			states <= 3'b010;
		end
		3'b010 : begin  // button_1_latch_high
			states <= 3'b011;
		end
		3'b011 : begin  // button_1_latch_low
			states <= 3'b100;
		end
		3'b100 : begin  // button_1_read
			states <= 3'b101;
		end
		3'b101 : begin  // oscillate_clock
			if(b_counter < 16)
				states <= 3'b110;
			else
				states <= 3'b001;
		end
		3'b110 : begin  // oscillate_clock_read  buttons 2-16
			if(b_counter < 16)
				states <= 3'b101;
			else
				states <= 3'b001;
		end
		
		default : begin
			states <= 3'b000;
		end
	endcase

	
	
	// Actions
	case(states)
		3'b001 : begin  // initialize
			latch <= 0;
			pulse   <= 1;
			b_counter <= 0;			
		end
		3'b010 : begin  // button_1_latch_high
			latch <= 1;
		end
		3'b011 : begin  // button_1_latch_low
			latch <= 0;
		end
		3'b100 : begin  // button_1_read
			buttons[0] <= DATA;
			b_counter  <= b_counter + 1;
		end
		3'b101 : begin  // oscillate_clock
			pulse <= ~pulse;
		end
		3'b110 : begin  // oscillate_clock_read  buttons 2-16
			case(b_counter)
				1 :
					buttons[1] <= DATA;
				2 :
					buttons[2] <= DATA;
				3 :
					buttons[3] <= DATA;
				4 :
					buttons[4] <= DATA;
				5 :
					buttons[5] <= DATA;
				6 :
					buttons[6] <= DATA;
				7 :
					buttons[7] <= DATA;
				8 :
					buttons[8] <= DATA;
				9 :
					buttons[9] <= DATA;
				10 :
					buttons[10] <= DATA;
				11 :
					buttons[11] <= DATA;
				12 :
					buttons[12] <= DATA;
				13 :
					buttons[13] <= DATA;
				14 :
					buttons[14] <= DATA;
				15 :
					buttons[15] <= DATA;
			endcase
			
			// Increment button counter
			b_counter <= b_counter + 1;
		end
	endcase

end


endmodule // END snes_controller
