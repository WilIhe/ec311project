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


module shift_input_2(
    input [6:0] encode,
    input clk, rst,
    input start,
    output reg done_char,
    output reg busy,
    output reg morse_shift
    );
    
    // This module acts like a shift register; it takes in the 20 bit morse sequence,
    // and outputs it one at a time
     
    wire [19:0] morse_sequence;
    wire slowed_clk;
     
    clk_div C2 (.clk_in(clk), .rst(rst), .divided_clk(slowed_clk));
    morse_lookup ML1 (.encode(encode), .enable(enable), .clk(clk), .morse_sequence(morse_sequence));
 
    
    reg [4:0] index;

    initial begin
      index = 5'd19;
      morse_shift = 0;
      busy = 0;
      done_char = 0;
    end

    always @ (posedge slowed_clk, posedge rst) begin 
        if (rst) begin // re-outputs the morse code sequence
            index <= 5'd19;
            morse_shift <= 0;
            busy <= 0;
            done_char <= 0;
        end
        else begin
          done_char <= 0;
          if (start && !busy) begin
            index <= 5'd19;
            morse_shift <= morse_sequence[5'd19];
            busy <= 1;
          end
          else if (busy) begin
            morse_shift <= morse_sequence[index];
            
            if (index == 5'd0) begin 
              index <= 5'd19;
              busy <= 0;
              done_char <= 1;
            end
            else begin 
              index <= index - 5'd1;
            end
          end
          else begin
                morse_shift <= 0;
          end
       end  
    end
endmodule
