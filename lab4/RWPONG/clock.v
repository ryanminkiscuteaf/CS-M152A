`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:56:14 01/26/2016 
// Design Name: 
// Module Name:    clock 
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
module clock(
    input clk_master,
    output clk_50mhz
    );

	reg [1:0] counter = 2'b00;
	
	always @ (posedge clk_master)
	begin
		if (counter == 2'b10)
			counter <= counter >> 1;
		else
			counter <= counter + 1;
	end
	
	assign clk_50mhz = counter[1];

endmodule
