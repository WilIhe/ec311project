`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 05:59:03 PM
// Design Name: 
// Module Name: shift_input
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


module shift_input(
    input [6:0] encode,
    input clk, enable, rst,
    output reg morse_shift
    );
    
    // This module acts like a shift register; it takes in the 20 bit morse sequence,
    // and outputs it one at a time
     
    wire [19:0] morse_sequence;
     
    morse_lookup ML1 (.encode(encode), .enable(enable), .clk(clk), .morse_sequence(morse_sequence));
    
    reg [4:0] index;
    
    initial index = 5'b10011; //  starts at the MSB : 19
    initial morse_shift = 0;
    
    always @ (posedge clk) begin 
        if (rst) begin // re-outputs the morse code sequence
            index = 5'b10011;
            morse_shift = 0;
        end
        else begin
        
            if (enable) begin
                morse_shift = morse_sequence[index];
                if (index == 5'b00000) begin 
                    index = 5'b00000; 
                end
                else begin 
                    index = index - 5'b00001;
                end
            end
            else begin
                morse_shift = 0;
            end
        end   
    end
endmodule
