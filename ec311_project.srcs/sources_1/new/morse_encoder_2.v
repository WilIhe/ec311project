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

//inputs added to make 0 the choice for single character to morse and 1 for message to morse
module morse_encoder(
    input [6:0] encode, // 7 bit input to represent upper case letters (uppercase is larger than lower in ascii)
    input rst, clk, // clk will need to be slowed down; enable is used to confirm the ASCII input
    input mode_select, //0=single char, 1=message
    input store_btn, //for message mode between input characters
    input start_btn, // start for single char or message 
    output reg morse_code
    );

//debounce signals for rst, start, and store
    wire clean_rst;
    wire clean_store;
    wire clean_start;

//one clock pulse for store and start
    wire pulse_stored;
    wire start_pulse;

    button_debounce D_rst(.clk(clk), .button(rst), .clean(clean_rst));
    button_debounce D_start(.clk(clk), .button(start_btn), .clean(clean_start));
    button_debounce D_store(.clk(clk), .button(store_btn), .clean(clean_store));


    single_pulse store_p( .clk(clk), .rst(clean_rst), .level_in(clean_store), .out_pulse(pulse_stored)); //store btn press into a one clock pulse
    single_pulse start_p( .clk(clk), .rst(clean_rst), .level_in(clean_start), .out_pulse(start_pulse)); //start btn press into a one clock pusle

    //Message Processor portion
    reg [2:0] index_br; //selects the stored character which is being sent
    wire [6:0] processed_char; //output char from processing
    wire [2:0] msg_count; //stored characters
    wire limit_full; //high after 5 characters are stored

    message_processor MP_1(
      .clk(clk),
      .rst(clean_rst),
      .pulse_stored(mode_select ? pulse_stored : 1'b0), //store functions only if user wants to input a message
      .char_in(encode),
      .index_br(index_br),
      .char_out(processed_char),
      .count(msg_count),
      .full_message(limit_full)
    );

    wire [6:0] active_char;
    assign active_char = (mode_select) ? processed_char: encode; //character source dependent on user mode

    reg start_char; //starts a morse char
    wire morse_shift; //current morse bit from the shift input
    wire busy; //busy is high when shift input is transmitting a char
    wire done_char; //pulses when the current character is finished 

    shift_input_2 SI_2(
      .encode(active_char),
      .clk(clk),
      .rst(clean_rst),
      .start(start_char),
      .morse_shift(morse_shift),
      .busy(busy),
      .done_char(done_char)
    );

//fsm for single char vs msg, when to start, and waiting to begin, finish, or move on to next char
    reg [2:0] c_state; // (short on (dit), long on (dah)) dah = 3*dit
    parameter
      idle = 3'd0,
      start_send = 3'd1,
      wait_char = 3'd2,
      next_char = 3'd3;


//fsm for S0 is OFF, S1 is ON LED state
    reg state;
    parameter
      S0 = 1'b0, // saw '1'
      S1 = 1'b1; //  saw a '0'

    //initial values
    initial begin
      index_br = 3'd0;
      start_char = 1'b0;
      c_state = idle;
      state = S0;
      morse_code = 1'b0;
    end

    always @(posedge clk or posedge clean_rst) begin
      if (clean_rst) begin
        index_br <= 3'd0;
        start_char <= 1'b0;
        c_state <= idle;
      end
      else begin 
        case (c_state)
          idle:begin //wait until user requests a send
            index_br <= 3'd0;
            start_char <= 1'b0;
            //single char mode
            if (!mode_select) begin 
              if (start_pulse)
                c_state <= start_send;
              else 
                c_state <= idle;
            end
            else begin
              //msg mode
              if (limit_full && start_pulse)
                  c_state <= start_send;
              else   
                  c_state <= idle;
            end
        end

        start_send:begin //start_char high until shift input says busy to make sure that start is processed by the shift
            start_char <= 1'b1;
            if (busy)
              c_state <= wait_char;
            else
              c_state <= start_send;
        end

        wait_char:begin //waits until current character is finished fully, a transmission is in progress
          start_char <= 1'b0;
          if (done_char)
            c_state <= next_char;
          else 
            c_state <= wait_char;
        end

        next_char:begin //decides on next function after a character is finished 
          start_char <= 1'b0;
          if (!mode_select) begin
            c_state <= idle; //single char ends after 1 char
          end
          else begin //message mode will go through the 5 stored chars 
            if (index_br == 3'd4) begin
              index_br <= 3'd0;
              c_state <= idle;
            end
            else begin
              index_br <= index_br + 3'd1;
              c_state <= start_send;
            end
          end
        end

        default:begin
          index_br <= 3'd0;
          start_char <= 1'b0;
          c_state <= idle;
        end
      endcase
    end
  end

//fsm for morse shift of 1 LED ON, 0 LED OFF
    always @ (posedge clk or posedge clean_rst) begin 
        if (clean_rst) begin 
            morse_code <= 0;
            state <= S0;
        end
        else begin 
            case (state)
                S0: state <= (!morse_shift) ? S0 : S1; // does a zero appear on the bus?  
                S1: state <= (morse_shift) ? S1 : S0;  // does a one appear on the bus?
                default: state <= S0;       
            endcase
        
            morse_code <= (state == S1) ? 1 : 0;
        end
        //index = index - 5'b00001;
    end
    
endmodule
