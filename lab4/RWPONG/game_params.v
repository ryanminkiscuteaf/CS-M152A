 parameter X_MAX = 800;
parameter Y_MAX = 600;

parameter DIGIT_WIDTH = 30;
parameter DIGIT_WIDTH_HALF = DIGIT_WIDTH / 2;

parameter DIGIT_THICKNESS = 2;
parameter DIGIT_THICKNESS_HALF = DIGIT_THICKNESS / 2;

parameter SCORE_PADDING = 5;

parameter SCORE_1_X = X_MAX / 4;
parameter SCORE_2_X = (X_MAX * 3) / 4;

parameter SCORE_1A_X = SCORE_1_X + DIGIT_WIDTH_HALF + SCORE_PADDING;
parameter SCORE_1B_X = SCORE_1_X - DIGIT_WIDTH_HALF - SCORE_PADDING;

parameter SCORE_2A_X = SCORE_2_X + DIGIT_WIDTH_HALF + SCORE_PADDING;
parameter SCORE_2B_X = SCORE_2_X - DIGIT_WIDTH_HALF - SCORE_PADDING;

parameter SCORE_Y = Y_MAX / 3;

parameter BALL_WIDTH = 6;
parameter BALL_WIDTH_HALF = BALL_WIDTH / 2;

parameter PLAYER_WIDTH = 6;
parameter PLAYER_WIDTH_HALF = PLAYER_WIDTH / 2;
parameter PLAYER_HEIGHT = 40;
parameter PLAYER_HEIGHT_HALF = PLAYER_HEIGHT / 2;

parameter OBSTACLE_WIDTH = 20;
parameter OBSTACLE_WIDTH_HALF = OBSTACLE_WIDTH / 2;
parameter OBSTACLE_HEIGHT = 150;
parameter OBSTACLE_HEIGHT_HALF = OBSTACLE_HEIGHT / 2;

parameter OBSTACLE1_X = 300;
parameter OBSTACLE1_Y = OBSTACLE_HEIGHT_HALF;

parameter OBSTACLE2_X = 500;
parameter OBSTACLE2_Y = 600 - OBSTACLE_HEIGHT_HALF;

parameter BALL_INITIAL_POSITION_X = X_MAX / 2;
parameter BALL_INITIAL_POSITION_Y = Y_MAX / 2;
 
parameter P1_INITIAL_POSITION_X = 20;
parameter P1_INITIAL_POSITION_Y = Y_MAX / 2;

parameter P2_INITIAL_POSITION_X = X_MAX - P1_INITIAL_POSITION_X;
parameter P2_INITIAL_POSITION_Y = Y_MAX / 2;

parameter TOP_BOUNDARY = $signed(12'd0 + BALL_WIDTH_HALF);
parameter LEFT_BOUNDARY = $signed(12'd0 + BALL_WIDTH_HALF);
parameter BOTTOM_BOUNDARY = $signed(12'd600 - BALL_WIDTH_HALF);
parameter RIGHT_BOUNDARY = $signed(12'd800 - BALL_WIDTH_HALF);

parameter PLAYER_TOP_BOUNDARY = $signed(12'd0 + PLAYER_HEIGHT_HALF);
parameter PLAYER_BOTTOM_BOUNDARY = $signed(12'd600 - PLAYER_HEIGHT_HALF);
