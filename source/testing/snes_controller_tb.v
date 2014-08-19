/*
	Define the timescale. 
	Syntax:  `timescale <unit>/<precision>
*/
`timescale 1ns/1ns


module snes_controller_tb;

/*	
	Note: All inputs to Design Under Test / Unit Under Test (DUT / UUT)
		  must be declared as registers. Similarly, all outputs from DUT/UUT
		  must be declared as wires.
*/
//Declare inputs.
reg        DATA_tb;
reg        CLOCK_tb;

// Declare outputs
wire       LATCH_tb;
wire       PULSE_tb;
wire[15:0] buttons_tb;


/*
	Note: When instantiating a module, there are two syntaxes:
		[Named] Syntax:
			module_name instance_name(
				portname_1( signal_name1),
				...
				portname_x( signal_namex) );
				
		[Positional] Syntax:
			module_name instance_name(
				signal_name1,
				...,
				signal_namex );
*/
// Instantiate the DUT (We will use name instantiation from now on to avoid confusion.)
snes_controller dut(
	.DATA(DATA_tb),
	.CLOCK(CLOCK_tb),
	.LATCH(LATCH_tb),
	.PULSE(PULSE_tb),
	.BUTTONS(buttons_tb)
);


// Generate clock
initial
begin : CLOCK_GENERATOR
	CLOCK_tb = 0;
	forever
		begin
			#5 CLOCK_tb = ~ CLOCK_tb;
		end
end

// Begin
always @ *
begin
	#1;
	DATA_tb <= ~DATA_tb;
end


endmodule
