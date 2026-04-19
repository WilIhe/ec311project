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
    reg clk, enable;
    wire morse_shift;
    
    shift_input SI1 (encode, clk, enable, morse_shift);
    
    initial 
    begin
        encode = 7'b0000000; clk = 0; enable = 0;
        
        #2 enable = 1; encode = 7'b1000010; //B
        
        #100 $finish;
    end
    always 
    begin
        #1 clk = ~clk;
    end
endmodule
