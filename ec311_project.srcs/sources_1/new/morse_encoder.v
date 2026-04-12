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
    input rst, clk, // clk will need to be slowed down
    output morse_code
    );
    // Need a way to stop the output from trying to start if the user is still changing the inputs
    
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
    Z=7'b1011010; // 90
    
    always @ (posedge clk) begin
        
        case (encode)
//            A:
//            B:
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
    
    end
    
    
endmodule
