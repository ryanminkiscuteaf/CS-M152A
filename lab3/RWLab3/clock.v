`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:48:04 01/20/2016 
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
    clk_master,
    clk1,
    clk2,
    clk_fast,
    clk_blink
    );
	 
    input clk_master; 
	output reg clk1 = 0;
	output reg clk2 = 0;
	output wire clk_fast;
	output reg clk_blink = 0;
    
   wire tc1;
	wire tc2;
	wire tc_fast;
	wire tc_blink;
	
	/*
	We use ModNCounter to construct a clock divider because it works as follows:
	Given 100 MHz master clock, there are 100 million ticks per second.
	To create a 1 Hz clock, which has 1 tick per second, we divide the
	master clock by 50 million. Note that we do not divide the master clock
	by 100 million because 1 Hz clock means that it takes 1 second for the
	clock to go from 0 to 1 and back to 0. Dividing the master clock by
	100 million causes the new clock to go from 0 to 1 in 1 second, thus we multiply the
	new clock by 2. This is the same as dividing the master clock by 
	50 million. The logic for the faster clocks is similar.
	
	clk1: 1 Hz
	clk2: 2 Hz
	clk_fast: 357.14 Hz
	clk_blink: 4 Hz
	
	Notice for clk_fast, we use the counter to assert the clock to 1 for 1 tick, before
	asserting it back to 0, unlike other clocks that are asserted to 1 for a period of ticks.
	For example, the 1 Hz clock is asserted to 0 for the first half of the second, and
	asserted to 1 for the second half of the second. We use a different
	technique for the clk_fast because we use it as a debouncer for the buttons as well as
	the clock for the 7-segment display. 
	*/
	
	ModNCounter #(32'd50_000_000) clk1_counter(// Inputs
															  .clk(clk_master),
															  .rst(1'b0),
															  .count_en(1'b1),
															  // Outputs
															  .out(),
															  .tc(tc1));
		
	ModNCounter #(32'd25_000_000) clk2_counter(// Inputs
															  .clk(clk_master),
															  .rst(1'b0),
															  .count_en(1'b1),
															  // Outputs
															  .out(),
															  .tc(tc2));
																
	ModNCounter #(32'd140_000) clk_fast_counter(// Inputs
																.clk(clk_master),
																.rst(1'b0),
																.count_en(1'b1),
																// Outputs
																.out(),
																.tc(clk_fast));
																
	ModNCounter #(32'd12_500_000) clk_blink_counter(// Inputs
																 .clk(clk_master),
																 .rst(1'b0),
																 .count_en(1'b1),
																 // Outputs
																 .out(),
																 .tc(tc_blink));
	
	always @ (posedge clk_master)
	begin
		if (tc1)
			clk1 <= ~clk1;
		if (tc2)
			clk2 <= ~clk2;
		if (tc_blink)
			clk_blink <= ~clk_blink;
	end


endmodule
