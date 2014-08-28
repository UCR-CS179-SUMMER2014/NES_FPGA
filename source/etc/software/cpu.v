 module CPU(
	CLK,			// Main clock
	
	// Wave function generators
	ROUT,
	COUT,
	
	A,				// Address Bus
	D,				// Data Bus. Serves as input/output
	
	// Interrupts
	RES,            // Reset
	IRQ,			// Interrupt-Request
	NMI,			// Non-maskable Interrupt
	
	PHI2,
	WONE,			// AKA $4016W.0
	WTWO,			// AKA $4016W.1
	WTHREE,			// AKA $4016W.2
	
	// Controller Ports
	PORT1,			// AKA $4016R
	PORT2,			// AKA $4017R
);


// ========  PORT DECLARATIONS ======== //
input 		  CLK;

output 		  ROUT;
output 		  COUT;

output [15:0] A;
inout  [7:0]  D;

input RES;
input IRQ;
input NMI;

output PHI2;
output WONE;			// AKA $4016W.0
output WTWO;			// AKA $4016W.1
output WTHREE;			// AKA $4016W.2

inout PORT1;			// AKA $4016R
inout PORT2;			// AKA $4017R

// ========  INTERNAL REGISTER DECLARATIONS ======== //


// Special Purpose Registers
reg [15:0] PC;				// Program Counter
reg  [7:0]  S;				// Stack Pointer
reg  [7:0]  P;				// Status Register (Process Flags)

///// Processor (P, AKA Status Register) Flags Chart /////
// ------------------------------------------------------------------------------
// Bit  Flag                 Description                                        |
// ---  ----                 -----------                                        |
// 0    Carry                Basic Carry flag.                                  |
// 1    Zero                 Basic Zero flag.                                   |
// 2    Interrupt Disable    Disable for responding maskable interrupts         |
// 3    Decimal Mode         Enable Binary-Decimal mode. Doesn't work in 2A03.  |
// 4    Break Command        Indicate a 'BRK' instruction was executed          |
// 5    x Unused x           NULL                                               |
// 6    Overflow             Basic Overflow flag.                               |
// 7    Negative             Basic Negative flag.                               |
// ------------------------------------------------------------------------------

// General Purpose Registers
reg  [7:0]  A;				// Accumulator
reg  [7:0]  X;				// Index X Register
reg  [7:0]  Y;				// Index Y Register


// DEFINE OPCODES
/*
	Adressing Mode Labels: 
		Accumulator        => _ACC         check
		Absolute           => _ABS         check
		Immediate          => _IMM
		Implied 		   =>  -           check
		Indirect           => _IND
		Indirect Indexed   => _(X/Y)IND
		Indexed  Absolute  => _ABS(X/Y)    check
 		Indexed  Indirect  => _IND(X/Y) 
		Indexed  Zero Page => _ZP(X/Y)     check
		Relative           => _REL
		Zero Page          => _ZP          check

*/
localparam [7:0]    
				/* Accumulator OPCODES */
ASL_ACC = 8'h0A, /* CZN */ ROL_ACC = 8'h2A, /* CZN */ LSR_ACC = 8'h4A, /* CZN */ ROR_ACC = 8'h6A, /* CZN */

				/* Absolute OPCODES */
ORA_ABS = 8'h0D, /* ZN */  ASL_ABS = 8'h0E, /* CZN */  JSR_ABS = 8'h20,           BIT_ABS = 8'h2C, /* ZVN */ 
AND_ABS = 8'h2D, /* ZN */  ROL_ABS = 8'h2E, /* CZN */  JMP_ABS = 8'h4C,           EOR_ABS = 8'h4D, /* ZN */  
LSR_ABS = 8'h4E, /* CZN */ ADC_ABS = 8'h6D, /* CZVN */ ROR_ABS = 8'h6E, /* CZN */ STY_ABS = 8'h8C,           
STA_ABS = 8'h8D,           STX_ABS = 8'h8E,            LDY_ABS = 8'hAC, /* ZN */  LDA_ABS = 8'hAD, /* ZN */  
LDX_ABS = 8'hAE, /* ZN */  CPY_ABS = 8'hCC, /* CZN */  CMP_ABS = 8'hCD, /* CZN */ DEC_ABS = 8'hCE, /* ZN */  
CPX_ABS = 8'hEC, /* CZN */ SBC_ABS = 8'hED, /* CZVN */ INC_ABS = 8'hEE, /* ZN */ 

				/* Implied OPCODES */
