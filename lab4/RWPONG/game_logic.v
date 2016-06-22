`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:10 01/27/2016 
// Design Name: 
// Module Name:    game_logic 
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
module game_logic(
    input clk,
    input clk_ball,
    input rst,
    input [10:0] pixel_x,
    input [10:0] pixel_y,
    input BtnU,
    input BtnL,
    input BtnR,
    input BtnD,
    input [7:0] sw,
    output reg [2:0] vgaRed,
    output reg [2:0] vgaGreen,
    output reg [1:0] vgaBlue
    );
    
    /*
    Gameplay
    
    Two players: P1 (Left) and P2 (Right)
    
    P1 moves up using BtnU and down using BtnL
    
    P2 moves up using BtnR and down using BtnD
    
    The switches (sw) determine the difficulty levels;
    The higher the level, the faster the ball moves
    
    ***You should talk about the logic for the angle 
    I assume you know it since you are the one who suggested the idea to me
    
    Also discuss the obstacles a little bit and how the balls bounce against them
    
    Please see comments below...
    */

`include "game_params.v"

	reg signed [11:0] ball_current_position_x;
	reg signed [11:0] ball_current_position_y;
    
	reg signed [11:0] p1_current_position_x;
	reg signed [11:0] p1_current_position_y;
	
	reg signed [11:0] p2_current_position_x;
	reg signed [11:0] p2_current_position_y;
    
	reg [9:0] angle;
	reg new_game;
	reg ball_dir;
	reg ball_en;
	
	wire clk_1Hz;
	wire tc_player;
	
	reg [3:0] score1a;
	reg [3:0] score1b;
	reg [3:0] score2a;
	reg [3:0] score2b;
    
    // Hack for the reset in ball always block
    reg [63:0] score1_t;
    reg [63:0] score2_t;
    
    reg [31:0] ball_speed_na;
	
	wire graphicsRed;
	wire graphicsGreen;
	wire graphicsBlue;
	
	/* 
	graphics module determines the R, G, B for:
		- divider
		- score digits
		- background
		
	The logic for score digits are inspired by the seven segment display logic
	*/
	graphics graphics_ (// Inputs
                              .clk(clk),
                              .pixel_x(pixel_x),
							  .pixel_y(pixel_y),
							  .score1a_x(SCORE_1A_X),
							  .score1a_y(SCORE_Y),
							  .score1b_x(SCORE_1B_X),
							  .score1b_y(SCORE_Y),
							  .score2a_x(SCORE_2A_X),
							  .score2a_y(SCORE_Y),
							  .score2b_x(SCORE_2B_X),
							  .score2b_y(SCORE_Y),
							  .score1a(score1a),
							  .score1b(score1b),
							  .score2a(score2a),
							  .score2b(score2b),
							  // Outputs
							  .vgaRed(graphicsRed),
							  .vgaGreen(graphicsGreen),
							  .vgaBlue(graphicsBlue));
	
	initial begin
		ball_current_position_x = BALL_INITIAL_POSITION_X + BALL_WIDTH_HALF;
		ball_current_position_y = BALL_INITIAL_POSITION_Y + BALL_WIDTH_HALF;
    
		p1_current_position_x = P1_INITIAL_POSITION_X + PLAYER_WIDTH_HALF;
		p1_current_position_y = P1_INITIAL_POSITION_Y;
		
		p2_current_position_x = P2_INITIAL_POSITION_X - PLAYER_WIDTH_HALF;
		p2_current_position_y = P2_INITIAL_POSITION_Y;
        
		// Initial ball angle
		new_game = 1'b1;
		ball_dir = 1'b1;
		ball_en = 1'b0;
		
		score1a = 0;
		score1b = 0;
		score2a = 0;
		score2b = 0;
        
        score1_t = 0;
		score2_t = 0;
	end
	
	parameter N = 31'd140_000;
	
	mod_N_counter #(N) mnc1 (// Inputs
							 .clk(clk),
							 .rst(rst),
							 .en(1),
							 // Outputs
							 .count(),
							 .tc(tc_player));

	clock_N_Hz #(1) clock_1Hz (// Inputs
								.clk(clk),
								.rst(rst),
								.en(1),
								// Outputs
								.cout(clk_1Hz));
    
	// Player Movement Logic
	always @ (posedge clk)
	begin
		if (rst)
			begin
				p1_current_position_x = P1_INITIAL_POSITION_X + PLAYER_WIDTH_HALF;
				p1_current_position_y = P1_INITIAL_POSITION_Y;
		
				p2_current_position_x = P2_INITIAL_POSITION_X - PLAYER_WIDTH_HALF;
				p2_current_position_y = P2_INITIAL_POSITION_Y;
                
                if (score1_t == score2_t)
                    score1_t = score1_t + 1;
			end
		else if (tc_player)
			begin
                // We use the tc_player instead of a clock
				// to allow for smooth movement of the player
				// when holding a button
				
				// Player 1 going up
				if (BtnU)
					p1_current_position_y = $signed(p1_current_position_y) - $signed(12'd1);
				
				// Player 2 going down
				if (BtnD)
					p2_current_position_y = $signed(p2_current_position_y) + $signed(12'd1);
				
				// Player 1 going down 
				if (BtnL)
					p1_current_position_y = $signed(p1_current_position_y) + $signed(12'd1);
				
				// Player 2 going up
				if (BtnR)
					p2_current_position_y = $signed(p2_current_position_y) - $signed(12'd1);
				
				// Keep players within the screen boundaries
				if ($signed(p1_current_position_y) < PLAYER_TOP_BOUNDARY)
					p1_current_position_y = PLAYER_TOP_BOUNDARY;
				
				if ($signed(p1_current_position_y) > PLAYER_BOTTOM_BOUNDARY)
					p1_current_position_y = PLAYER_BOTTOM_BOUNDARY;
					
				if ($signed(p2_current_position_y) < PLAYER_TOP_BOUNDARY)
					p2_current_position_y = PLAYER_TOP_BOUNDARY;
					
				if ($signed(p2_current_position_y) > PLAYER_BOTTOM_BOUNDARY)
					p2_current_position_y = PLAYER_BOTTOM_BOUNDARY;
			end
	end
    
    // Ball movement
    always @ (posedge clk_ball)
     begin
		if (score2_t < score1_t)
        begin
            ball_current_position_x = BALL_INITIAL_POSITION_X + BALL_WIDTH_HALF;
			ball_current_position_y = BALL_INITIAL_POSITION_Y + BALL_WIDTH_HALF;
            
            score1a = 0;
            score1b = 0;
            score2a = 0;
            score2b = 0;
            
            score2_t = score2_t + 1;
            
            new_game = 1;
			ball_en = 0;
			ball_dir = 1;
        end
		else if (ball_en) 
		begin
			// Update ball xy position according to its angle
			move_xy_by_angle(// Inputs
							angle,
							ball_current_position_x,
							ball_current_position_y,
							// Outputs
							ball_current_position_x,
							ball_current_position_y);
							
         detect_collision_with_p1(// Inputs
									 p1_current_position_x,
									 p1_current_position_y,
									 ball_current_position_x,
									 ball_current_position_y,
									 angle,
									 // Outputs
									 angle,
									 ball_current_position_x);
									 
			detect_collision_with_p2(// Inputs
									 p2_current_position_x,
									 p2_current_position_y,
									 ball_current_position_x,
									 ball_current_position_y,
									 angle,
									 // Outputs
									 angle,
									 ball_current_position_x);
                                     
            detect_collision_with_o(// Inputs
                                     ball_current_position_x,
                                     ball_current_position_y,
                                     angle,
                                     OBSTACLE1_X,
                                     OBSTACLE1_Y,
                                     // Outputs
                                     ball_current_position_x,
                                     ball_current_position_y,
                                     angle);
                                     
            detect_collision_with_o(// Inputs
                                     ball_current_position_x,
                                     ball_current_position_y,
                                     angle,
                                     OBSTACLE2_X,
                                     OBSTACLE2_Y,
                                     // Outputs
                                     ball_current_position_x,
                                     ball_current_position_y,
                                     angle);
									 
			// Keep ball within screen boundaries
			if ($signed(ball_current_position_y) < TOP_BOUNDARY)
			begin
				 ball_current_position_y = TOP_BOUNDARY;
				 angle = 360 - angle;
			end

			if ($signed(ball_current_position_y) > BOTTOM_BOUNDARY)
			begin
				 ball_current_position_y = BOTTOM_BOUNDARY;
				 angle = 360 - angle;
			end

			// Ball hits left border; P2 scores
			if ($signed(ball_current_position_x) < LEFT_BOUNDARY)
			begin
				 ball_current_position_x = LEFT_BOUNDARY;
				 
				 if (score2b == 9 && score2a == 9)
					begin
						// Game Over
					end
				 else if (score2a == 9)
					begin
						score2a = 0;
						score2b = score2b + 1;
					end
				 else
					begin
						score2a = score2a + 1;
					end
				 
				 ball_en = 0;
				 ball_dir = 0;
				 new_game = 1;
			end

			// Ball hits right border; P1 scores
			if ($signed(ball_current_position_x) > RIGHT_BOUNDARY)
			begin
				 ball_current_position_x = RIGHT_BOUNDARY;
				 
				 if (score1b == 9 && score1a == 9)
					begin
						// Game Over
					end
				 else if (score1a == 9)
					begin
						score1a = 0;
						score1b = score1b + 1;
					end
				 else
					begin
						score1a = score1a + 1;
					end
				 
                 ball_en = 0;
				 ball_dir = 1;
				 new_game = 1;
			end

        // **************
        
		end // else if (ball_en)
        
        if (clk_1Hz && new_game)
        	begin
                // Ball faces right
				if (ball_dir)
					begin
                        $srandom(10);
                    
						ball_current_position_x = X_MAX / 2;
						ball_current_position_y = $urandom(10) % 601;
						
						// Randomize angle (0 - 44)
						angle = $urandom(10) % 45;
						
						// (317 - 359)
						if ({$urandom(10)} % 2)
							angle = 360 - angle; 
					end
				
				// Ball faces left
				else
					begin
                        $srandom(10);
                        
						ball_current_position_x = X_MAX / 2;
						ball_current_position_y = $urandom(10) % 601;
						
						// Randomize angle (136 - 180)
						angle = 180 - ($urandom(10) % 45);
						
						// (226 - 268)
						//if ({$urandom(10)} % 2)
                            angle = angle + 49;
							//angle = angle + 89;
					end
					
				new_game = 0;
				ball_en = 1;
			end
        
        
    end // always ball clk
	
	// Graphics Output
	always @ (clk)
	begin
		// Player 1 pixels	
		if ((pixel_x >= p1_current_position_x - PLAYER_WIDTH_HALF) &&
			(pixel_x <= p1_current_position_x + PLAYER_WIDTH_HALF) &&
			(pixel_y >= p1_current_position_y - PLAYER_HEIGHT_HALF) &&
			(pixel_y <= p1_current_position_y + PLAYER_HEIGHT_HALF))
			begin
				vgaRed <= 3'b000;
				vgaGreen <= 3'b000;
				vgaBlue <= 2'b11;
			end
		
		// Player 2 pixels
		else if ((pixel_x >= p2_current_position_x - PLAYER_WIDTH_HALF) &&
				 (pixel_x <= p2_current_position_x + PLAYER_WIDTH_HALF) &&
				 (pixel_y >= p2_current_position_y - PLAYER_HEIGHT_HALF) &&
				 (pixel_y <= p2_current_position_y + PLAYER_HEIGHT_HALF))
			begin
				vgaRed <= 3'b111;
				vgaGreen <= 3'b000;
				vgaBlue <= 2'b00;			
			end

		// Ball pixels
		else if (ball_en &&
			(pixel_x >= ball_current_position_x - BALL_WIDTH_HALF) && 
				 (pixel_x <= ball_current_position_x + BALL_WIDTH_HALF) && 
				 (pixel_y >= ball_current_position_y - BALL_WIDTH_HALF) && 
				 (pixel_y <= ball_current_position_y + BALL_WIDTH_HALF))
			begin
				 vgaRed <= 3'b000;
				 vgaGreen <= 3'b111;
				 vgaBlue <= 2'b00;
			end
		
        // Obstacle 1 pixels
        else if ((pixel_x >= OBSTACLE1_X - OBSTACLE_WIDTH_HALF) &&
                 (pixel_x <= OBSTACLE1_X + OBSTACLE_WIDTH_HALF) &&
                 (pixel_y >= OBSTACLE1_Y - OBSTACLE_HEIGHT_HALF) &&
                 (pixel_y <= OBSTACLE1_Y + OBSTACLE_HEIGHT_HALF))
            begin
                vgaRed <= 3'b111;
                vgaGreen <= 3'b111;
                vgaBlue <= 2'b11;
            end
            
        // Obstacle 2 pixels
        else if ((pixel_x >= OBSTACLE2_X - OBSTACLE_WIDTH_HALF) &&
                 (pixel_x <= OBSTACLE2_X + OBSTACLE_WIDTH_HALF) &&
                 (pixel_y >= OBSTACLE2_Y - OBSTACLE_HEIGHT_HALF) &&
                 (pixel_y <= OBSTACLE2_Y + OBSTACLE_HEIGHT_HALF))
            begin
                vgaRed <= 3'b111;
                vgaGreen <= 3'b111;
                vgaBlue <= 2'b11;
            end
        
		// Graphics module pixels
		else
			begin
				vgaRed <= graphicsRed;
				vgaGreen <= graphicsGreen;
				vgaBlue <= graphicsBlue;
			end
	end
	
	task move_xy_by_angle;
		input [9:0] angle;
		input [11:0] x;
		input [11:0] y;
		output [11:0] nx;
		output [11:0] ny;
		begin
			if (angle >= 0 && angle < 90)
			begin
				if (angle == 0)
				  begin
						nx = x + 4;
						ny = y;
				  end
				if (angle > 0 && angle <= 15)
				  begin
						nx = x + 7;
						ny = y - 1;                        
				  end
				if (angle > 15 && angle <= 30)
				  begin
						nx = x + 6;
						ny = y - 2;                        
				  end
				if (angle > 30 && angle < 45)
				  begin
						nx = x + 5;
						ny = y - 3;                        
				  end
				if (angle == 45)
				  begin
						nx = x + 4;
						ny = y - 4;                        
				  end
				if (angle > 45 && angle <= 60)
				  begin
						nx = x + 3;
						ny = y - 5;                        
				  end
				if (angle > 60 && angle <= 75)
				  begin
						nx = x + 2;
						ny = y - 6;                        
				  end
				if (angle > 75 && angle < 90)
				  begin
						nx = x + 1;
						ny = y - 7;                        
				  end
				end
				else if (angle >= 90 && angle < 180)
				begin
				if (angle >= 90 && angle <= 115)
				  begin
						nx = x - 1;
						ny = y - 7;                        
				  end
				if (angle > 115 && angle <= 120)
				  begin
						nx = x - 2;
						ny = y - 6;                        
				  end
				if (angle > 120 && angle < 135)
				  begin
						nx = x - 3;
						ny = y - 5;                        
				  end
				if (angle == 135)
				  begin
						nx = x - 4;
						ny = y - 4;                        
				  end
				if (angle > 135 && angle <= 150)
				  begin
						nx = x - 5;
						ny = y - 3;                        
				  end
				if (angle > 150 && angle <= 165)
				  begin
						nx = x - 6;
						ny = y - 2;                        
				  end
				if (angle > 165 && angle < 180)
				  begin
						nx = x - 7;
						ny = y - 1;                        
				  end
				end
				else if (angle >= 180 && angle < 270)
				begin
				if (angle == 180)
				  begin
					nx = x - 4;
					ny = y;
				  end
				if (angle > 180 && angle <= 195)
				  begin
						nx = x - 7;
						ny = y + 1;                        
				  end
				if (angle > 195 && angle <= 210)
				  begin
						nx = x - 6;
						ny = y + 2;                        
				  end
				if (angle > 210 && angle < 225)
				  begin
						nx = x - 5;
						ny = y + 3;                        
				  end
				if (angle == 225)
				  begin
						nx = x - 4;
						ny = y + 4;                        
				  end
				if (angle > 225 && angle <= 240)
				  begin
						nx = x - 3;
						ny = y + 5;                        
				  end
				if (angle > 240 && angle <= 255)
				  begin
						nx = x - 2;
						ny = y + 6;                        
				  end
				if (angle > 255 && angle < 270)
				  begin
						nx = x - 1;
						ny = y + 7;                        
				  end
				end
				else if (angle >= 270)
				begin
				if (angle >= 270 && angle <= 285)
				  begin
						nx = x + 1;
						ny = y + 7;                        
				  end
				if (angle > 285 && angle <= 300)
				  begin
						nx = x + 2;
						ny = y + 6;                        
				  end
				if (angle > 300 && angle < 315)
				  begin
						nx = x + 3;
						ny = y + 5;                        
				  end
				if (angle == 315)
				  begin
						nx = x + 4;
						ny = y + 4;                        
				  end
				if (angle > 315 && angle <= 330)
				  begin
						nx = x + 5;
						ny = y + 3;                        
				  end
				if (angle > 330 && angle <= 345)
				  begin
						nx = x + 6;
						ny = y + 2;                        
				  end
				if (angle > 345)
				  begin
						nx = x + 7;
						ny = y + 1;                        
				  end
			end
		end
	endtask;
	
	task detect_collision_with_p1;
		input [11:0] p1_x;
		input [11:0] p1_y;
		input [11:0] ball_x;
		input [11:0] ball_y;
		input [9:0] c_angle;
		output [9:0] angle;
		output [11:0] ball_x_o;
		
		reg [11:0] cpy;
		begin
			cpy = $signed(p1_y) - $signed(ball_y);
			
			// Ball is within player 1's width and heght
			if (($signed(p1_x + PLAYER_WIDTH_HALF) >= $signed(ball_x - BALL_WIDTH_HALF)) &&
				($signed(cpy) < $signed(PLAYER_HEIGHT_HALF + BALL_WIDTH_HALF + 12'd7)) &&
				($signed(cpy) > $signed(~(PLAYER_HEIGHT_HALF + BALL_WIDTH_HALF + 12'd7) + 12'd1)))
				begin
					// Ball hits player 1
					// update ball's x position to be adjacent to 
					// player 1's right border
					ball_x_o = $signed(p1_x + BALL_WIDTH);
				
					if ($signed(cpy) == $signed(12'd0))
						angle = 0;
					else if ($signed(cpy) > $signed((PLAYER_HEIGHT_HALF * 2) / 3))
						angle = 45;
					else if ($signed(cpy) > $signed(PLAYER_HEIGHT_HALF / 3))
						angle = 30;
					else if ($signed(cpy) > $signed(12'd0))
						angle = 15;
					else if ($signed(cpy) < $signed(~((PLAYER_HEIGHT_HALF * 2) / 3) + 12'd1))
						angle = 360 - 45;
					else if ($signed(cpy) < $signed(~(PLAYER_HEIGHT_HALF / 3) + 12'd1))
						angle = 360 - 30;
					else if ($signed(cpy) < $signed(12'd0))
						angle = 360 - 15;
				end
			else
				begin
					angle = c_angle;
					ball_x_o = ball_x;
				end
		end
	endtask;
	
	task detect_collision_with_p2;
		input [11:0] p2_x;
		input [11:0] p2_y;
		input [11:0] ball_x;
		input [11:0] ball_y;
		input [9:0] c_angle;
		output [9:0] angle;
		output [11:0] ball_x_o;
		
		reg [11:0] cpy;
		begin
			cpy = $signed(p2_y) - $signed(ball_y);
			
			// Ball is within player 2's width and height
			if (($signed(p2_x - PLAYER_WIDTH_HALF) <= $signed(ball_x + BALL_WIDTH_HALF)) &&
				($signed(cpy) < $signed(PLAYER_HEIGHT_HALF + BALL_WIDTH_HALF + 12'd7)) &&
				($signed(cpy) > $signed(~(PLAYER_HEIGHT_HALF + BALL_WIDTH_HALF + 12'd7) + 12'd1)))
				begin
					// Ball hits player 2
					// update ball's x position to be adjacent to 
					// player 1's right border
					ball_x_o = $signed(p2_x - BALL_WIDTH); 

					if ($signed(cpy) == $signed(12'd0))
						angle = 180;
					else if ($signed(cpy) > $signed((PLAYER_HEIGHT_HALF * 2) / 3))
						angle = 180 - 45;
					else if ($signed(cpy) > $signed(PLAYER_HEIGHT_HALF / 3))
						angle = 180 - 30;
					else if ($signed(cpy) > $signed(12'd0))
						angle = 180 - 15;
					else if ($signed(cpy) < $signed(~((PLAYER_HEIGHT_HALF * 2) / 3) + 12'd1))
						angle = 180 + 45;
					else if ($signed(cpy) < $signed(~(PLAYER_HEIGHT_HALF / 3) + 12'd1))
						angle = 180 + 30;
					else if ($signed(cpy) < $signed(12'd0))
						angle = 180 + 15;
				end
			else
				begin
					angle = c_angle;
					ball_x_o = ball_x;
				end
		end
	endtask;
    
    task detect_collision_with_o;
        input [11:0] ball_x;
        input [11:0] ball_y;
        input [9:0] angle;
        input [11:0] obj_x;
        input [11:0] obj_y;
        output [11:0] ball_x_o;
        output [11:0] ball_y_o;
        output [9:0] angle_o;
        
        reg [11:0] cpy;
        
        begin
            /*if ($signed(ball_y) <= TOP_BOUNDARY)
                ball_y_o = TOP_BOUNDARY;
            else
                ball_y_o = ball_y;*/
            
            // Keep the ball's y position
            // let the top border logic handles it
            ball_y_o = ball_y;
                
            cpy = $signed(obj_y) - $signed(ball_y_o);
            
            if ((ball_x >= obj_x - OBSTACLE_WIDTH_HALF) &&
                (ball_x <= obj_x + OBSTACLE_WIDTH_HALF) &&
                ($signed(cpy) < $signed(OBSTACLE_HEIGHT_HALF)) &&
                ($signed(cpy) > $signed(~(OBSTACLE_HEIGHT_HALF) + 12'd1)))
                begin
                    if ((ball_x >= obj_x - OBSTACLE_WIDTH_HALF) &&
                        (ball_x < obj_x))
                        begin
                            ball_x_o = obj_x - OBSTACLE_WIDTH_HALF - BALL_WIDTH_HALF;
                            
                            if ($signed(cpy) == $signed(12'd0))
                                angle_o = 180;
                            else if ($signed(cpy) > $signed((OBSTACLE_HEIGHT_HALF * 2) / 3))
                                angle_o = 180 - 45;
                            else if ($signed(cpy) > $signed(OBSTACLE_HEIGHT_HALF / 3))
                                angle_o = 180 - 30;
                            else if ($signed(cpy) > $signed(12'd0))
                                angle_o = 180 - 15;
                            else if ($signed(cpy) < $signed(~((OBSTACLE_HEIGHT_HALF * 2) / 3) + 12'd1))
                                angle_o = 180 + 45;
                            else if ($signed(cpy) < $signed(~(OBSTACLE_HEIGHT_HALF / 3) + 12'd1))
                                angle_o = 180 + 30;
                            else if ($signed(cpy) < $signed(12'd0))
                                angle_o = 180 + 15;
                        end
                    else if ((ball_x <= obj_x + OBSTACLE_WIDTH_HALF) &&
                             (ball_x > obj_x))
                        begin
                            ball_x_o = obj_x + OBSTACLE_WIDTH_HALF + BALL_WIDTH_HALF;
                            
                            if ($signed(cpy) == $signed(12'd0))
                                angle_o = 0;
                            else if ($signed(cpy) > $signed((OBSTACLE_HEIGHT_HALF * 2) / 3))
                                angle_o = 45;
                            else if ($signed(cpy) > $signed(OBSTACLE_HEIGHT_HALF / 3))
                                angle_o = 30;
                            else if ($signed(cpy) > $signed(12'd0))
                                angle_o = 15;
                            else if ($signed(cpy) < $signed(~((OBSTACLE_HEIGHT_HALF * 2) / 3) + 12'd1))
                                angle_o = 360 - 45;
                            else if ($signed(cpy) < $signed(~(OBSTACLE_HEIGHT_HALF / 3) + 12'd1))
                                angle_o = 360 - 30;
                            else if ($signed(cpy) < $signed(12'd0))
                                angle_o = 360 - 15;
                        end
                end
            else
                begin
                    ball_x_o = ball_x;
                    //ball_y_o = ball_y;
                    angle_o = angle;
                end
        end
    endtask;

endmodule
