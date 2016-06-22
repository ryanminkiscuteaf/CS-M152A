`timescale 1ns / 1ps
`define NORMAL 2'b00
`define PAUSED 2'b01
`define ADJMIN 2'b10
`define ADJSEC 2'b11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:59:59 01/20/2016 
// Design Name: 
// Module Name:    state_registers 
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
module state_registers(
    input clk,
    input [1:0] cur_state,
    output reg min_en,
    output reg sec_en,
    output reg blink_min_en,
    output reg blink_sec_en
    );
    
    /*
    There are 4 states in the circuit. They are Normal, Paused, ADJMIN (adjusting minute),
    and ADJSEC (adjusting second). There are four registers dependent on the states. The
    first two enable registers determine whether the minute and/or second counters are enabled.
    The last two enable registers determine whether the minute and/or second 7-segment displays
    are blinking or not. 
    */

	always @ (posedge clk)
	begin
		case (cur_state)
			`NORMAL:
			begin
				min_en <= 1'b1;
				sec_en <= 1'b1;
				blink_min_en <= 1'b0;
                blink_sec_en <= 1'b0;
			end
			
			`PAUSED:
			begin
				min_en <= 1'b0;
				sec_en <= 1'b0;
				blink_min_en <= 1'b0;
                blink_sec_en <= 1'b0;
			end
			
			`ADJMIN:
			begin
				min_en <= 1'b1;
				sec_en <= 1'b0;
				blink_min_en <= 1'b1;
                blink_sec_en <= 1'b0;
			end
			
			`ADJSEC:
			begin
				min_en <= 1'b0;
				sec_en <= 1'b1;
                blink_min_en <= 1'b0;
				blink_sec_en <= 1'b1;
			end
		endcase
	end

endmodule
