`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 15:15:50
// Design Name: 
// Module Name: alu
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


module alu(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    input       [3:0]   alu_op,
    input               branch,
    output      [31:0]  c_o
    );
    // 中间变量
    wire [31:0] c_add;
    wire [31:0] c_sub;
    wire [31:0] c_and;
    wire [31:0] c_or;
    wire [31:0] c_xor;
    wire [31:0] c_sll;
    wire [31:0] c_srl;
    wire [31:0] c_sra;
    // 加法器
    alu_add U_alu_add_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_add)
    );
    // 减法器
    alu_sub U_alu_sub_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sub)
    );
    // 按位与
    alu_and U_alu_and_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_and)
    );
    // 按位或
    assign c_or = a_i | b_i;
    // 按位异或
    assign c_xor = a_i ^ b_i;
    // 逻辑左移
    alu_sll U_alu_sll_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sll)
    );
    // 逻辑右移
    alu_srl U_alu_srl_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_srl)
    );
    // 算术右移
    alu_sra U_alu_sra_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sra)
    );
    // 根据alu_op决定何种运算
    assign c_o = (alu_op == ALU_ADD) ? alu_add : (alu_op == ALU_SUB) ? alu_sub : (alu_op == ALU_AND) ? alu_and : (alu_op == ALU_OR) ? alu_or : (alu_op == ALU_XOR) ? alu_xor : (alu_op == ALU_SLL) ? alu_sll : (alu_op == SRL) ? alu_srl : (alu_op == ALU_SRA) ? alu_sra : 32'h0;
endmodule
