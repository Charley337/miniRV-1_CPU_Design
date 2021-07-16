`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:37:19
// Design Name: 
// Module Name: alu_sra
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


module alu_sra(
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

    wire [30:0] x_0;
    wire [30:0] x_1;
    wire [30:0] x_2;
    wire [30:0] x_3;
    wire [30:0] x_4;

    wire [30:0] y_0;
    wire [30:0] y_1;
    wire [30:0] y_2;
    wire [30:0] y_3;
    wire [30:0] y_4;
    // 组合逻辑
    assign x_0 = a_i[31] ? 31'b100_0000_0000_0000_0000_0000_0000_0000 : 31'b0;
    assign x_1 = a_i[31] ? 31'b110_0000_0000_0000_0000_0000_0000_0000 : 31'b0;
    assign x_2 = a_i[31] ? 31'b111_1000_0000_0000_0000_0000_0000_0000 : 31'b0;
    assign x_3 = a_i[31] ? 31'b111_1111_1000_0000_0000_0000_0000_0000 : 31'b0;
    assign x_4 = a_i[31] ? 31'b111_1111_1111_1111_1000_0000_0000_0000 : 31'b0;

    assign y_0 = (a_i[30:0] >> 32'h0000_0001) + x_0;
    assign y_1 = (c_0[30:0] >> 32'h0000_0002) + x_1;
    assign y_2 = (c_1[30:0] >> 32'h0000_0004) + x_2;
    assign y_3 = (c_2[30:0] >> 32'h0000_0008) + x_3;
    assign y_4 = (c_3[30:0] >> 32'h0000_0010) + x_4;

    assign c_0 = b_i[0] ? {a_i[31], y_0} : a_i;
    assign c_1 = b_i[1] ? {c_0[31], y_1} : c_0;
    assign c_2 = b_i[2] ? {c_1[31], y_2} : c_1;
    assign c_3 = b_i[3] ? {c_2[31], y_3} : c_2;
    assign c_4 = b_i[4] ? {c_3[31], y_4} : c_3;
    assign c_o = c_4;
endmodule
