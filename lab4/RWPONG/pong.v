`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:59 02/18/2016 
// Design Name: 
// Module Name:    pong 
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
module pong(
    input clk,
    input [4:0] btn,
    input [7:0] sw,
    output Hsync,
    output Vsync,
    output reg [2:0] vgaRed,
    output reg [2:0] vgaGreen,
    output reg [1:0] vgaBlue
    );

	wire clk_50mhz;
	wire hsync_out;
	wire vsync_out;
	wire [10:0] pixel_x;
	wire [10:0] pixel_y;
	wire vidon;
	
	assign Hsync = ~hsync_out;
	assign Vsync = ~vsync_out;
    
    wire [2:0] R;
    wire [2:0] G;
    wire [1:0] B;
	
	// Vidon is asserted when the electron beam is in the
	// "pixel bright" area. In other words, it is not in a 
	// front porch, back porch, or sync section of the timing
	// Thus we set the FINAL output (R, G, B) to be those 
	// from the game_logic module
	// Otherwise, we set RGB to black
	always @ (posedge clk_50mhz)
	begin
		if (vidon)
			begin
				vgaRed <= R;
				vgaGreen <= G;
				vgaBlue <= B;
			end
		else
			begin
				vgaRed <= 3'b000;
				vgaGreen <= 3'b000;
				vgaBlue <= 2'b00;
			end
	end
	
	// Both clock_50hmz and ball_clock use clock dividers like in lab 3
	// to create several clocks from the master clock (100 Mhz) given as the
	// input to the circuit
	
	clock clock_50mhz(// Inputs
						  .clk_master(clk),
						  // Outputs
						  .clk_50mhz(clk_50mhz));
                          
    ball_clock ball_clock_(// Inputs
                           .clk(clk),
                           .rst(rst),
                           .sw(sw),
                           // Outputs
                           .clk_ball(clk_ball));
	
	// Please see attached PDF for explanation 					  
	vga_controller vga_controller_(// Inputs
											 .clk(clk_50mhz),
											 .clr(btn[0]),
											 // Outputs
											 .hsync(hsync_out),
											 .vsync(vsync_out),
											 .pixel_x(pixel_x),
											 .pixel_y(pixel_y),
											 .vidon(vidon));

	// Determines the gameplay and output RGB based on the pixels and gameplay
	game_logic game_logic_(// Inputs
								  .clk(clk),
                                  .clk_ball(clk_ball),
								  .rst(btn[0]),
								  .pixel_x(pixel_x),
								  .pixel_y(pixel_y),
								  .BtnU(btn[1]),
								  .BtnL(btn[2]),
								  .BtnD(btn[3]),
								  .BtnR(btn[4]),
                                  .sw(sw),
								  // Outputs
								  .vgaRed(R),
								  .vgaGreen(G),
								  .vgaBlue(B));

endmodule
