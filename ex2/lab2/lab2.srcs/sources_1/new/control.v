`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 01:48:25
// Design Name: 
// Module Name: control
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


module control(
    input       [31:0]  inst_i,
    output      [1:0]   npc_op,
    output              pc_sel,
    output              imm_sel,
    output      [2:0]   sext_op,
    output      [1:0]   wd_sel,
    output              rf_we,
    output      [3:0]   alu_op,
    output              alub_sel,
    output              dram_we,
    output              branch_o
    );
    // 指令拆解
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    // 组合逻辑
    assign opcode = inst_i[6:0];
    assign funct3 = inst_i[14:12];
    assign funct7 = inst_i[31:25];
    // 组合逻辑
    // npc_op
    wire npc_op_pc_add_imm;
    assign npc_op_pc_add_imm    =   (opcode == `OPCODE_INST_B) || 
                                    (opcode == `OPCODE_JAL);
    assign npc_op               =   (opcode == `OPCODE_JALR)    ?   `PC_IMM_JALR : 
                                    (npc_op_pc_add_imm)         ?   `PC_ADD_IMM : 
                                                                    `PC_ADD_4;
    // pc_sel
    assign pc_sel = (opcode == `OPCODE_JALR)    ?   1'b1 : 
                                                    1'b0;
    // imm_sel
    wire imm_sel_0;
    assign imm_sel_0    =   (opcode == `OPCODE_JALR) || 
                            (opcode == `OPCODE_JAL);
    assign imm_sel      =   (imm_sel_0) ?   1'b0 : 
                                            1'b1;
    // sext_op
    wire sext_op_000;
    assign sext_op_000  =   (opcode == `OPCODE_INST_I) || 
                            (opcode == `OPCODE_LW) || 
                            (opcode == `OPCODE_JALR);
    assign sext_op      =   (sext_op_000)               ?   3'b000 : 
                            (opcode == `OPCODE_INST_S)  ?   3'b001 : 
                            (opcode == `OPCODE_INST_B)  ?   3'b010 : 
                            (opcode == `OPCODE_LUI)     ?   3'b011 : 
                            (opcode == `OPCODE_JAL)     ?   3'b100 : 
                                                            3'b000;
    // wd_sel
    wire wd_sel_10;
    assign wd_sel_10    =   (opcode == `OPCODE_JALR) || 
                            (opcode == `OPCODE_JAL);
    assign wd_sel       =   (opcode == `OPCODE_LW)  ?   2'b01 : 
                            (wd_sel_10)             ?   2'b10 : 
                            (opcode == `OPCODE_LUI) ?   2'b11 : 
                                                        2'b00;
    // rf_we
    wire rf_we_0;
    assign rf_we_0  =   (opcode == `OPCODE_INST_S) || 
                        (opcode == `OPCODE_INST_B);
    assign rf_we    =   (rf_we_0)   ?   1'b0 : 
                                        1'b1;
    // alu_op
    wire alu_op_add;
    wire alu_op_sub;
    wire alu_op_and;
    wire alu_op_or;
    wire alu_op_xor;
    wire alu_op_sll;
    wire alu_op_srl;
    wire alu_op_sra;
    wire alu_op_beq;
    wire alu_op_bne;
    wire alu_op_blt;
    wire alu_op_bge;
    assign alu_op_add   =   ({funct7, funct3, opcode} == {`FUNCT7_ADD, `FUNCT3_ADD_SUB, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_ADDI, `OPCODE_INST_I}) || 
                            (opcode == `OPCODE_LW) || 
                            (opcode == `OPCODE_JALR) || 
                            (opcode == `OPCODE_INST_S);
    assign alu_op_sub   =   ({funct7, funct3, opcode} == {`FUNCT7_SUB, `FUNCT3_ADD_SUB, `OPCODE_INST_R});
    assign alu_op_and   =   ({funct3, opcode} == {`FUNCT3_AND, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_ANDI, `OPCODE_INST_I});
    assign alu_op_or    =   ({funct3, opcode} == {`FUNCT3_OR, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_ORI, `OPCODE_INST_I});
    assign alu_op_xor   =   ({funct3, opcode} == {`FUNCT3_XOR, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_XORI, `OPCODE_INST_I});
    assign alu_op_sll   =   ({funct3, opcode} == {`FUNCT3_SLL, `OPCODE_INST_R}) || 
                            ({funct3,opcode} == {`FUNCT3_SLLI, `OPCODE_INST_I});
    assign alu_op_srl   =   ({funct7, funct3, opcode} == {`FUNCT7_SRL, `FUNCT3_SRL_SRA, `OPCODE_INST_R}) || 
                            ({funct7, funct3, opcode} == {`FUNCT7_SRLI, `FUNCT3_SRLI_A, `OPCODE_INST_I});
    assign alu_op_sra   =   ({funct7, funct3, opcode} == {`FUNCT7_SRA, `FUNCT3_SRL_SRA, `OPCODE_INST_R}) || 
                            ({funct7, funct3, opcode} == {`FUNCT7_SRAI, `FUNCT3_SRLI_A, `OPCODE_INST_I});
    assign alu_op_beq   =   ({funct3, opcode} == {`FUNCT3_BEQ, `OPCODE_INST_B});
    assign alu_op_bne   =   ({funct3, opcode} == {`FUNCT3_BNE, `OPCODE_INST_B});
    assign alu_op_blt   =   ({funct3, opcode} == {`FUNCT3_BLT, `OPCODE_INST_B});
    assign alu_op_bge   =   ({funct3, opcode} == {`FUNCT3_BGE, `OPCODE_INST_B});
    assign alu_op       =   alu_op_add  ?   `ALU_ADD : 
                            alu_op_sub  ?   `ALU_SUB : 
                            alu_op_and  ?   `ALU_AND : 
                            alu_op_or   ?   `ALU_OR : 
                            alu_op_xor  ?   `ALU_XOR : 
                            alu_op_sll  ?   `ALU_SLL : 
                            alu_op_srl  ?   `ALU_SRL : 
                            alu_op_sra  ?   `ALU_SRA : 
                            alu_op_beq  ?   `ALU_BEQ : 
                            alu_op_bne  ?   `ALU_BNE : 
                            alu_op_blt  ?   `ALU_BLT : 
                            alu_op_bge  ?   `ALU_BGE : 
                                            `ALU_ADD;
    // alub_sel
    wire alub_sel_1;
    assign alub_sel_1   =   (opcode == `OPCODE_INST_I) || 
                            (opcode == `OPCODE_LW) || 
                            (opcode == `OPCODE_INST_S);
    assign alub_sel     =   (alub_sel_1)    ?   1'b1 : 
                                                1'b0;
    // dram_we
    assign dram_we  =   (opcode == `OPCODE_INST_S)  ?   1'b1 : 
                                                        1'b0;
    // branch_o
    assign branch_o =   (opcode == `OPCODE_INST_B)  ?   1'b1 : 
                                                        1'b0;
endmodule
