`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 05:59:46 PM
// Design Name: 
// Module Name: shift_input_tb
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


module shift_input_tb(

    );
    
    reg [6:0] encode;
    reg clk, enable, rst;
    wire morse_shift;
    
    shift_input DUT (encode, clk, enable, rst, morse_shift);
    
    initial 
    begin
        encode = 7'b0000000; clk = 0; enable = 0; rst = 0;
        
        #2 enable = 1; encode = 7'b1000010; //B
        #5 rst = 1;
        #7 rst = 0;
        #30 rst = 1;
        #8 rst = 0;
        
        #100 $finish;
    end
    always 
    begin
        #1 clk = ~clk;
    end
endmodule
