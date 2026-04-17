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
    
    reg [5:0] index; // Highest morse stream = 6, 11 including 0s
    reg [1:0] glitch;
    reg [1:0] glitch_Max;
    initial glitch = 0;
    initial glitch_Max = 0;
    initial morse_code = 0;
    
    parameter
    // ASCII letters to binary
    // Add 20 in binary to get to lower case letters
    
    //(Letter, Binary, Deciaml) 
    A=7'b1000001, // 65
    B=7'b1000010; // 66
//    C=7'b1000011, // 67
//    D=7'b1000100, // 68
//    E=7'b1000101, // 69
//    F=7'b1000110, // 70
//    G=7'b1000111, // 71
//    H=7'b1001000, // 72
//    I=7'b1001001, // 73
//    J=7'b1001010, // 74
//    K=7'b1001011, // 75
//    L=7'b1001100, // 76
//    M=7'b1001101, // 77
//    N=7'b1001110, // 78
//    O=7'b1001111, // 79
//    P=7'b1010000, // 80
//    Q=7'b1010001, // 81
//    R=7'b1010010, // 82
//    S=7'b1010011, // 83
//    T=7'b1010100, // 84
//    U=7'b1010101, // 85
//    V=7'b1010110, // 86
//    W=7'b1010111, // 87
//    X=7'b1011000, // 88
//    Y=7'b1011001, // 89
//    Z=7'b1011010, // 90
    
//    // Numbers
//    //(Number, binary)
    
//    N0=7'b0000001, // 0
//    N1=7'b0000001, // 1
//    N2=7'b0000010, // 2
//    N3=7'b0000011, // 3
//    N4=7'b0000100, // 1
//    N5=7'b0000101, // 1
//    N6=7'b0000110, // 1
//    N7=7'b0000111, // 1
//    N8=7'b0001000, // 1
//    N9=7'b0001001; // 1
    
    
    reg [1:0] state; // three states (off, short on (dit), long on (dah)) dah = 3*dit
    parameter S0=2'b00, S1=2'b01, S2=2'b10;
    
    //reg continue;
    
    always @ (posedge clk) begin
        
        if (enable) begin // 10 clk cycles have passed // begin is similar to {}
            if (glitch >= glitch_Max) begin // The clock has paused in between a dit/dah
  
              case (encode)
                A: // o _ -
                    if (index > 5'b00001) begin // output nothing; morse sequence is over
                        state = S0;
                    end
                    else if (index > 5'b00000) begin
                        state = S1;
                    end
                    else begin 
                        state = S2;
                    end 
                B: // - _ 0 _ 0 _ 0
                    if (index > 5'b00011) begin
                        state = S0;
                    end
                    else if (index > 5'b00000) begin
                        state = S1;
                    end
                    else begin
                        state = S2;
                   end
                    
//            C:
//            D:
//            E:
//            F:
//            G:
//            H:
//            I:
//            J:
//            K:
//            L:
//            M:
//            N:
//            O:
//            P:
//            Q:
//            R:
//            S:
//            T:
//            U:
//            V:
//            W:
//            X:
//            Y:
//            Z:
            
            //default:
        
            endcase
        
            glitch = 0;
            index = index + 6'b000001;
            end
            else begin
                glitch = glitch + 2'b01; // increment glitch
            end 
            
        end else begin
        
             state = S0;
//           morse_code = 0; 
       
        end 
        
        if (state == S0) begin
            morse_code = 0;
            glitch_Max = 2'b01;
        end
        else if (state == S1) begin
            morse_code = 1;
            glitch_Max = 2'b01; // wait 1 clk cycle
        end
        else begin
            morse_code = 1;
            glitch_Max = 2'b11; // wait 3 clk cycles
        end
        
    end
    
    
endmodule
