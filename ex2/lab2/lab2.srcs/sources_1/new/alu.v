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
    // �м����
    wire [31:0] c_add;
    wire [31:0] c_sub;
    wire [31:0] c_and;
    wire [31:0] c_or;
    wire [31:0] c_xor;
    wire [31:0] c_sll;
    wire [31:0] c_srl;
    wire [31:0] c_sra;
    // �ӷ���
    alu_add U_alu_add_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_add)
    );
    // ������
    alu_sub U_alu_sub_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sub)
    );
    // ��λ��
    alu_and U_alu_and_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_and)
    );
    // ��λ��
    assign c_or = a_i | b_i;
    // ��λ���
    assign c_xor = a_i ^ b_i;
    // �߼�����
    alu_sll U_alu_sll_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sll)
    );
    // �߼�����
    alu_srl U_alu_srl_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_srl)
    );
    // ��������
    alu_sra U_alu_sra_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sra)
    );
    // ����alu_op������������
    assign c_o = (alu_op == ALU_ADD) ? c_add : (alu_op == ALU_SUB) ? c_sub : (alu_op == ALU_AND) ? c_and : (alu_op == ALU_OR) ? c_or : (alu_op == ALU_XOR) ? c_xor : (alu_op == ALU_SLL) ? c_sll : (alu_op == ALU_SRL) ? c_srl : (alu_op == ALU_SRA) ? c_sra : 32'h0;
endmodule
