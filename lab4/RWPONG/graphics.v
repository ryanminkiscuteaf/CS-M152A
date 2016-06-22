`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:53 02/11/2016 
// Design Name: 
// Module Name:    graphics 
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
module graphics(
    input clk,

    input [10:0] pixel_x,
	 input [10:0] pixel_y,
	 
	 input [11:0] score1a_x,
    input [11:0] score1a_y,
    
	 input [11:0] score1b_x,
    input [11:0] score1b_y,
    
	 input [11:0] score2a_x,
    input [11:0] score2a_y,
	 
	 input [11:0] score2b_x,
    input [11:0] score2b_y,
	 
	 input [3:0] score1a,
	 input [3:0] score1b,
	 
	 input [3:0] score2a,
	 input [3:0] score2b,
	 
	 output reg [2:0] vgaRed,
    output reg [2:0] vgaGreen,
    output reg [1:0] vgaBlue
    );
    
    // The logic is similar to seven segment display's logic

`include "game_params.v"
	
	parameter DIGIT_R = 3'b111;
	parameter DIGIT_G = 3'b111;
	parameter DIGIT_B = 2'b11;
	
	// Score Segment X position
	wire [11:0] score1a_0x;
	wire [11:0] score1a_1x;
	wire [11:0] score1a_2x;
	wire [11:0] score1a_3x;
	wire [11:0] score1a_4x;
	wire [11:0] score1a_5x;
	wire [11:0] score1a_6x;
	
	wire [11:0] score1b_0x;
	wire [11:0] score1b_1x;
	wire [11:0] score1b_2x;
	wire [11:0] score1b_3x;
	wire [11:0] score1b_4x;
	wire [11:0] score1b_5x;
	wire [11:0] score1b_6x;
	
	wire [11:0] score2a_0x;
	wire [11:0] score2a_1x;
	wire [11:0] score2a_2x;
	wire [11:0] score2a_3x;
	wire [11:0] score2a_4x;
	wire [11:0] score2a_5x;
	wire [11:0] score2a_6x;
	
	wire [11:0] score2b_0x;
	wire [11:0] score2b_1x;
	wire [11:0] score2b_2x;
	wire [11:0] score2b_3x;
	wire [11:0] score2b_4x;
	wire [11:0] score2b_5x;
	wire [11:0] score2b_6x;
	
	// Score Segment Y position
	wire [11:0] score1a_0y;
	wire [11:0] score1a_1y;
	wire [11:0] score1a_2y;
	wire [11:0] score1a_3y;
	wire [11:0] score1a_4y;
	wire [11:0] score1a_5y;
	wire [11:0] score1a_6y;
	
	wire [11:0] score1b_0y;
	wire [11:0] score1b_1y;
	wire [11:0] score1b_2y;
	wire [11:0] score1b_3y;
	wire [11:0] score1b_4y;
	wire [11:0] score1b_5y;
	wire [11:0] score1b_6y;
	
	wire [11:0] score2a_0y;
	wire [11:0] score2a_1y;
	wire [11:0] score2a_2y;
	wire [11:0] score2a_3y;
	wire [11:0] score2a_4y;
	wire [11:0] score2a_5y;
	wire [11:0] score2a_6y;
	
	wire [11:0] score2b_0y;
	wire [11:0] score2b_1y;
	wire [11:0] score2b_2y;
	wire [11:0] score2b_3y;
	wire [11:0] score2b_4y;
	wire [11:0] score2b_5y;
	wire [11:0] score2b_6y;	
	
	// Enable Wires
	wire [11:0] score1a_0_en;
	wire [11:0] score1a_1_en;
	wire [11:0] score1a_2_en;
	wire [11:0] score1a_3_en;
	wire [11:0] score1a_4_en;
	wire [11:0] score1a_5_en;
	wire [11:0] score1a_6_en;
	
	wire [11:0] score1b_0_en;
	wire [11:0] score1b_1_en;
	wire [11:0] score1b_2_en;
	wire [11:0] score1b_3_en;
	wire [11:0] score1b_4_en;
	wire [11:0] score1b_5_en;
	wire [11:0] score1b_6_en;
	
	wire [11:0] score2a_0_en;
	wire [11:0] score2a_1_en;
	wire [11:0] score2a_2_en;
	wire [11:0] score2a_3_en;
	wire [11:0] score2a_4_en;
	wire [11:0] score2a_5_en;
	wire [11:0] score2a_6_en;
	
	wire [11:0] score2b_0_en;
	wire [11:0] score2b_1_en;
	wire [11:0] score2b_2_en;
	wire [11:0] score2b_3_en;
	wire [11:0] score2b_4_en;
	wire [11:0] score2b_5_en;
	wire [11:0] score2b_6_en;

	score_segment_xy #(DIGIT_WIDTH, DIGIT_WIDTH) ssxy1a (.x(score1a_x),
																			.y(score1a_y),
																			.x0(score1a_0x),
																			.y0(score1a_0y),
																			.x1(score1a_1x),
																			.y1(score1a_1y),
																			.x2(score1a_2x),
																			.y2(score1a_2y),
																			.x3(score1a_3x),
																			.y3(score1a_3y),
																			.x4(score1a_4x),
																			.y4(score1a_4y),
																			.x5(score1a_5x),
																			.y5(score1a_5y),
																			.x6(score1a_6x),
																			.y6(score1a_6y));
	
	score_segment_xy #(DIGIT_WIDTH, DIGIT_WIDTH) ssxy1b (.x(score1b_x),
																			.y(score1b_y),
																			.x0(score1b_0x),
																			.y0(score1b_0y),
																			.x1(score1b_1x),
																			.y1(score1b_1y),
																			.x2(score1b_2x),
																			.y2(score1b_2y),
																			.x3(score1b_3x),
																			.y3(score1b_3y),
																			.x4(score1b_4x),
																			.y4(score1b_4y),
																			.x5(score1b_5x),
																			.y5(score1b_5y),
																			.x6(score1b_6x),
																			.y6(score1b_6y));

	score_segment_xy #(DIGIT_WIDTH, DIGIT_WIDTH) ssxy2a (.x(score2a_x),
																			.y(score2a_y),
																			.x0(score2a_0x),
																			.y0(score2a_0y),
																			.x1(score2a_1x),
																			.y1(score2a_1y),
																			.x2(score2a_2x),
																			.y2(score2a_2y),
																			.x3(score2a_3x),
																			.y3(score2a_3y),
																			.x4(score2a_4x),
																			.y4(score2a_4y),
																			.x5(score2a_5x),
																			.y5(score2a_5y),
																			.x6(score2a_6x),
																			.y6(score2a_6y));

	score_segment_xy #(DIGIT_WIDTH, DIGIT_WIDTH) ssxy2b (.x(score2b_x),
																			.y(score2b_y),
																			.x0(score2b_0x),
																			.y0(score2b_0y),
																			.x1(score2b_1x),
																			.y1(score2b_1y),
																			.x2(score2b_2x),
																			.y2(score2b_2y),
																			.x3(score2b_3x),
																			.y3(score2b_3y),
																			.x4(score2b_4x),
																			.y4(score2b_4y),
																			.x5(score2b_5x),
																			.y5(score2b_5y),
																			.x6(score2b_6x),
																			.y6(score2b_6y));

	score_segment_control ssc1a (.score(score1a),
										  .en0(score1a_0_en),
										  .en1(score1a_1_en),
										  .en2(score1a_2_en),
										  .en3(score1a_3_en),
										  .en4(score1a_4_en),
										  .en5(score1a_5_en),
										  .en6(score1a_6_en));

	score_segment_control ssc1b (.score(score1b),
										  .en0(score1b_0_en),
										  .en1(score1b_1_en),
										  .en2(score1b_2_en),
										  .en3(score1b_3_en),
										  .en4(score1b_4_en),
										  .en5(score1b_5_en),
										  .en6(score1b_6_en));
										
	score_segment_control ssc2a (.score(score2a),
										  .en0(score2a_0_en),
										  .en1(score2a_1_en),
										  .en2(score2a_2_en),
										  .en3(score2a_3_en),
										  .en4(score2a_4_en),
										  .en5(score2a_5_en),
										  .en6(score2a_6_en));										

	score_segment_control ssc2b (.score(score2b),
										  .en0(score2b_0_en),
										  .en1(score2b_1_en),
										  .en2(score2b_2_en),
										  .en3(score2b_3_en),
										  .en4(score2b_4_en),
										  .en5(score2b_5_en),
										  .en6(score2b_6_en));
										  
	always @ (posedge clk)
	begin
		// Divider pixels
		if ((pixel_x >= (400 - 1)) && 
			 (pixel_x <= (400 + 1)) && 
			 (pixel_y >= 0) && 
			 (pixel_y <= 600))
			begin
				 vgaRed <= 3'b111;
				 vgaGreen <= 3'b111;
				 vgaBlue <= 2'b11;
			end
			
		// Score 1a segment 0 pixels
		else if (score1a_0_en &&
					(pixel_x >= (score1a_0x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score1a_0x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score1a_0y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score1a_0y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end

		// Score 1 pixels
		else if (score1a_1_en &&
					(pixel_x >= (score1a_1x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1a_1x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1a_1y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1a_1y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1a_2_en &&
					(pixel_x >= (score1a_2x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1a_2x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1a_2y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1a_2y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1a_3_en &&
					(pixel_x >= (score1a_3x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score1a_3x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score1a_3y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score1a_3y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1a_4_en &&
					(pixel_x >= (score1a_4x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1a_4x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1a_4y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1a_4y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1a_5_en &&
					(pixel_x >= (score1a_5x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1a_5x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1a_5y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1a_5y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1a_6_en &&
					(pixel_x >= (score1a_6x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score1a_6x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score1a_6y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score1a_6y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
            
        // Score 1b
        // Score 1b segment 0 pixels
		else if (score1b_0_en &&
					(pixel_x >= (score1b_0x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score1b_0x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score1b_0y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score1b_0y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end

		// Score 1 pixels
		else if (score1b_1_en &&
					(pixel_x >= (score1b_1x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1b_1x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1b_1y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1b_1y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1b_2_en &&
					(pixel_x >= (score1b_2x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1b_2x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1b_2y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1b_2y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1b_3_en &&
					(pixel_x >= (score1b_3x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score1b_3x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score1b_3y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score1b_3y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1b_4_en &&
					(pixel_x >= (score1b_4x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1b_4x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1b_4y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1b_4y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1b_5_en &&
					(pixel_x >= (score1b_5x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score1b_5x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score1b_5y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score1b_5y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score1b_6_en &&
					(pixel_x >= (score1b_6x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score1b_6x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score1b_6y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score1b_6y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
            
        // Score 2a
        // Score 2a segment 0 pixels
		else if (score2a_0_en &&
					(pixel_x >= (score2a_0x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score2a_0x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score2a_0y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score2a_0y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end

		// Score 1 pixels
		else if (score2a_1_en &&
					(pixel_x >= (score2a_1x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2a_1x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2a_1y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2a_1y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2a_2_en &&
					(pixel_x >= (score2a_2x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2a_2x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2a_2y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2a_2y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2a_3_en &&
					(pixel_x >= (score2a_3x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score2a_3x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score2a_3y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score2a_3y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2a_4_en &&
					(pixel_x >= (score2a_4x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2a_4x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2a_4y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2a_4y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2a_5_en &&
					(pixel_x >= (score2a_5x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2a_5x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2a_5y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2a_5y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2a_6_en &&
					(pixel_x >= (score2a_6x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score2a_6x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score2a_6y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score2a_6y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
            
        // Score 2b
        // Score 2b segment 0 pixels
		else if (score2b_0_en &&
					(pixel_x >= (score2b_0x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score2b_0x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score2b_0y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score2b_0y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end

		// Score 1 pixels
		else if (score2b_1_en &&
					(pixel_x >= (score2b_1x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2b_1x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2b_1y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2b_1y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2b_2_en &&
					(pixel_x >= (score2b_2x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2b_2x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2b_2y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2b_2y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2b_3_en &&
					(pixel_x >= (score2b_3x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score2b_3x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score2b_3y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score2b_3y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2b_4_en &&
					(pixel_x >= (score2b_4x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2b_4x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2b_4y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2b_4y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2b_5_en &&
					(pixel_x >= (score2b_5x - DIGIT_THICKNESS_HALF)) &&
					(pixel_x <= (score2b_5x + DIGIT_THICKNESS_HALF)) &&
					(pixel_y >= (score2b_5y - DIGIT_WIDTH_HALF)) &&
					(pixel_y <= (score2b_5y + DIGIT_WIDTH_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
			
		else if (score2b_6_en &&
					(pixel_x >= (score2b_6x - DIGIT_WIDTH_HALF)) &&
					(pixel_x <= (score2b_6x + DIGIT_WIDTH_HALF)) &&
					(pixel_y >= (score2b_6y - DIGIT_THICKNESS_HALF)) &&
					(pixel_y <= (score2b_6y + DIGIT_THICKNESS_HALF)))
			begin
				vgaRed <= DIGIT_R;
				vgaGreen <= DIGIT_G;
				vgaBlue <= DIGIT_B;
			end
		  
		// Background pixels
		else
			begin
				vgaRed <= 3'b000;
				vgaGreen <= 3'b000;
				vgaBlue <= 2'b00;
			end
	end

endmodule
