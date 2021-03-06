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
    `define ALU_ADD         4'b0000
    `define ALU_SUB         4'b0001
    `define ALU_AND         4'b0010
    `define ALU_OR          4'b0011
    `define ALU_XOR         4'b0100
    `define ALU_SLL         4'b0101
    `define ALU_SRL         4'b0110
    `define ALU_SRA         4'b0111
    `define ALU_BEQ         4'b1000
    `define ALU_BNE         4'b1001
    `define ALU_BLT         4'b1010
    `define ALU_BGE         4'b1011
    // file: npc.v & control.v
    `define PC_ADD_4        2'b00
    `define PC_ADD_IMM      2'b01
    `define PC_IMM_JALR     2'b10
    // file: sext_neg.v & sext_pos.v
    `define I_INST_ELSE     3'b000
    `define S_INST          3'b001
    `define B_INST          3'b010
    `define U_INST          3'b011
    `define J_INST          3'b100
    `define I_INST_SLLI     3'b101
    // file: control.v
    // opcode: 
    // R:
    `define OPCODE_INST_R   7'b0110011
    // R_funct3
    `define FUNCT3_ADD_SUB  3'b000
    `define FUNCT3_AND      3'b111
    `define FUNCT3_OR       3'b110
    `define FUNCT3_XOR      3'b100
    `define FUNCT3_SLL      3'b001
    `define FUNCT3_SRL_SRA  3'b101
    // R_funct7
    `define FUNCT7_ADD      7'b0000000
    `define FUNCT7_SUB      7'b0100000
    `define FUNCT7_SRL      7'b0000000
    `define FUNCT7_SRA      7'b0100000
    // I:
    `define OPCODE_INST_I   7'b0010011
    `define OPCODE_LW       7'b0000011
    `define OPCODE_JALR     7'b1100111
    // I_funct3
    `define FUNCT3_ADDI     3'b000
    `define FUNCT3_ANDI     3'b111
    `define FUNCT3_ORI      3'b110
    `define FUNCT3_XORI     3'b100
    `define FUNCT3_SLLI     3'b001
    `define FUNCT3_SRLI_A   3'b101
    // I_funct7
    `define FUNCT7_SRLI     7'b0000000
    `define FUNCT7_SRAI     7'b0100000
    // S:
    `define OPCODE_INST_S   7'b0100011
    // B: 
    `define OPCODE_INST_B   7'b1100011
    // B_funct3
    `define FUNCT3_BEQ      3'b000
    `define FUNCT3_BNE      3'b001
    `define FUNCT3_BLT      3'b100
    `define FUNCT3_BGE      3'b101
    // U: 
    `define OPCODE_LUI      7'b0110111
    // J: 
    `define OPCODE_JAL      7'b1101111

`endif
