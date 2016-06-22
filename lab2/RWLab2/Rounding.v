`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:42:20 01/18/2016 
// Design Name: 
// Module Name:    Rounding 
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
module Rounding(
    input [2:0] Exp,
    input [3:0] Sig,
    input FifthBit,
    output [2:0] E,
    output [3:0] F
    );
	 
	reg [2:0] eTemp;
	reg [4:0] sum;
	
	always @* begin
	
		if (FifthBit && Sig == 4'hF && Exp == 3'b111)
			begin
				eTemp = Exp;
				sum = 5'b01111; 
			end
		else
			begin
				sum = FifthBit ? Sig + 1 : Sig;
				
				if (sum[4])
					begin
						sum = sum >> 1;
						eTemp = Exp + 1;
					end
				else
					begin
						eTemp = Exp;
					end
			end
	end
	
	assign E = eTemp;
	assign F = sum[3:0];

endmodule
