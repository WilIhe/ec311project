`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 10:56:07 AM
// Design Name: 
// Module Name: button_debounce_tb
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


module button_debounce_tb(

    );
   
    reg clk, button;
    wire clean;
    
    button_debounce D0(clk, button, clean);
    initial
    begin
        
        button = 0;
        clk = 0;
        
        #4 button = 1;
        #3 button = 0;
        #5 button = 1;
        #6 button = 0;
        #10 button = 1;
        #45 button = 0;
        
        #10 button = 1;
        #4 button = 0;
        #10 button = 1;
        #6 button = 0;
        #45 button = 1;
        #45 button = 0;
        
        
        #100 $finish;
    end
    
    always
    begin
        #1 clk = ~clk;
    end
    
endmodule
