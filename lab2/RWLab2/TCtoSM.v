`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:37:14 01/18/2016 
// Design Name: 
// Module Name:    TCtoSM 
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
module TCtoSM(
    input [11:0] D,
    output S,
    output [11:0] SM
    );

	reg [11:0] smTemp;
	
	always @*
		smTemp = D[11] ? (~D + 12'b1) : D;

	assign S = D[11];
	assign SM = smTemp;

endmodule