BRK = 8'h00,          PHP = 8'h08,          CLC = 8'h18, /* C */  PLP = 8'h28, /* CZIDBVN */
SEC = 8'h38, /* C */  RTI = 8'h40, 		    PHA = 8'h48, 		  CLI = 8'h58, /* I */ 
RTS = 8'h60,		  PLA = 8'h68, /* ZN */ SEI = 8'h78, /* I */  DEY = 8'h88, /* ZN */ 
TXA = 8'h8A, /* ZN */ TYA = 8'h98, /* ZN */ TXS = 8'h9A, 		  TAY = 8'hA8, /* ZN */ 
TAX = 8'hAA, /* ZN */ CLV = 8'hB8, /* V */  TSX = 8'hBA, /* ZN */ INY = 8'hC8, /* ZN */ 
DEX = 8'hCA, /* ZN */ CLD = 8'hD8, /* D */  INX = 8'hE8, /* ZN */ NOP = 8'hEA, 
SED = 8'hF8, /* D */

				/* Indexed Absolute OPCODES */
ORA_ABSY = 8'h19, /* ZN */  ORA_ABSX = 8'h1D, /* ZN */   ASL_ABSX = 8'h1E, /* CZN */  AND_ABSY = 8'h39, /* ZN */
AND_ABSX = 8'h3D, /* ZN */  ROL_ABSX = 8'h3E, /* CZN */  EOR_ABSY = 8'h59, /* ZN */   EOR_ABSX = 8'h5D, /* ZN */
LSR_ABSX = 8'h5E, /* CZN */ ADC_ABSY = 8'h79, /* CZVN */ ADC_ABSX = 8'h7D, /* CZVN */ ROR_ABSX = 8'h7E, /* CZN */ 
STA_ABSY = 8'h99,           STA_ABSX = 8'h9D,            LDA_ABSY = 8'hB9, /* ZN */   LDY_ABSX = 8'hBC, /* ZN */
LDA_ABSX = 8'hBD, /* ZN */  LDX_ABSY = 8'hBE, /* ZN */   LDX_ABSY = 8'hBE, /* ZN */   CMP_ABSY = 8'hD9, /* CZN */ 
CMP_ABSX = 8'hDD, /* CZN */ DEC_ABSX = 8'hDE, /* ZN */   SBC_ABSY = 8'hF9, /* CZVN */ SBC_ABSX = 8'hFD, /* CZVN */
INC_ABSX = 8'hFE, /* ZN */ 
		
				/* Indexed Zero Page OPCODES */
ORA_ZPX = 8'h15, /* ZN */   ASL_ZPX = 8'h16, /* CZN */  AND_ZPX = 8'h35, /* ZN */   ROL_ZPX = 8'h36, /* CZN */
EOR_ZPX = 8'h55, /* ZN */   LSR_ZPX = 8'h56, /* CZN */  ADC_ZPX = 8'h75, /* CZVN */ ROR_ZPX = 8'h76, /* CZN */
STY_ZPX = 8'h94,            STA_ZPX = 8'h95,            STX_ZPY = 8'h96,        	LDY_ZPX = 8'hB4, /* ZN */
LDA_ZPX = 8'hB5, /* ZN */   LDX_ZPY = 8'hB6, /* ZN */   CMP_ZPX = 8'hD5, /* CZN */  DEC_ZPX = 8'hD6, /* ZN */
SBC_ZPX = 8'hF5, /* CZVN */ INC_ZPX = 8'hF6, /* ZN */ 	

				/* Zero Page OPCODES */
ORA_ZP = 8'h05, /* ZN */  ASL_ZP = 8'h06, /* CZN */ BIT_ZP = 8'h24, /* ZVN */ AND_ZP = 8'h25, /* ZN */
ROL_ZP = 8'h26, /* CZN */ EOR_ZP = 8'h45, /* ZN */  LSR_ZP = 8'h46, /* CZN */ ADC_ZP = 8'h65, /* CZVN */
ROR_ZP = 8'h66, /* CZN */ STY_ZP = 8'h84,           STA_ZP = 8'h85,           STX_ZP = 8'h86,
LDY_ZP = 8'hA4, /* ZN */  LDA_ZP = 8'hA5, /* ZN */  LDX_ZP = 8'hA6, /* ZN */  CPY_ZP = 8'hC4, /* CZN */
CMP_ZP = 8'hC5, /* CZN */ DEC_ZP = 8'hC6, /* ZN */  CPX_ZP = 8'hE4, /* CZN */ SBC_ZP = 8'hE5, /* CZVN */
INC_ZP = 8'hE6, /* ZN */ 






endmodule

