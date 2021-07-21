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
    // alu_op
    `define ALU_OP_ADD      5'b00000
    `define ALU_OP_SUB      5'b00001
    `define ALU_OP_AND      5'b00010
    `define ALU_OP_OR       5'b00011
    `define ALU_OP_XOR      5'b00100
    `define ALU_OP_SLL      5'b00101
    `define ALU_OP_SRL      5'b00110
    `define ALU_OP_SRA      5'b00111
    `define ALU_OP_SLT      5'b01000
    `define ALU_OP_SLTU     5'b01001
    `define ALU_OP_MUL      5'b01010
    `define ALU_OP_MULH     5'b01011
    `define ALU_OP_MULHU    5'b01100
    `define ALU_OP_MULHSU   5'b01101
    `define ALU_OP_DIV      5'b01110
    `define ALU_OP_DIVU     5'b01111
    `define ALU_OP_REM      5'b10000
    `define ALU_OP_REMU     5'b10001
    `define ALU_OP_BEQ      5'b10010
    `define ALU_OP_BNE      5'b10011
    `define ALU_OP_BLT      5'b10100
    `define ALU_OP_BGE      5'b10101
    `define ALU_OP_BLTU     5'b10110
    `define ALU_OP_BGEU     5'b10111
    // file: npc.v & control.v
    // npc_op
    `define NPC_OP_PC_ADD_4        2'b00
    `define NPC_OP_PC_ADD_IMM      2'b01
    `define NPC_OP_PC_IMM_JALR     2'b10
    // file: sext_neg.v & sext_pos.v
    // sext_op
    `define SEXT_OP_I_INST_ELSE     3'b000
    `define SEXT_OP_S_INST          3'b001
    `define SEXT_OP_B_INST          3'b010
    `define SEXT_OP_U_INST          3'b011
    `define SEXT_OP_J_INST          3'b100
    `define SEXT_OP_I_INST_SLLI     3'b101
    `define SEXT_OP_I_INST_SLTIU    3'b110
    
    // file: control.v
    // opcode: 
    // 空指令
    `define OPCODE_INST_NOP     7'b0000000
    // R:
    `define OPCODE_INST_R   7'b0110011
    // R_funct3
    `define FUNCT3_R_ADD_SUB  3'b000
    `define FUNCT3_R_AND      3'b111
    `define FUNCT3_R_OR       3'b110
    `define FUNCT3_R_XOR      3'b100
    `define FUNCT3_R_SLL      3'b001
    `define FUNCT3_R_SRL_SRA  3'b101
    `define FUNCT3_R_SLT      3'b010
    `define FUNCT3_R_SLTU     3'b011
    
    `define FUNCT3_R_MUL      3'b000
    `define FUNCT3_R_MULH     3'b001
    `define FUNCT3_R_MULHSU   3'b010
    `define FUNCT3_R_MULHU    3'b011
    `define FUNCT3_R_DIV      3'b100
    `define FUNCT3_R_DIVU     3'b101
    `define FUNCT3_R_REM      3'b110
    `define FUNCT3_R_REMU     3'b111
    // R_funct7
    `define FUNCT7_R_ADD      7'b0000000
    `define FUNCT7_R_SUB      7'b0100000
    `define FUNCT7_R_SRL      7'b0000000
    `define FUNCT7_R_SRA      7'b0100000
    `define FUNCT7_R_MDR      7'b0000001
    // I:
    `define OPCODE_INST_I           7'b0010011
    `define OPCODE_INST_I_LW        7'b0000011
    `define OPCODE_INST_I_JALR      7'b1100111
    // I_funct3
    `define FUNCT3_I_ADDI     3'b000
    `define FUNCT3_I_ANDI     3'b111
    `define FUNCT3_I_ORI      3'b110
    `define FUNCT3_I_XORI     3'b100
    `define FUNCT3_I_SLLI     3'b001
    `define FUNCT3_I_SRLI_A   3'b101
    `define FUNCT3_I_SLTI     3'b010
    `define FUNCT3_I_SLTIU    3'b011
    `define FUNCT3_I_LB       3'b000
    `define FUNCT3_I_LH       3'b001
    `define FUNCT3_I_LW       3'b010
    // I_funct7
    `define FUNCT7_I_SRLI     7'b0000000
    `define FUNCT7_I_SRAI     7'b0100000
    // S:
    `define OPCODE_INST_S   7'b0100011
    // S_funct3
    `define FUNCT3_S_SB     3'b000
    `define FUNCT3_S_SH     3'b001
    `define FUNCT3_S_SW     3'b010
    // B: 
    `define OPCODE_INST_B   7'b1100011
    // B_funct3
    `define FUNCT3_B_BEQ      3'b000
    `define FUNCT3_B_BNE      3'b001
    `define FUNCT3_B_BLT      3'b100
    `define FUNCT3_B_BGE      3'b101
    `define FUNCT3_B_BLTU     3'b110
    `define FUNCT3_B_BGEU     3'b111
    // U: 
    `define OPCODE_INST_U_LUI      7'b0110111
    `define OPCODE_INST_U_AUIPC    7'b0010111
    // J: 
    `define OPCODE_INST_J_JAL      7'b1101111

`endif
