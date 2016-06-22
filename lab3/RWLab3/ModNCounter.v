`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:43 01/19/2016 
// Design Name: 
// Module Name:    ModNCounter 
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
module ModNCounter #(parameter [31:0] N = 32'd10)(
    input clk,
    input rst,
    input count_en,
    output reg [31:0] out,
    output reg tc
    );

	//reg [31:0] out;
	//reg tc;
	
	always @ (posedge clk or posedge rst)
	begin
		if (rst)
			out <= 32'd0;
		else if (count_en) begin
			if (out == N - 2)
				tc <= 1;
			else
				tc <= 0;
				
			if (out == N - 1)
				out <= 32'd0;
			else
				out <= out + 1;
		end
	end
	

endmodule
