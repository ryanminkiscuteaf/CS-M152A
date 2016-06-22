`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:28:18 02/09/2016 
// Design Name: 
// Module Name:    mod_N_counter 
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
module mod_N_counter #(parameter N = 10)(
    input clk,
    input rst,
    input en,
    output reg [31:0] count,
    output reg tc
    );
    
	always @ (posedge clk)
	begin
		if (rst)
			begin
				count <= 32'd0;
				tc <= 1'b0;
			end
		else if (en)
			begin
				if (count == N - 2)
					tc <= 1'b1;
				else
					tc <= 1'b0;
							
				if (count == N - 1)
					count <= 32'd0;
				else
					count <= count + 1;
			end
	end

endmodule
