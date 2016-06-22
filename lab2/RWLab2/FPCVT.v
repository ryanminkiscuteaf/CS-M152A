`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:36 01/18/2016 
// Design Name: 
// Module Name:    FPCVT 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FPCVT(
    input [11:0] D,
    output S,
    output [2:0] E,
    output [3:0] F
    );
	 
	 wire [11:0] SM;
	 wire [2:0] Exp;
	 wire [3:0] Sig;
	 wire FifthBit;

	// Two's Complement to Sign Magnitude
	TCtoSM TCtoSM_ (// Outputs
						 .S(S),
						 .SM(SM),
						 // Input
						 .D(D));
						
	// Sign Magnitude to Floating Point
	SMtoFP SMtoFP_ (// Outputs
						 .Exp(Exp),
						 .Sig(Sig),
						 .FifthBit(FifthBit),
						 // Input
						 .SM(SM));

	// Floating Point Rounding
	Rounding Rounding_ (// Outputs
							  .E(E),
							  .F(F),
							  // Inputs
							  .Exp(Exp),
							  .Sig(Sig),
							  .FifthBit(FifthBit));

endmodule
