`timescale 1ns / 1ps
`define MIN1 2'b11
`define MIN0 2'b10
`define SEC1 2'b01
`define SEC0 2'b00
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:52:31 01/20/2016 
// Design Name: 
// Module Name:    display_controller 
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
module display_controller(
    input clk,
    input clk_blink,
    input blink_min_en,
    input blink_sec_en,
    input [3:0] min1,
    input [3:0] min0,
    input [3:0] sec1,
    input [3:0] sec0,
    output reg [7:0] seg,
    output reg [3:0] an
    );

	/*
	This module handles the display of the four digits of the
	stopwatch. From left to right, the digits are min1, min0,
	sec1, and sec0. 
	
	The first clk (fast clk) determines the frequency of
	the multiplexing of the display. 
	
	We cycle through the four digits using a really fast clk
	and in each cycle, we choose a digit (min1, min0, sec1, or
	sec0) to be illuminated based on its current value.
	
	Since the clk is fast, human eye perceives the four
	digits to illuminate at the same time, although actually
	the digit is illuminated sequentially over and over again.
	
	To emulate blinking, we simply don't illuminate the digits,
	every half a second (2 Hz). 
	
	Notice that either the minute or second blinks but not both.
	
	Please read the websites mentioned in "DecToSeg.v" to
	understand how to explain the way the anodes and cathodes
	are driven to illuminate the digit.
	*/

   reg [1:0] cur_digit = `SEC0;
	wire [7:0] seg_min1;
	wire [7:0] seg_min0;
	wire [7:0] seg_sec1;
	wire [7:0] seg_sec0;
	
	DecToSeg seg_min1_(// Inputs
							 .dec(min1),
							 // Outputs
							 .seg(seg_min1));

	DecToSeg seg_min0_(// Inputs
							 .dec(min0),
							 // Outputs
							 .seg(seg_min0));
							 
	DecToSeg seg_sec1_(// Inputs
							 .dec(sec1),
							 // Outputs
							 .seg(seg_sec1));
							 
	DecToSeg seg_sec0_(// Inputs
							 .dec(sec0),
							 // Outputs
							 .seg(seg_sec0));

	always @ (posedge clk)
    begin
		case (cur_digit)
			`MIN1: 
				begin
					if (blink_min_en & clk_blink)
						an <= 4'b1111;
					else
						an <= 4'b0111;
					seg <= seg_min1;
					cur_digit <= `SEC0;
				end
				
			`MIN0: 
				begin
					if (blink_min_en & clk_blink)
						an <= 4'b1111;
					else
						an <= 4'b1011;
					seg <= seg_min0;
					cur_digit <= `MIN1;
				end
				
			`SEC1:
				begin
					if (blink_sec_en & clk_blink)
						an <= 4'b1111;
					else
						an <= 4'b1101;
					seg <= seg_sec1;
					cur_digit <= `MIN0;
				end
				
			`SEC0:
				begin
					if (blink_sec_en & clk_blink)
						an <= 4'b1111;
					else
						an <= 4'b1110;
					seg <= seg_sec0;
					cur_digit <= `SEC1;
				end
		endcase
	end

endmodule
