`timescale 1ns/1ps

module single_pulse(
  input clk, input rst, 
  input level_in, 
  output reg out_pulse 
  );

  reg prev;

  initial begin
    prev = 0;
    out_pulse = 0;
  end

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      prev <= 0;
      out_pulse <= 0;
    end
    else begin
      out_pulse <= level_in & ~prev;
      prev <= level_in;
    end
  end
endmodule
