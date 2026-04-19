`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 06:32:27 PM
// Design Name: 
// Module Name: morse_lookup_tb
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


module morse_lookup_tb(

    );
    
    reg [6:0] encode;
    reg enable, clk;
    wire [19:0] morse_sequence;
    
    morse_lookup ML3(encode, enable, clk, morse_sequence);
    
    initial 
    begin
        encode = 7'b0000000; clk = 0; enable = 0;
        
        #2 enable = 1; 
        #5 encode = 7'b1000001;
        
        #100 $finish;
    end
    always 
    begin
        #2 clk = ~clk;
    end
    
endmodule
