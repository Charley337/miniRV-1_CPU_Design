`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:34:04
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
    input       [4:0]   alu_op,
    output              branch_o,
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
    wire [31:0] c_slt;
    wire [31:0] c_sltu;
    wire [31:0] c_mul;
    wire [31:0] c_mulh;
    wire [31:0] c_mulhu;
    wire [31:0] c_mulhsu;
    wire [31:0] c_div;
    wire [31:0] c_divu;
    wire [31:0] c_rem;
    wire [31:0] c_remu;
    // branch中间变量
    wire branch_beq;
    wire branch_bne;
    wire branch_blt;
    wire branch_bge;
    wire branch_bltu;
    wire branch_bgeu;
    
    // 加法
    assign c_add = a_i + b_i;
    
    // 减法
    alu_sub U_alu_sub_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sub)
    );
    
    // and
    assign c_and = a_i & b_i;
    
    // or
    assign c_or = a_i | b_i;
    
    // xor
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
    
    // slt
    assign c_slt = {31'h0, c_sub[31]};
    
    // sltu
    assign c_sltu = (a_i < b_i);
    
    // 乘法 mul
    alu_mul U_alu_mul_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_mul)
    );
    
    // 乘法 mulh
    
    
    // 乘法 mulhu
    
    
    // 乘法 mulhsu
    
    
    // 除法 div
    
    
    // 除法 divu
    
    
    // 余数 rem
    
    
    // 余数 remu
    
    
    // beq
    assign branch_beq =     (a_i == b_i);
    
    // bne
    assign branch_bne =     ~branch_beq;
    
    // blt
    assign branch_blt =     c_sub[31];
    
    // bge
    assign branch_bge =     ~branch_blt;
    
    // bltu
    assign branch_bltu =    (a_i < b_i);
    
    // bgeu
    assign branch_bgeu =    ~branch_bltu;
    
    // 根据 alu_op 决定何种运算
    assign c_o =            (alu_op == `ALU_ADD)    ?   c_add : 
                            (alu_op == `ALU_SUB)    ?   c_sub : 
                            (alu_op == `ALU_AND)    ?   c_and : 
                            (alu_op == `ALU_OR)     ?   c_or : 
                            (alu_op == `ALU_XOR)    ?   c_xor : 
                            (alu_op == `ALU_SLL)    ?   c_sll : 
                            (alu_op == `ALU_SRL)    ?   c_srl : 
                            (alu_op == `ALU_SRA)    ?   c_sra : 
                            (alu_op == `ALU_SLT)    ?   c_slt : 
                            (alu_op == `ALU_SLTU)   ?   c_sltu : 
                            (alu_op == `ALU_MUL)    ?   c_mul : 
                            (alu_op == `ALU_MULH)   ?   c_mulh : 
                            (alu_op == `ALU_MULHU)  ?   c_mulhu : 
                            (alu_op == `ALU_MULHSU) ?   c_mulhsu : 
                            (alu_op == `ALU_DIV)    ?   c_div : 
                            (alu_op == `ALU_DIVU)   ?   c_divu : 
                            (alu_op == `ALU_REM)    ?   c_rem : 
                            (alu_op == `ALU_REMU)   ?   c_remu : 
                                                        32'h0;
    
    assign branch_o =       (alu_op == `ALU_BEQ)    ?   branch_beq : 
                            (alu_op == `ALU_BNE)    ?   branch_bne : 
                            (alu_op == `ALU_BLT)    ?   branch_blt : 
                            (alu_op == `ALU_BGE)    ?   branch_bge : 
                            (alu_op == `ALU_BLTU)   ?   branch_bltu : 
                            (alu_op == `ALU_BGEU)   ?   branch_bgeu : 
                                                        1'b0;
endmodule
