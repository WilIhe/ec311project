`timescale 1ns/1ps

module message_processor(
  input clk,
  input rst,
  input pulse_stored,
  input [6:0] char_in,
  input [2:0] index_br,
  output reg [6:0] char_out, 
  output reg [2:0] count, 
  output full_message
  );

  reg [6:0] mc0, mc1, mc2, mc3, mc4;

  assign full_message = (count == 3'd5);
  initial begin 
    mc0 = 7'd0;
    mc1 = 7'd0;
    mc2 = 7'd0;
    mc3 = 7'd0;
    mc4 = 7'd0;
    count = 3'd0;
    char_out = 7'd0;
  end

  always @(posedge clk or posedge rst)
    if (rst) begin
      mc0 <= 7'd0;
      mc1 <= 7'd0;
      mc2 <= 7'd0;
      mc3 <= 7'd0;
      mc4 <= 7'd0;
      count <= 7'd0;
    end
    else if (pulse_stored && count < 3'd5) begin
      case (count)
        3'd0: mc0 <= char_in;
        3'd1: mc0 <= char_in;
        3'd2: mc0 <= char_in;
        3'd3: mc0 <= char_in;
        3'd4: mc0 <= char_in;
        default;
      endcase
      count <= count + 3'd1
    end
  end

  always @(*) begin
    case (index_br)
      3'd0 : char_out = mc0;
      3'd1 : char_out = mc1;
      3'd2 : char_out = mc2;
      3'd3 : char_out = mc3;
      3'd4 : char_out = mc4;
      default : char_out = 7'd0;
    endcase
  end
endmodule
