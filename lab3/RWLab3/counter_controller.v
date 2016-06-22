`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:40:56 01/20/2016 
// Design Name: 
// Module Name:    counter_controller 
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
module counter_controller(
    input clk1,
    input clk2,
    input rst,
    input min_en,
    input sec_en,
    output [3:0] min1,
    output [3:0] min0,
    output [3:0] sec1,
    output [3:0] sec0
    );

	wire [31:0] min1_temp;
	wire [31:0] min0_temp;
	wire [31:0] sec1_temp;
	wire [31:0] sec0_temp;
	
	wire min1_tc;
	wire min0_tc;
	wire sec1_tc;
	wire sec0_tc;
	
	wire clk_min;
	wire clk_sec;
	
	assign clk_min = (min_en & ~sec_en) ? clk2 : clk1;
	assign clk_sec = (~min_en & sec_en) ? clk2 : clk1;
	
	/*
	We use the ModNCounter to emulate the minute and second digits. 
	Note that we do not use a counter for the two second digits. 
	Instead we use a counter for each second digit. Thus, the first counter 
	goes from 0 to 9, while the second counter goes from 0 to 5. Every time
	the first counter resets from 9 to 0, the second counter increments by 
	one. Every time the second counter resets from 5 to 0, the third counter
	(for the first minute digit) increments by one. You can see that
	the logic applies to the second minute digit. This design is possible
	due to the enable input of the counter which controls whether the counter
	counts or nor. 
	
	tc of each ModNCounter tells us when the counter resets.
	
	min_en determines whether the minute portion of the stopwatch
	counts or not. The same applies to sec_en. There are needed to
	implement the pause mode as well as the ADJust mode in which
	either the minute or second portion of the stopwatch pauses, while
	the unpaused portion increments at twice the frequency of the
	normal frequency. As you can see above, we choose the clk for
	min and sec based on these enable inputs.
	*/

	ModNCounter #(32'd6) min1Counter (// Inputs
												 .clk(clk_min),
												 .rst(rst),
												 .count_en((min0_tc & sec1_tc & sec0_tc & min_en) | (min_en & ~sec_en & min0_tc)),
												 // Outputs
												 .out(min1_temp),
												 .tc(min1_tc));
												 
	ModNCounter #(32'd10) min0Counter (// Inputs
												 .clk(clk_min),
												 .rst(rst),
												 .count_en((sec1_tc & sec0_tc & min_en) | (min_en & ~sec_en)),
												 // Outputs
												 .out(min0_temp),
												 .tc(min0_tc));
												 
	ModNCounter #(32'd6) sec1Counter (// Inputs
												 .clk(clk_sec),
												 .rst(rst),
												 .count_en(sec0_tc & sec_en),
												 // Outputs
												 .out(sec1_temp),
												 .tc(sec1_tc));
												 
	ModNCounter #(32'd10) sec0Counter (// Inputs
												 .clk(clk_sec),
												 .rst(rst),
												 .count_en(sec_en),
												 // Outputs
												 .out(sec0_temp),
												 .tc(sec0_tc));												 
	
	assign min1 = min1_temp[3:0];
	assign min0 = min0_temp[3:0];
	assign sec1 = sec1_temp[3:0];
	assign sec0 = sec0_temp[3:0];

endmodule
