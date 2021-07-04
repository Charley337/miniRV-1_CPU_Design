// 
// file: param.v
// TODO: �������̵ĳ����궨��
// �÷�: 
//      ����1: �� vivado ������Ϊȫ������ ( �Ƽ� )
//      ����2: ����Ҫ���õ�Դ�ļ�ͷ����һ�δ���: `include "param.v" ( ���ڴ���淶�Կ��ǣ����Ƽ� )
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
