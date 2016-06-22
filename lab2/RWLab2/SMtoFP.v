`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:38 01/18/2016 
// Design Name: 
// Module Name:    SMtoFP 
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
module SMtoFP(
    input [11:0] SM,
    output [2:0] Exp,
    output [3:0] Sig,
    output FifthBit
    );
	
	integer dec;
	reg [3:0] sigTemp;
	reg fbTemp;
	
	always @* begin
		//if (SM[11])
		//	dec = 8;
		if (SM[10])
			dec = 7;
		else if (SM[9])
			dec = 6;
		else if (SM[8])
			dec = 5;
		else if (SM[7])
			dec = 4;
		else if (SM[6])
			dec = 3;
		else if (SM[5])
			dec = 2;
		else if (SM[4])
			dec = 1;
		else
			dec = 0;
			
		case (dec)
			7: begin
					sigTemp = SM[10:7];
					fbTemp = SM[6];
				end
			6: begin
					sigTemp = SM[9:6];
					fbTemp = SM[5];
				end
			5: begin
					sigTemp = SM[8:5];
					fbTemp = SM[4];
				end
			4: begin
					sigTemp = SM[7:4];
					fbTemp = SM[3];
				end
			3: begin
					sigTemp = SM[6:3];
					fbTemp = SM[2];
				end
			2: begin
					sigTemp = SM[5:2];
					fbTemp = SM[1];
				end
			1: begin
					sigTemp = SM[4:1];
					fbTemp = SM[0];
				end
			default: begin
							sigTemp = SM[3:0];
							fbTemp = 0;
						end
				
		endcase
		
		// special case for SM = -2048
		if (SM[11] == 1)
			begin
				dec = 7;
				sigTemp = 4'hF;
				fbTemp = 0;
			end
	end
	
	assign Exp = dec;
	assign Sig = sigTemp;
	assign FifthBit = fbTemp;
	
endmodule
