`timescale 1ns / 1ps
`define NORMAL 2'b00
`define PAUSED 2'b01
`define ADJMIN 2'b10
`define ADJSEC 2'b11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:58:30 01/20/2016 
// Design Name: 
// Module Name:    state_controller 
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
module state_controller(
    clk,
	clk_fast,
    sel,
    adj,
    pause,
    cur_state
    );
    
    /*
    Based on the next input: buttons and switches, and the current state,
    we determine the next state. Note that we use the fast clock as a debouncer
    for the pause button. The logic is similar to the one from lab 1. Pause a higher
    precedence over the other states. Followed by ADJMIN and ADJSEC. NORMAL is the default state.
    */
	 
     input clk;
     input clk_fast;
     input sel;
     input adj;
     input pause;
	 output reg [1:0] cur_state = `NORMAL;
	 
	 reg pause_d;
	 reg pause_dd;
	
	// use faster clock to filter noise in the debouncer circuit
	always @ (posedge clk_fast)
	begin
		pause_d <= pause;
		pause_dd <= pause_d;
	end
	
	always @ (posedge clk)
	begin
		case (cur_state)
			`NORMAL: 
			begin
				if (~pause_dd & pause_d & clk_fast)
					cur_state <= `PAUSED;
				else if (adj & ~sel)
					cur_state <= `ADJMIN;
				else if (adj & sel)
					cur_state <= `ADJSEC;
				else 
					cur_state <= `NORMAL;
			end
			
			`PAUSED:
			begin
				if (~pause_dd & pause_d & clk_fast)
				begin
					if (adj & ~sel)
						cur_state <= `ADJMIN;
					else if (adj & sel)
						cur_state <= `ADJSEC;
					else
						cur_state <= `NORMAL;
				end		
			end
			
			`ADJMIN:
			begin
				if (~pause_dd & pause_d & clk_fast)
					cur_state <= `PAUSED;
				else if (sel)
					cur_state <= `ADJSEC;
				else if (~adj)
					cur_state <= `NORMAL;
				else
					cur_state <= `ADJMIN;
			end
			
			`ADJSEC:
			begin
				if (~pause_dd & pause_d & clk_fast)
					cur_state <= `PAUSED;
				else if (~sel)
					cur_state <= `ADJMIN;
				else if (~adj)
					cur_state <= `NORMAL;
				else
					cur_state <= `ADJSEC;
			
			end
		endcase
	end

endmodule
