`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 10:40:55 PM
// Design Name: 
// Module Name: morse_encoder_tb
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


module morse_encoder_tb(

    );
    
    reg [6:0] encode;
    reg rst, clk, enable;
    wire morse_code;
    
    morse_encoder M1(encode, rst, clk, enable, morse_code);
    
    initial 
    begin
        encode = 7'b0000000; rst = 0; clk = 0; enable = 0;
        
        #2 enable = 1; encode = 7'b1000010; //B
//        #10 rst = 1;
//        #5 rst = 0;
          #25 rst = 1;
          #5 rst = 0;
          #12 enable = 0;
          #20 enable = 1;
          #25 rst = 1;
          #5 rst = 0;
          
        
        #100 $finish;
    end
    always 
    begin
        #2 clk = ~clk;
    end
    
endmodule
