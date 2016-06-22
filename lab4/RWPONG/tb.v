`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:15:34 01/28/2016
// Design Name:   maze
// Module Name:   C:/Users/152/Desktop/RWLab4/tb.v
// Project Name:  RWLab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: maze
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg clk;
	reg [4:0] btn;

	// Outputs
	wire Hsync;
	wire Vsync;
	wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [1:0] vgaBlue;
	
	// Emulate 100MHz clock
	always #5 clk = ~clk;

	// Instantiate the Unit Under Test (UUT)
	maze uut (
		.clk(clk), 
		.btn(btn), 
		.Hsync(Hsync), 
		.Vsync(Vsync), 
		.vgaRed(vgaRed), 
		.vgaGreen(vgaGreen), 
		.vgaBlue(vgaBlue)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		//btn = 0;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here
		btn = 5'b00000;
		
		#100_000
		
		// Push BtnD
		#10000 btn = 5'b01000;
		
		// Push BtnR
		#10000 btn = 5'b10000;
		
		// Push BtnL
		#10000 btn = 5'b00100;
		
		// Unpress Btn
		#10000 btn = 5'b00000;
		
		#10_000_000_00
		$finish;
	end
      
endmodule