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
    
    shift_input SI1 (.encode(encode), .clk(clk), .enable(enable), .morse_shift(morse_shift));
    
    reg state; // (short on (dit), long on (dah)) dah = 3*dit
    parameter
    
    S0=1'b0, // saw '1'
    S1=1'b1; //  saw a '0'
    
    initial state = S0;
    initial morse_code = 0;
    initial index = 5'b10011;
    
    
    
    always @ (posedge clk) begin 
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




//    always @ (posedge clk) begin
        
//        if (enable) begin // 10 clk cycles have passed // begin is similar to {}
//            if (glitch >= glitch_Max) begin // The clock has paused in between a dit/dah
            
//              case (encode)
//                A: // o _ -
//                    if (index > 6'b00001) begin // output nothing; morse sequence is over
//                        state = S0;
//                    end
//                    else if (index > 6'b00000) begin
//                        state = S2;
//                    end
//                    else begin 
//                        state = S1;
//                    end 
//                B: // - _ 0 _ 0 _ 0
//                    if (index > 6'b00011) begin
//                        state = S0;
//                    end
//                    else if (index > 6'b00000) begin
//                        state = S1;
//                    end
//                    else begin
//                        state = S2;
//                   end
                    
//                default: state = S0;
        
//            endcase
        
//            glitch = 0;
//            index = index + 6'b000001;
//            end
//            else begin
//                glitch = glitch + 2'b01; // increment glitch
                
//            end 
            
//        end else begin // enable is not on
        
//             state = S0;
////           morse_code = 0;  
//        end 

//        if (state == S0) begin
//            morse_code = 0;
//            glitch_Max = 2'b01;
//        end
//        else if (state == S1) begin
//            morse_code = 1;
//            glitch_Max = 2'b01; // wait 1 clk cycle
//        end
//        else begin
//            morse_code = 1;
//            glitch_Max = 2'b11; // wait 3 clk cycles
//        end
        
//    end
    