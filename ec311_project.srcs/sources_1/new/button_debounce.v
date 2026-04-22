`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 10:55:47 AM
// Design Name: 
// Module Name: button_debounce
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


module button_debounce(

    input clk, button,
    output reg clean
    );
    
    reg [19:0] MAX; // Max count number
    reg [19:0] counter; // 5 bit counter
    initial counter = 20'b00000000000000000000; //20'b00000000000000000000
    initial MAX = 20'b11111111111111111111; // 20'b11111111111111111111;
    initial clean = 0;
    
    always @ (posedge clk) begin
    
        if (button == clean) begin
        
            counter = 0;     
        
        end
        else begin
         if (counter >= MAX) begin // 16 clock posedge clks have occured b10000
              clean = button;
//            counter = 5'b00000;   
         end
         else begin 
            counter = counter + 20'b00000000000000000001;
         end
        end 
    
    end 
    
endmodule
