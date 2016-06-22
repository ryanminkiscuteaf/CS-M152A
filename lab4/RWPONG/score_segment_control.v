`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:30 02/11/2016 
// Design Name: 
// Module Name:    score_segment_control 
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
module score_segment_control(
    input [3:0] score,
    output reg en0,
    output reg en1,
    output reg en2,
    output reg en3,
    output reg en4,
    output reg en5,
    output reg en6
    );
	 
	always @*
	begin
 
                case (score)
                    0:
                        begin
                            en0 <= 1;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 1;
                            en4 <= 1;
                            en5 <= 1;
                            en6 <= 0;
                        end
                    1:
                        begin
                            en0 <= 0;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 0;
                            en4 <= 0;
                            en5 <= 0;
                            en6 <= 0;
                        end
                    2:
                        begin
                            en0 <= 1;
                            en1 <= 1;
                            en2 <= 0;
                            en3 <= 1;
                            en4 <= 1;
                            en5 <= 0;
                            en6 <= 1;
                        end
                    3:
                        begin
                            en0 <= 1;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 1;
                            en4 <= 0;
                            en5 <= 0;
                            en6 <= 1;
                        end
                    4:
                        begin
                            en0 <= 0;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 0;
                            en4 <= 0;
                            en5 <= 1;
                            en6 <= 1;
                        end
                    5:
                        begin
                            en0 <= 1;
                            en1 <= 0;
                            en2 <= 1;
                            en3 <= 1;
                            en4 <= 0;
                            en5 <= 1;
                            en6 <= 1;
                        end
                    6:
                        begin
                            en0 <= 1;
                            en1 <= 0;
                            en2 <= 1;
                            en3 <= 1;
                            en4 <= 1;
                            en5 <= 1;
                            en6 <= 1;
                        end
                    7:
                        begin
                            en0 <= 1;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 0;
                            en4 <= 0;
                            en5 <= 0;
                            en6 <= 0;
                        end
                    8:
                        begin
                            en0 <= 1;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 1;
                            en4 <= 1;
                            en5 <= 1;
                            en6 <= 1;
                        end
                    9:
                        begin
                            en0 <= 1;
                            en1 <= 1;
                            en2 <= 1;
                            en3 <= 1;
                            en4 <= 0;
                            en5 <= 1;
                            en6 <= 1;
                        end
                    default:
                        begin
                            en0 <= 0;
                            en1 <= 0;
                            en2 <= 0;
                            en3 <= 0;
                            en4 <= 0;
                            en5 <= 0;
                            en6 <= 0;
                        end
                endcase
	end

endmodule
