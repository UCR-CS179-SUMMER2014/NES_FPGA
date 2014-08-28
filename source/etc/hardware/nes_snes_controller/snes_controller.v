/*
	Module:       snes_controller
	Description:  Fetches snes controller buttons
					  and returns them as an array of 12 stored in buttons.
					  A FSM is implemented to fetch data,
					  also taking into account the correct
					  clock speed by scaling down the clock
					  slow enough for the controller to read
					  the pulses.
	Author:       Sergio M, Randy T, Omar T, Hector D, Kevin M
	Date:         8/9/14 (Rev2)
*/

module snes_controller(
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
output [12:0] BUTTONS;

//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [12:0]   buttons;        // Holds the buttons to be pressed
reg          latch;          // snes latch pin
reg          pulse;          // snes pulse pin
reg          snes_clock;     // Oscillates slower for snes
reg [17:0]   prescaler;      // For scaling down clock rate

// FSM
reg [5:0]    states;        // Keeps track of current state   

//=======================================================
//  Constant Variables
//=======================================================
//Constant variables named accordingly to the states
//35 states total 

//1 Init state
parameter SNES_Init = 1;

//Latch
//2 states for the Latch (A button)
parameter Latch_ON_1 = 2;
parameter Latch_ON_2 = 3;

//Pulses
//24 states for the pulses (B, Select, Start, Up, Down, Left, Right)
parameter ButtonB_ON = 4;
parameter ButtonB_OFF = 5; 
parameter ButtonY_ON = 6; 
parameter ButtonY_OFF = 7; 
parameter ButtonSelect_ON = 8;
parameter ButtonSelect_OFF = 9;
parameter ButtonStart_ON = 10;
parameter ButtonStart_OFF = 11;
parameter ButtonUp_ON = 12;
parameter ButtonUp_OFF = 13;
parameter ButtonDown_ON = 14;
parameter ButtonDown_OFF = 15;
parameter ButtonLeft_ON = 16;
parameter ButtonLeft_OFF = 17;
parameter ButtonRight_ON = 18;
parameter ButtonRight_OFF = 19;
parameter ButtonA_ON = 20; 
parameter ButtonA_OFF = 21; 
parameter ButtonX_ON = 22; 
parameter ButtonX_OFF = 23; 
parameter ButtonTriggerLeft_ON = 24; 
parameter ButtonTriggerLeft_OFF = 25; 
parameter ButtonTriggerRight_ON = 26; 
parameter ButtonTriggerRight_OFF = 27; 

//Idle states
//8 states for the rest of the 16 bit controller, ticks until all bits are checked
//even though the remaining 4 bits are nothing.
parameter ButtonIdleON_1 = 28; 
parameter ButtonIdleOFF_1 = 29; 
parameter ButtonIdleON_2 = 30; 
parameter ButtonIdleOFF_2 = 31; 
parameter ButtonIdleON_3 = 32; 
parameter ButtonIdleOFF_3 = 33; 
parameter ButtonIdleON_4 = 34; 
parameter ButtonIdleON_5 = 35; 

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
	snes_clock <= 0;
	latch <= 0;
	//For SNES controllers, pulse starts at 1
	pulse <= 1;
	states <= SNES_Init;
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
		snes_clock <= ~snes_clock;
	end
end

/*
* Runs whenever snes_clock ticks which would be counted by the prescaler loop above.
* Summary: State machine first latches and pulse on (1) for one full pulse period. After another tick,
  latch turns off (0) and pulse begins oscillating. This is different than the NES controller as  
  pulse oscillates a tick after latch is 0. Adjusted the bits so that 1 meant the button would be 
  the buttons pressed. After every off, take in DATA to see if each button is pressed or not pressed
  Order of checks:(B, Y, Select, Start, Up, Down, Left, Right, A, X, Lefttrigger, Righttrigger)
  Each button has 2 states (On and Off).
* Output: 12 bit register buttons stored with all the buttons
			buttons[0] = B 
			buttons[1] = Y 
			buttons[2] = Select 
			buttons[3] = Start
			buttons[4] = Up
			buttons[5] = Down
			buttons[6] = Left
			buttons[7] = Right
			buttons[8] = A
			buttons[9] = X
			buttons[10] = TriggerLeft
			buttons[11] = TriggerRight
			
			Example: b110010010100 - TriggerRight, Trigger Left, Right, Up, and Select are pressed.
*/
always @ (posedge snes_clock)
begin

	//Transitions
	case(states)
		SNES_Init :
			states <= Latch_ON_1;
			
		//Latch starts
		//Latch stays on for 2 states as it needs to keep the latch on for twice as longer than one pulse
		//Diagram shown on the notes
		Latch_ON_1 :
			states <= Latch_ON_2;
		Latch_ON_2 :
			states <= ButtonB_ON;
		
		//Pulses
		ButtonB_ON :
			states <= ButtonB_OFF;
		ButtonB_OFF :
			states <= ButtonY_ON;
			
		ButtonY_ON :
			states <= ButtonY_OFF;
		ButtonY_OFF :
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
			states <= ButtonA_ON;
			
		ButtonA_ON :
			states <= ButtonA_OFF;
		ButtonA_OFF :
			states <= ButtonX_ON;
			
		ButtonX_ON :
			states <= ButtonX_OFF;
		ButtonX_OFF :
			states <= ButtonTriggerLeft_ON;
			
		ButtonTriggerLeft_ON :
			states <= ButtonTriggerLeft_OFF;
		ButtonTriggerLeft_OFF :
			states <= ButtonTriggerRight_ON;
		
		ButtonTriggerRight_ON :
			states <= ButtonTriggerRight_OFF;
		ButtonTriggerRight_OFF :
			states <= ButtonIdleON_1;
			
		//Idle states
		ButtonIdleON_1 :
			states <= ButtonIdleOFF_1;
		ButtonIdleOFF_1 :
			states <= ButtonIdleON_2;
		ButtonIdleON_2 :
			states <= ButtonIdleOFF_2;
		ButtonIdleOFF_2 :
			states <= ButtonIdleON_3;
		ButtonIdleON_3 :
			states <= ButtonIdleOFF_3;
		ButtonIdleOFF_3 :
			states <= ButtonIdleON_4;
		ButtonIdleON_4 :
			states <= ButtonIdleON_5;
		ButtonIdleON_5 :
			states <= Latch_ON_1;
	
	endcase
	
	//Actions
	case(states)
		SNES_Init : begin
			latch <= 0;
			//SNES requires pulse to be 1 in the beginning, different than NES controller
			pulse <= 1;
		end
			
		//Latch starts
		//Latch stays on for 2 states as it needs to keep the latch on for twice as longer than one pulse
		//Diagram shown on the notes
		Latch_ON_1 : begin
			latch <= 1;
			pulse <= 1;
		end
		Latch_ON_2 : begin
			latch <= 1;
			pulse <= 1;
		end
		
		//Pulses
		ButtonB_ON : begin
			latch <= 0;
			pulse <= 1;
		end
		ButtonB_OFF : begin
			pulse <= 0;
			buttons[0] <= ~DATA;
		end
			
		//At this point, latch can just stay 0 until the state machine repeats
		ButtonY_ON :
			pulse <= 1;
		ButtonY_OFF : begin
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
			
		ButtonA_ON :
			pulse <= 1;
		ButtonA_OFF : begin
			pulse <= 0;
			buttons[8] <= ~DATA;
		end
			
		ButtonX_ON :
			pulse <= 1;
		ButtonX_OFF : begin
			pulse <= 0;
			buttons[9] <= ~DATA;
		end
			
		ButtonTriggerLeft_ON :
			pulse <= 1;
		ButtonTriggerLeft_OFF : begin
			pulse <= 0;
			buttons[10] <= ~DATA;
		end
		
		ButtonTriggerRight_ON :
			pulse <= 1;
		ButtonTriggerRight_OFF : begin
			pulse <= 0;
			buttons[11] <= ~DATA;
		end
			
		//Idle states
		//pulses on and off without sending any data
		//Does this to account for the controller being 16 bits while only 12 bits are used.
		ButtonIdleON_1 :
			pulse <= 1;
		ButtonIdleOFF_1 :
			pulse <= 0;
		ButtonIdleON_2 :
			pulse <= 1;
		ButtonIdleOFF_2 :
			pulse <= 0;
		ButtonIdleON_3 :
			pulse <= 1;
		ButtonIdleOFF_3 :
			pulse <= 0;
		ButtonIdleON_4 :
			pulse <= 1;
		ButtonIdleON_5 :
			pulse <= 1;
		
	endcase
end

endmodule // END snes_controller
