`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:19 01/26/2016 
// Design Name: 
// Module Name:    vga_controller 
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
module vga_controller(
    input clk,
    input clr,
    output reg hsync,
    output reg vsync,
    output reg [10:0] pixel_x,
    output reg [10:0] pixel_y,
    output reg vidon
    );

	// Please look at the attached PDF for high level explanation of this module

	parameter TotalHorizontalPixels = 11'd1040;
	parameter HorizontalSyncWidth = 11'd120;
	parameter VerticalSyncWidth = 11'd6;

	parameter TotalVerticalLines = 11'd666;
	parameter HorizontalBackPorchTime = 11'd184;
	parameter HorizontalFrontPorchTime = 11'd984;
	parameter VerticalBackPorchTime = 11'd43;
	parameter VerticalFrontPorchTime = 11'd643;

	reg vertical_sync_enable = 1'b0;
	
	reg [10:0] horizontal_counter = 11'd0;
	reg [10:0] vertical_counter = 11'd0;
	
	// Horizontal Counter
	always @ (posedge clk)
	begin
		if (clr)
			horizontal_counter <= 11'd0;
		else
			begin
				if (horizontal_counter == TotalHorizontalPixels - 1)
					begin
						horizontal_counter <= 11'd0;
						vertical_sync_enable <= 1'b1;
					end
				else
					begin
						horizontal_counter <= horizontal_counter + 1;
						vertical_sync_enable <= 1'b0;
					end
			end
	end
	
	// Vertical Counter
	always @ (posedge clk)
	begin
		if (clr)
			vertical_counter <= 11'd0;
		else if (vertical_sync_enable)
			begin
				if (vertical_counter == TotalVerticalLines - 1)
					vertical_counter <= 11'd0;
				else
					vertical_counter <= vertical_counter + 1;
			end
	end
	
	// Horizontal Sync Comparator
	always @* 
	begin
		if (horizontal_counter < HorizontalSyncWidth)
			hsync <= 1'b1;
		else
			hsync <= 1'b0;
	end
	
	// Vertical Sync Comparator
	always @*
	begin
		if (vertical_counter < VerticalSyncWidth)
			vsync <= 1'b1;
		else
			vsync <= 1'b0;
	end

	// Display Area Comparator
	// Back porch time is after h/v sync timing pulse
	// Front porch time is before h/v sync timing pulse
	always @ (posedge clk)
	begin
		if (horizontal_counter > HorizontalBackPorchTime && horizontal_counter < HorizontalFrontPorchTime 
			  && vertical_counter > VerticalBackPorchTime && vertical_counter < VerticalFrontPorchTime)
			begin
				pixel_x <= horizontal_counter - HorizontalBackPorchTime;
				pixel_y <= vertical_counter - VerticalBackPorchTime;
				vidon <= 1'b1;
			end
		else
			begin
				pixel_x <= 11'd0;
				pixel_y <= 11'd0;
				vidon <= 1'b0;
			end
	end
	
endmodule
