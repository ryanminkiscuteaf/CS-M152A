`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:19 02/11/2016 
// Design Name: 
// Module Name:    score_segment_xy 
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
module score_segment_xy #(parameter WIDTH = 100, HEIGHT = 100) (
    input [11:0] x,
    input [11:0] y,
	 
	 output [11:0] x0,
	 output [11:0] y0,
	 
    output [11:0] x1,
    output [11:0] y1,
    
	 output [11:0] x2,
    output [11:0] y2,
    
	 output [11:0] x3,
    output [11:0] y3,
    
	 output [11:0] x4,
    output [11:0] y4,
    
	 output [11:0] x5,
    output [11:0] y5,
    
	 output [11:0] x6,
    output [11:0] y6
    );

	parameter WIDTH_HALF = WIDTH / 2;
	parameter HEIGHT_HALF = HEIGHT / 2;

	assign x0 = x;
	assign y0 = y - HEIGHT;	
	
	assign x1 = x + WIDTH_HALF;
	assign y1 = y - HEIGHT_HALF;
	
	assign x2 = x + WIDTH_HALF;
	assign y2 = y + HEIGHT_HALF;
	
	assign x3 = x;
	assign y3 = y + HEIGHT;
	
	assign x4 = x - WIDTH_HALF;
	assign y4 = y + HEIGHT_HALF;
	
	assign x5 = x - WIDTH_HALF;
	assign y5 = y - HEIGHT_HALF;
	
	assign x6 = x;
	assign y6 = y;

endmodule
