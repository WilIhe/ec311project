`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 09:53:52 AM
// Design Name: 
// Module Name: morse_lookup
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



module morse_lookup(
    input [6:0] encode,
    input enable, clk,
    output reg [19:0] morse_sequence
    ); 
    
    initial morse_sequence = 0;
    
    parameter
    // ASCII letters to binary
    // Add 20 in binary to get to lower case letters
    
    //(Letter, Binary, Deciaml) 
    A=7'b1000001, // 65
    B=7'b1000010, // 66
    C=7'b1000011, // 67
    D=7'b1000100, // 68
    E=7'b1000101, // 69
    F=7'b1000110, // 70
    G=7'b1000111, // 71
    H=7'b1001000, // 72
    I=7'b1001001, // 73
    J=7'b1001010, // 74
    K=7'b1001011, // 75
    L=7'b1001100, // 76
    M=7'b1001101, // 77
    N=7'b1001110, // 78
    O=7'b1001111, // 79
    P=7'b1010000, // 80
    Q=7'b1010001, // 81
    R=7'b1010010, // 82
    S=7'b1010011, // 83
    T=7'b1010100, // 84
    U=7'b1010101, // 85
    V=7'b1010110, // 86
    W=7'b1010111, // 87
    X=7'b1011000, // 88
    Y=7'b1011001, // 89
    Z=7'b1011010, // 90
    
    // Numbers
    //(Number, binary) 
    
    N0=7'b0000000, // 0
    N1=7'b0000001, // 1
    N2=7'b0000010, // 2
    N3=7'b0000011, // 3
    N4=7'b0000100, // 1
    N5=7'b0000101, // 1
    N6=7'b0000110, // 1
    N7=7'b0000111, // 1
    N8=7'b0001000, // 1
    N9=7'b0001001; // 1
    
    
     always @ (posedge clk) begin
            
        if (enable) begin // begin is similar to {}
             
            // the morse sequence of each letter/number binary input
            case (encode)
                A: morse_sequence = 20'b10111000000000000000; // o _ -      
                B: morse_sequence = 20'b11101010100000000000;// - _ 0 _ 0 _ 0
                C: morse_sequence = 20'b11101011101000000000;
                D: morse_sequence = 20'b11101010000000000000;
                E: morse_sequence = 20'b10000000000000000000;
                F: morse_sequence = 20'b10101110100000000000;
                G: morse_sequence = 20'b11101110100000000000;
                H: morse_sequence = 20'b10101010000000000000;
                I: morse_sequence = 20'b10100000000000000000;
                J: morse_sequence = 20'b10111011101110000000;
                K: morse_sequence = 20'b11101011100000000000;
                L: morse_sequence = 20'b10111010100000000000;
                M: morse_sequence = 20'b11101110000000000000;
                N: morse_sequence = 20'b11101000000000000000;
                O: morse_sequence = 20'b11101110111000000000;
                P: morse_sequence = 20'b10111011101000000000;
                Q: morse_sequence = 20'b11101110101110000000;
                R: morse_sequence = 20'b10111010000000000000;
                S: morse_sequence = 20'b10101000000000000000;
                T: morse_sequence = 20'b11100000000000000000;
                U: morse_sequence = 20'b10101110000000000000;
                V: morse_sequence = 20'b01010101110000000000;
                W: morse_sequence = 20'b10111011100000000000;
                X: morse_sequence = 20'b11101010111000000000;
                Y: morse_sequence = 20'b11101011101110000000;
                Z: morse_sequence = 20'b11101110101000000000;
     
                N0: morse_sequence = 20'b11101110111011101110;
                N1: morse_sequence = 20'b10111011101110111000;
                N2: morse_sequence = 20'b01010111011101110000;
                N3: morse_sequence = 20'b01010101110111000000;
                N4: morse_sequence = 20'b10101010111000000000;
                N5: morse_sequence = 20'b10101010100000000000;
                N6: morse_sequence = 20'b11101010101000000000;
                N7: morse_sequence = 20'b11101110101010000000;
                N8: morse_sequence = 20'b11101110111010100000;
                N9: morse_sequence = 20'b11101110111011101000;
                    
                default: morse_sequence = 20'b00000000000000000000;
        
            endcase        
        end
        else begin 
            morse_sequence = 20'b00000000000000000000;
        end
        
      end 
    
endmodule
