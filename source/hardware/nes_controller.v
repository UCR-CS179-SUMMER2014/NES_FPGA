/*
	Module:       nes_controller
	Description:  Fetches nes controller buttons
					  and returns them as an array of 8 stored in buttons.
					  A FSM is implemented to fetch data,
					  also taking into account the correct
					  clock speed by scaling down the clock
					  slow enough for the controller to read
					  the pulses.
	Author:       Sergio M, Randy T, Omar T, Hector D, Kevin M
	Date:         8/9/14 (Rev2)
*/

module nes_controller(
	LATCH,		// GPIO[x]
	DATA,			// GPIO[x]
	PULSE,      // GPIO[x]
	CLOCK,		// eg. CLOCK_50 (50MHz)
	BUTTONS     // Array of buttons
	);

//=======================================================
//  PORT declarations
//=======================================================
input  DATA;
input  CLOCK;

output        LATCH;
output        PULSE;
output [7:0] BUTTONS;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [7:0]   buttons;        // Holds the buttons to be pressed
reg         latch;          // nes latch pin
reg         pulse;          // nes pulse pin
reg         nes_clock;      // Oscillates slower for nes
reg [17:0]  prescaler;      // For scaling down clock rate

// FSM
reg [5:0]   states;        // Keeps track of current state   

//=======================================================
//  Constant Variables
//=======================================================
//Constant variables named accordingly to the states
//18 states total 

//1 Init state
parameter NES_Init = 1;

//Latch
//3 states for the Latch (A button)
parameter Latch_ON_1 = 2;
parameter Latch_ON_2 = 3;
parameter Latch_OFF = 4;

//Pulses
//14 states for the pulses (B, Select, Start, Up, Down, Left, Right)
parameter ButtonB_ON = 5;
parameter ButtonB_OFF = 6; 
parameter ButtonSelect_ON = 7;
parameter ButtonSelect_OFF = 8;
parameter ButtonStart_ON = 9;
parameter ButtonStart_OFF = 10;
parameter ButtonUp_ON = 11;
parameter ButtonUp_OFF = 12;
parameter ButtonDown_ON = 13;
parameter ButtonDown_OFF = 14;
parameter ButtonLeft_ON = 15;
parameter ButtonLeft_OFF = 16;
parameter ButtonRight_ON = 17;
parameter ButtonRight_OFF = 18;

// For slowing down the clock by a certain factor
// TODO: Still need to check for optimal timing
parameter To_Tick = 12'h0A2;

//=======================================================
//  Structural coding
//=======================================================
assign LATCH = latch;
assign PULSE = pulse;
assign BUTTONS = buttons;

//Initialize variables
initial begin
	prescaler <= 0;
	nes_clock <= 0;
	latch <= 0;
	pulse <= 0;
	states <= NES_Init;
end

// Prescales CLOCK_50 to appropriate Hz for controller
always @ (posedge CLOCK)
begin
	// Slow down the clock by a certain factor
	// Still need to check for optimal timing
	if(prescaler < To_Tick)
		prescaler <= prescaler + 1;
	else
		prescaler <= 0;

	// Once prescaler reached count, oscillate clk
	if(prescaler == 0)
	begin
		nes_clock <= ~nes_clock;
	end
end

/*
* Runs whenever nes_clock ticks which would be counted by the prescaler loop above.
* Summary: State machine first latches on (1) for one full pulse period. After another tick,
  latch turns off (0) sending a bit stored in DATA, 1 for A not pressed, 0 for pressed (Active low). 
  Adjusted the bits so that 1 meant the button would be pressed for simplicity.
  After checking latch (A button), the pulse would oscillate on and off. 
  After every off, take in DATA to see if each button is pressed or not 
  Order of checks:(B, Select, Start, Up, Down, Left, Right)
  Each button excluding A, has 2 states (On and Off).
* Output: 8 bit register buttons stored with all the buttons
			buttons[0] = A 
			buttons[1] = B 
			buttons[2] = Select 
			buttons[3] = Start
			buttons[4] = Up
			buttons[5] = Down
			buttons[6] = Left
			buttons[7] = Right
			
			Example: b10010100 - Right, Up, and Select are pressed.
*/
always @ (posedge nes_clock)
begin

	//Transitions
	case(states)
		NES_Init :
			states <= Latch_ON_1;
			
		//Latch starts
		//Latch stays on for 2 states as it needs to keep the latch on for twice as longer than one pulse
		//Diagram shown on the notes
		Latch_ON_1 :
			states <= Latch_ON_2;
		Latch_ON_2 :
			states <= Latch_OFF;
		Latch_OFF :
			states <= ButtonB_ON;
		
		//Pulses
		ButtonB_ON :
			states <= ButtonB_OFF;
		ButtonB_OFF :
			states <= ButtonSelect_ON;
		
		ButtonSelect_ON :
			states <= ButtonSelect_OFF;
		ButtonSelect_OFF :
			states <= ButtonStart_ON;
		
		ButtonStart_ON :
			states <= ButtonStart_OFF;
		ButtonStart_OFF :
			states <= ButtonUp_ON;
		
		ButtonUp_ON :
			states <= ButtonUp_OFF;
		ButtonUp_OFF :
			states <= ButtonDown_ON;
			
		ButtonDown_ON :
			states <= ButtonDown_OFF;
		ButtonDown_OFF :
			states <= ButtonLeft_ON;
			
		ButtonLeft_ON :
			states <= ButtonLeft_OFF;
		ButtonLeft_OFF :
			states <= ButtonRight_ON;
			
		ButtonRight_ON :
			states <= ButtonRight_OFF;
		ButtonRight_OFF :
			states <= Latch_ON_1;
			
	endcase
	
	//Actions
	case(states)
		NES_Init : begin
			latch <= 0;
			pulse <= 0;
		end
		
		//Latch starts
		//Latch stays on for 2 states (two ticks), then off for 1 state (1 tick)
		//After going off, read in the Data for the A button, invert Data because
		//it is active low, meaning 1 would be button pressed.
		Latch_ON_1 : begin
			latch <= 1;
			pulse <= 0;
		end
		Latch_ON_2 : begin
			latch <= 1;
			pulse <= 0;
		end
		Latch_OFF : begin
			latch <= 0;
			pulse <= 0;
			buttons[0] <= ~DATA;
		end
		
		//Pulses start
		//On states have pulse as 1, off states has pulse as 0. After it pulses 0, read data in.
		ButtonB_ON :
			pulse <= 1;
		ButtonB_OFF : begin
			pulse <= 0;
			buttons[1] <= ~DATA;
		end
		
		ButtonSelect_ON :
			pulse <= 1;
		ButtonSelect_OFF : begin
			pulse <= 0;
			buttons[2] <= ~DATA;
		end
			
		ButtonStart_ON : 
			pulse <= 1;
		ButtonStart_OFF : begin
			pulse <= 0;
			buttons[3] <= ~DATA;
		end
		
		ButtonUp_ON :
			pulse <= 1;
		ButtonUp_OFF : begin
			pulse <= 0;
			buttons[4] <= ~DATA;
		end
			
		ButtonDown_ON :
			pulse <= 1;
		ButtonDown_OFF : begin
			pulse <= 0;
			buttons[5] <= ~DATA;
		end
			
		ButtonLeft_ON :
			pulse <= 1;
		ButtonLeft_OFF : begin
			pulse <= 0;
			buttons[6] <= ~DATA;
		end
		
		ButtonRight_ON :
			pulse <= 1;
		ButtonRight_OFF : begin
			pulse <= 0;
			buttons[7] <= ~DATA;
		end
		
	endcase
end

endmodule // END nes_controller
