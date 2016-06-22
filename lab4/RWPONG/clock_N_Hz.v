`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:59:27 02/09/2016 
// Design Name: 
// Module Name:    clock_N_Hz 
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
module clock_N_Hz #(parameter N=1) (
    input clk,
    input rst,
	input en,
    output reg cout
    );
	
	// Below is based on the fact that our master clock is 100 MHz
	parameter mod_N = 50_000_000 / N;
	
	wire tc;
	
	mod_N_counter #(mod_N) mod_N_counter_ (// Inputs
												  .clk(clk),
												  .rst(rst),
												  .en(en),
												  // Outputs
												  .count(),
												  .tc(tc));
									 
	always @ (posedge clk)
	begin
		if (rst)
			cout <= 1'b0;
		else if (tc)
			cout <= ~cout;
	end

endmodule
