`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2026 10:40:36 PM
// Design Name: 
// Module Name: morse_encoder
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


module morse_encoder(
    input [6:0] encode, // 7 bit input to represent upper case letters (uppercase is larger than lower in ascii)
    input rst, clk, enable, // clk will need to be slowed down; enable is used to confirm the ASCII input
    output reg morse_code
    );
     
    wire morse_shift;
    reg [4:0] index;
    
    shift_input SI1 (.encode(encode), .clk(clk), .enable(enable), .rst(rst), .morse_shift(morse_shift));
    
    reg state; // (short on (dit), long on (dah)) dah = 3*dit
    parameter
    
    S0=1'b0, // saw '1'
    S1=1'b1; //  saw a '0'
    
    initial state = S0;
    initial morse_code = 0;
    initial index = 5'b10011;
    
    
    
    always @ (posedge clk, posedge rst) begin 
        if (rst) begin 
            morse_code = 0;
            state = S0;
        end
        else begin 
            case (state)
                S0: state = (!morse_shift) ? S0 : S1; // does a zero appear on the bus?  
                S1: state = (morse_shift) ? S1 : S0;  // does a one appear on the bus?
                default: state = S0;       
            endcase
        
            morse_code = (state == S1) ? 1 : 0;
        end
        //index = index - 5'b00001;
    end
    
endmodule

