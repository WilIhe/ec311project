`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 02:09:01 PM
// Design Name: 
// Module Name: clk_div_tb
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


module clk_div_tb(

    );
    
    reg clk_in, rst;
    wire divided_clk;
    
    
    clk_div DUT(clk_in, rst, divided_clk);
    
    initial begin
        clk_in = 0;
        rst = 0;
        #30 rst = 1;
        #12 rst = 0;
        
        #100 $finish;
        
    end
    
//    reg D, clk, rst;
//    wire Q, notQ, divided_clk;
    
//    top_part1b DUT(D, clk, rst, Q, notQ);
   
//        initial begin
//        D = 0;
//        clk = 0;
//        #23 D = 1;
//        #20 rst = 1;
//        #3 D = 0;
//        #25 rst = 0;
//        #4 D = 1;
//        #200 $finish;
//    end
    
    always
    begin
        #2 clk_in = ~clk_in;
    end
    
endmodule
