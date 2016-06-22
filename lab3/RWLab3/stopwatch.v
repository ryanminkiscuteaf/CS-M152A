`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:44:13 01/20/2016 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(
    input clk,
    input [1:0] sw,
    input btnP,
    input btnR,
    output [7:0] seg,
    output [3:0] an
    );
	 
	/*
	The stopwatch circuit consists of 5 main modules:
	1. clock
	2. counter controller
	3. display controller
	4. state controller
	5. state registers
	
	The clock module takes the master clock (100MHz) and
	outputs 4 clocks (1Hz, 2Hz, fast clk (357.14Hz), and 
	blink clk (4 Hz).
	
	The counter controller module takes care of
	the increment of the minute and second digits.
	
	The display controller module takes care of the seven segment
	display for each of the four digits.
	
	The state controller module determines the current state of the
	circuit based on the button presses and switches.
	
	The state registers module takes the current state as an input 
	to determine which enable registers are asserted for the 
	current state so the circuit behaves properly.
	
	*** Please read each module file for more detailed
	explanations of each.
	
	
	
	*/
	 
	wire clk1;
	wire clk2;
	wire clk_fast;
	wire clk_blink;
	
	wire [3:0] min1;
	wire [3:0] min0;
	wire [3:0] sec1;
	wire [3:0] sec0;
	
	wire [1:0] cur_state;
	wire min_en;
	wire sec_en;
	wire blink_min_en;
    wire blink_sec_en;
	
	clock clock_(// Inputs
					 .clk_master(clk),
					 // Outputs
					 .clk1(clk1),
					 .clk2(clk2),
					 .clk_fast(clk_fast),
					 .clk_blink(clk_blink));
	
	counter_controller counter_controller_(// Inputs
														.clk1(clk1),
														.clk2(clk2),
														.rst(btnR),
														.min_en(min_en),
														.sec_en(sec_en),
														// Outputs
														.min1(min1),
														.min0(min0),
														.sec1(sec1),
														.sec0(sec0));
														
	display_controller display_controller_(// Inputs
														.clk(clk_fast),
														.clk_blink(clk_blink),
														.blink_min_en(blink_min_en),
                                                        .blink_sec_en(blink_sec_en),
														.min1(min1),
														.min0(min0),
														.sec1(sec1),
														.sec0(sec0),
														// Outputs
														.seg(seg),
														.an(an));
														
	state_controller state_controller_(// Inputs
												  .clk(clk),
												  .clk_fast(clk_fast),
												  .sel(sw[0]),
												  .adj(sw[1]),
												  .pause(btnP),
												  // Outputs
												  .cur_state(cur_state));			
												  
	state_registers state_registers_(// Inputs
												.clk(clk),
												.cur_state(cur_state),
												// Outputs
												.min_en(min_en),
												.sec_en(sec_en),
												.blink_min_en(blink_min_en),
                                                .blink_sec_en(blink_sec_en));


endmodule
