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
