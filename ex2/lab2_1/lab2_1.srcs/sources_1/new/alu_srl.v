`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 23:18:56
// Design Name: 
// Module Name: alu_srl
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


module alu_srl(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    output      [31:0]  c_o
    );
    // 中间变量
    wire [31:0] c_0;
    wire [31:0] c_1;
    wire [31:0] c_2;
    wire [31:0] c_3;
    wire [31:0] c_4;
    wire [31:0] c_5;
    wire [31:0] c_6;
    wire [31:0] c_7;
    wire [31:0] c_8;
    wire [31:0] c_9;
    wire [31:0] c_10;
    wire [31:0] c_11;
    wire [31:0] c_12;
    wire [31:0] c_13;
    wire [31:0] c_14;
    wire [31:0] c_15;
    wire [31:0] c_16;
    wire [31:0] c_17;
    wire [31:0] c_18;
    wire [31:0] c_19;
    wire [31:0] c_20;
    wire [31:0] c_21;
    wire [31:0] c_22;
    wire [31:0] c_23;
    wire [31:0] c_24;
    wire [31:0] c_25;
    wire [31:0] c_26;
    wire [31:0] c_27;
    wire [31:0] c_28;
    wire [31:0] c_29;
    wire [31:0] c_30;
    wire [31:0] c_31;
    // 组合逻辑
    assign c_0 = b_i[0] ? (a_i >> 32'h0000_0001) : a_i;
    assign c_1 = b_i[1] ? (c_0 >> 32'h0000_0002) : c_0;
    assign c_2 = b_i[2] ? (c_1 >> 32'h0000_0004) : c_1;
    assign c_3 = b_i[3] ? (c_2 >> 32'h0000_0008) : c_2;
    assign c_4 = b_i[4] ? (c_3 >> 32'h0000_0010) : c_3;
    assign c_5 = b_i[5] ? (c_4 >> 32'h0000_0020) : c_4;
    assign c_6 = b_i[6] ? (c_5 >> 32'h0000_0040) : c_5;
    assign c_7 = b_i[7] ? (c_6 >> 32'h0000_0080) : c_6;
    assign c_8 = b_i[8] ? (c_7 >> 32'h0000_0100) : c_7;
    assign c_9 = b_i[9] ? (c_8 >> 32'h0000_0200) : c_8;
    assign c_10 = b_i[10] ? (c_9 >> 32'h0000_0400) : c_9;
    assign c_11 = b_i[11] ? (c_10 >> 32'h0000_0800) : c_10;
    assign c_12 = b_i[12] ? (c_11 >> 32'h0000_1000) : c_11;
    assign c_13 = b_i[13] ? (c_12 >> 32'h0000_2000) : c_12;
    assign c_14 = b_i[14] ? (c_13 >> 32'h0000_4000) : c_13;
    assign c_15 = b_i[15] ? (c_14 >> 32'h0000_8000) : c_14;
    assign c_16 = b_i[16] ? (c_15 >> 32'h0001_0000) : c_15;
    assign c_17 = b_i[17] ? (c_16 >> 32'h0002_0000) : c_16;
    assign c_18 = b_i[18] ? (c_17 >> 32'h0004_0000) : c_17;
    assign c_19 = b_i[19] ? (c_18 >> 32'h0008_0000) : c_18;
    assign c_20 = b_i[20] ? (c_19 >> 32'h0010_0000) : c_19;
    assign c_21 = b_i[21] ? (c_20 >> 32'h0020_0000) : c_20;
    assign c_22 = b_i[22] ? (c_21 >> 32'h0040_0000) : c_21;
    assign c_23 = b_i[23] ? (c_22 >> 32'h0080_0000) : c_22;
    assign c_24 = b_i[24] ? (c_23 >> 32'h0100_0000) : c_23;
    assign c_25 = b_i[25] ? (c_24 >> 32'h0200_0000) : c_24;
    assign c_26 = b_i[26] ? (c_25 >> 32'h0400_0000) : c_25;
    assign c_27 = b_i[27] ? (c_26 >> 32'h0800_0000) : c_26;
    assign c_28 = b_i[28] ? (c_27 >> 32'h1000_0000) : c_27;
    assign c_29 = b_i[29] ? (c_28 >> 32'h2000_0000) : c_28;
    assign c_30 = b_i[30] ? (c_29 >> 32'h4000_0000) : c_29;
    assign c_31 = b_i[31] ? (c_30 >> 32'h8000_0000) : c_30;
    assign c_o = c_31;
endmodule
