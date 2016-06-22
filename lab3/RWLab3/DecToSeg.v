`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:40:06 01/19/2016 
// Design Name: 
// Module Name:    DecToSeg 
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
module DecToSeg(
    input [3:0] dec,
    output reg [7:0] seg
    );
	
	/*
	Read below websites to understand how Seven-Segment Display work:
	https://learn.digilentinc.com/Documents/267
	https://learn.digilentinc.com/Documents/264
	
	
	This module takes a decimal number as an input and
	outputs which segments out of the seven segments of
	a digit are illuminated given a decimal number.
	
	For instance,
	
	 __
	|  |
	|  |
	 --
	 
	All the segments except the middle one are illuminated to
	emulate the number 0. Please read the aforementioned
	websites to explain how the segments are chosen
	to diplay a specific number. The segments are 
	encoded in an 8-bit string.
	
	Please read below comment for a specific way
	to handle the encoding.
	
	*/
	
   always @*
	begin
		// here we use 1 to denote the segment of the digit
		// that should be illuminated
		// however, the real value should be 0
		// so we take the complement of the seg at the end
		case (dec)
			4'd0: seg = 8'b0011_1111;
			4'd1: seg = 8'b0000_0110;
			4'd2: seg = 8'b0101_1011;
			4'd3: seg = 8'b0100_1111;
			4'd4: seg = 8'b0110_0110;
			4'd5: seg = 8'b0110_1101;
			4'd6: seg = 8'b0111_1101;
			4'd7: seg = 8'b0000_0111;
			4'd8: seg = 8'b0111_1111;
			4'd9: seg = 8'b0110_0111;
			default: seg = 8'b0000_0000;
		endcase
		// IMPORTANT: read the explanation above
		seg = ~seg;
	end

endmodule
