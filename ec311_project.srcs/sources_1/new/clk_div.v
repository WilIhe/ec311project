`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 02:07:58 PM
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div(

	input clk_in,
	input rst,
	output reg divided_clk
    );
	 
	 
parameter toggle_value = 49999999; // TODO: Calculate correct value // for 1Hz

// toggle for 10x slower
// 5, but starts counting from 0, so toggle = 4;
// divide by 10 and then divide by 2, then subtract 1
	 
reg[32:0] cnt;
initial cnt = 0;
initial divided_clk = 0;

always@(posedge clk_in or posedge rst)
begin
	if (rst) begin
		cnt = 0;
		divided_clk = 0;
	end
	else begin
		if (cnt==toggle_value) begin
			cnt = 0;
			divided_clk = ~divided_clk;
		end
		else begin
			cnt = cnt +1;
			divided_clk = divided_clk;		
		end
	end

end
			  
	
endmodule
