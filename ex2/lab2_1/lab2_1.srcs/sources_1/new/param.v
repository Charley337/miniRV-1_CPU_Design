// 
// file: param.v
// TODO: 整个工程的常量宏定义
// 用法: 
//      方法1: 在 vivado 中设置为全局引用 ( 推荐 )
//      方法2: 在需要引用的源文件头加上一段代码: `include "param.v" ( 出于代码规范性考虑，不推荐 )
// 

`ifndef CPU_PARAM
`define CPU_PARAM

    // syntax: `define <macro name> <parameter>
    // file: alu.v
    `define ALU_ADD         3'b000
    `define ALU_SUB         3'b001
    `define ALU_AND         3'b010
    `define ALU_OR          3'b011
    `define ALU_XOR         3'b100
    `define ALU_SLL         3'b101
    `define ALU_SRL         3'b110
    `define ALU_SRA         3'b111
    // file: npc.v
    `define PC_ADD_4        2'b00
    `define PC_ADD_IMM      2'b01
    `define PC_IMM_JALR     2'b10
    // file: sext_neg.v & sext_pos.v
    `define I_INST          3'b000
    `define S_INST          3'b001
    `define B_INST          3'b010
    `define U_INST          3'b011
    `define J_INST          3'b100

`endif
