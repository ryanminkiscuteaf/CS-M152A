`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:17 02/18/2016 
// Design Name: 
// Module Name:    ball_clock 
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
module ball_clock(
    input clk,
    input rst,
    input [7:0] sw,
    output reg clk_ball
    );
    
    // This clock is similar to the clock module from lab 3
    
    parameter BCN7 = 50_000;
    parameter BCN6 = 100_000;
    parameter BCN5 = 200_000;
    parameter BCN4 = 300_000;
    parameter BCN3 = 400_000;
    parameter BCN2 = 500_000;
    parameter BCN1 = 600_000;
    parameter BCN0 = 800_000;
    parameter BCNX = 1_000_000;
    
    wire clk_ball_temp7;
    wire clk_ball_temp6;
    wire clk_ball_temp5;
    wire clk_ball_temp4;
    wire clk_ball_temp3;
    wire clk_ball_temp2;
    wire clk_ball_temp1;
    wire clk_ball_temp0;
    wire clk_ball_tempx;
    
	clock_N_Hz #(50_000_000 / BCN7) cb7 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp7));
    
    clock_N_Hz #(50_000_000 / BCN6) cb6 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp6));
                                        
    clock_N_Hz #(50_000_000 / BCN5) cb5 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp5));                               
    
    clock_N_Hz #(50_000_000 / BCN4) cb4 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp4));
    
    clock_N_Hz #(50_000_000 / BCN3) cb3 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp3));
    
    clock_N_Hz #(50_000_000 / BCN2) cb2 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp2));
    
    clock_N_Hz #(50_000_000 / BCN1) cb1 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp1));
    
    clock_N_Hz #(50_000_000 / BCN0) cb0 (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_temp0));
    
    clock_N_Hz #(50_000_000 / BCNX) cbx (// Inputs
                                        .clk(clk),
                                        .rst(rst),
                                        .en(1),
                                        // Outputs
                                        .cout(clk_ball_tempx));
                                        
    always @*
    begin
        if (sw[7])
           clk_ball <= clk_ball_temp7;
        else if (sw[6])
            clk_ball <= clk_ball_temp6;
        else if (sw[5])
            clk_ball <= clk_ball_temp5;
        else if (sw[4])
            clk_ball <= clk_ball_temp4;
        else if (sw[3])
            clk_ball <= clk_ball_temp3;
        else if (sw[2])
            clk_ball <= clk_ball_temp2;
        else if (sw[1])
            clk_ball <= clk_ball_temp1;
        else if (sw[0])
           clk_ball <= clk_ball_temp0;
        else
           clk_ball <= clk_ball_tempx;
    end

endmodule
