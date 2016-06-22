`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:10 01/18/2016 
// Design Name: 
// Module Name:    tb 
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
module tb;

	// Input
	reg [11:0] D;
	
	// Outputs
	wire S;
	wire [2:0] E;
	wire [3:0] F;
	
	// Instantiate the Unit Under Test (UUT)
	FPCVT FPCVT_ (// Outputs
					  .S(S),
					  .E(E),
					  .F(F),
					  // Input
					  .D(D));
	
	initial begin
		// Initialize inputs
		//D = 12'b0100_0110_0000;
		
		tskConvert(12'b0100_0110_0000);
		tskConvert(12'b1000_0000_0000);
		tskConvert(12'b1111_1111_1111);
		tskConvert(12'b0000_0000_0000);
      tskConvert(12'b1110_0101_1010);
		tskConvert(12'b0000_0010_1100);
		tskConvert(12'b0000_0010_1101);
		tskConvert(12'b0000_0010_1110);
		tskConvert(12'b0000_0010_1111);
		
		// Wait 1000 ns for global reset to finish
		#1000;
		
		$finish;
	end
	
	task tskConvert;
		input [11:0] in;
		begin
			// Initialize input
			D = in;
			#1000
			// Display result
			$display("TC: %12b\n S: %b\n E: %3b\n F: %4b\n", D, S, E, F);
			#1000000;
		end
	endtask


endmodule
