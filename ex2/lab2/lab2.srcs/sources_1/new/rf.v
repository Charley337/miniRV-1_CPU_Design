`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: rf
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


module rf(
    input               clk_i,
    input               rst_n_i,
    input       [4:0]   rr1_i,
    input       [4:0]   rr2_i,
    input       [4:0]   wr_i,
    input       [31:0]  wd_i,
    input               we,
    output  reg [31:0]  rd1_o,
    output  reg [31:0]  rd2_o
    );
    // ¼Ä´æÆ÷¶Ñ
    reg [31:0]  x0;
    reg [31:0]  x1;
    reg [31:0]  x2;
    reg [31:0]  x3;
    reg [31:0]  x4;
    reg [31:0]  x5;
    reg [31:0]  x6;
    reg [31:0]  x7;
    reg [31:0]  x8;
    reg [31:0]  x9;
    reg [31:0]  x10;
    reg [31:0]  x11;
    reg [31:0]  x12;
    reg [31:0]  x13;
    reg [31:0]  x14;
    reg [31:0]  x15;
    reg [31:0]  x16;
    reg [31:0]  x17;
    reg [31:0]  x18;
    reg [31:0]  x19;
    reg [31:0]  x20;
    reg [31:0]  x21;
    reg [31:0]  x22;
    reg [31:0]  x23;
    reg [31:0]  x24;
    reg [31:0]  x25;
    reg [31:0]  x26;
    reg [31:0]  x27;
    reg [31:0]  x28;
    reg [31:0]  x29;
    reg [31:0]  x30;
    reg [31:0]  x31;
    // ×éºÏÂß¼­£¬¶Á¼Ä´æÆ÷
    always @ (*) begin
        // Ò»¸ö case
        case(rr1_i)
        5'd0    :   rd1_o = x0;
        5'd1    :   rd1_o = x1;
        5'd2    :   rd1_o = x2;
        5'd3    :   rd1_o = x3;
        5'd4    :   rd1_o = x4;
        5'd5    :   rd1_o = x5;
        5'd6    :   rd1_o = x6;
        5'd7    :   rd1_o = x7;
        5'd8    :   rd1_o = x8;
        5'd9    :   rd1_o = x9;
        5'd10   :   rd1_o = x10;
        5'd11   :   rd1_o = x11;
        5'd12   :   rd1_o = x12;
        5'd13   :   rd1_o = x13;
        5'd14   :   rd1_o = x14;
        5'd15   :   rd1_o = x15;
        5'd16   :   rd1_o = x16;
        5'd17   :   rd1_o = x17;
        5'd18   :   rd1_o = x18;
        5'd19   :   rd1_o = x19;
        5'd20   :   rd1_o = x20;
        5'd21   :   rd1_o = x21;
        5'd22   :   rd1_o = x22;
        5'd23   :   rd1_o = x23;
        5'd24   :   rd1_o = x24;
        5'd25   :   rd1_o = x25;
        5'd26   :   rd1_o = x26;
        5'd27   :   rd1_o = x27;
        5'd28   :   rd1_o = x28;
        5'd29   :   rd1_o = x29;
        5'd30   :   rd1_o = x30;
        5'd31   :   rd1_o = x31;
        default;
        endcase
        // Á½¸ö case
        case(rr2_i)
        5'd0    :   rd2_o = x0;
        5'd1    :   rd2_o = x1;
        5'd2    :   rd2_o = x2;
        5'd3    :   rd2_o = x3;
        5'd4    :   rd2_o = x4;
        5'd5    :   rd2_o = x5;
        5'd6    :   rd2_o = x6;
        5'd7    :   rd2_o = x7;
        5'd8    :   rd2_o = x8;
        5'd9    :   rd2_o = x9;
        5'd10   :   rd2_o = x10;
        5'd11   :   rd2_o = x11;
        5'd12   :   rd2_o = x12;
        5'd13   :   rd2_o = x13;
        5'd14   :   rd2_o = x14;
        5'd15   :   rd2_o = x15;
        5'd16   :   rd2_o = x16;
        5'd17   :   rd2_o = x17;
        5'd18   :   rd2_o = x18;
        5'd19   :   rd2_o = x19;
        5'd20   :   rd2_o = x20;
        5'd21   :   rd2_o = x21;
        5'd22   :   rd2_o = x22;
        5'd23   :   rd2_o = x23;
        5'd24   :   rd2_o = x24;
        5'd25   :   rd2_o = x25;
        5'd26   :   rd2_o = x26;
        5'd27   :   rd2_o = x27;
        5'd28   :   rd2_o = x28;
        5'd29   :   rd2_o = x29;
        5'd30   :   rd2_o = x30;
        5'd31   :   rd2_o = x31;
        default;
        endcase
    end
    // Ê±ĞòÂß¼­£¬Ğ´¼Ä´æÆ÷
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i) begin     // ¸´Î»
            x0 <= 32'h0;
            x1 <= 32'h0;
            x2 <= 32'h0;
            x3 <= 32'h0;
            x4 <= 32'h0;
            x5 <= 32'h0;
            x6 <= 32'h0;
            x7 <= 32'h0;
            x8 <= 32'h0;
            x9 <= 32'h0;
            x10 <= 32'h0;
            x11 <= 32'h0;
            x12 <= 32'h0;
            x13 <= 32'h0;
            x14 <= 32'h0;
            x15 <= 32'h0;
            x16 <= 32'h0;
            x17 <= 32'h0;
            x18 <= 32'h0;
            x19 <= 32'h0;
            x20 <= 32'h0;
            x21 <= 32'h0;
            x22 <= 32'h0;
            x23 <= 32'h0;
            x24 <= 32'h0;
            x25 <= 32'h0;
            x26 <= 32'h0;
            x27 <= 32'h0;
            x28 <= 32'h0;
            x29 <= 32'h0;
            x30 <= 32'h0;
            x31 <= 32'h0;
        end
        else if (~we) begin     // ¶Á¼Ä´æÆ÷
            
        end
        else begin              // Ğ´¼Ä´æÆ÷
            case(wr_i)
            5'd1    :   x1 <= wd_i;
            5'd2    :   x2 <= wd_i;
            5'd3    :   x3 <= wd_i;
            5'd4    :   x4 <= wd_i;
            5'd5    :   x5 <= wd_i;
            5'd6    :   x6 <= wd_i;
            5'd7    :   x7 <= wd_i;
            5'd8    :   x8 <= wd_i;
            5'd9    :   x9 <= wd_i;
            5'd10   :   x10 <= wd_i;
            5'd11   :   x11 <= wd_i;
            5'd12   :   x12 <= wd_i;
            5'd13   :   x13 <= wd_i;
            5'd14   :   x14 <= wd_i;
            5'd15   :   x15 <= wd_i;
            5'd16   :   x16 <= wd_i;
            5'd17   :   x17 <= wd_i;
            5'd18   :   x18 <= wd_i;
            5'd19   :   x19 <= wd_i;
            5'd20   :   x20 <= wd_i;
            5'd21   :   x21 <= wd_i;
            5'd22   :   x22 <= wd_i;
            5'd23   :   x23 <= wd_i;
            5'd24   :   x24 <= wd_i;
            5'd25   :   x25 <= wd_i;
            5'd26   :   x26 <= wd_i;
            5'd27   :   x27 <= wd_i;
            5'd28   :   x28 <= wd_i;
            5'd29   :   x29 <= wd_i;
            5'd30   :   x30 <= wd_i;
            5'd31   :   x31 <= wd_i;
            default :   x0 <= 32'h0;
            endcase
        end
    end
endmodule
