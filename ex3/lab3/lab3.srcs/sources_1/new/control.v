`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:34:19
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
    input               have_inst_i,
    output      [1:0]   npc_op,
    output              pc_sel,
    output              imm_sel,
    output      [2:0]   sext_op,
    output      [2:0]   wd_sel,
    output              rf_we,
    output      [4:0]   alu_op,
    output              alua_sel,       // 新
    output              alub_sel,
    output              dram_we,
    output              branch_o,
    output      [1:0]   wdin_sel        // 新
    );
    // 指令拆解
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    // 组合逻辑
    assign opcode = have_inst_i ? inst_i[6:0] : `OPCODE_INST_NOP;
    assign funct3 = inst_i[14:12];
    assign funct7 = inst_i[31:25];
    // 组合逻辑
    // npc_op
    wire npc_op_pc_add_imm;
    assign npc_op_pc_add_imm    =   (opcode == `OPCODE_INST_B) || 
                                    (opcode == `OPCODE_INST_J_JAL);
    assign npc_op               =   (opcode == `OPCODE_INST_I_JALR)     ?   `NPC_OP_PC_IMM_JALR : 
                                    (npc_op_pc_add_imm)                 ?   `NPC_OP_PC_ADD_IMM : 
                                                                            `NPC_OP_PC_ADD_4;
    // pc_sel
    assign pc_sel = (opcode == `OPCODE_INST_I_JALR);
    // imm_sel
    wire imm_sel_0;
    assign imm_sel_0    =   (opcode == `OPCODE_INST_I_JALR) || 
                            (opcode == `OPCODE_INST_J_JAL);
    assign imm_sel      =   (imm_sel_0) ?   1'b0 : 
                                            1'b1;
    // sext_op
    wire sext_op_000;
    wire sext_op_011;
    wire sext_op_101;
    wire sext_op_110;
    assign sext_op_000  =   ({funct3, opcode} == {`FUNCT3_I_ADDI, `OPCODE_INST_I}) || 
                            ({funct3, opcode} == {`FUNCT3_I_ANDI, `OPCODE_INST_I}) || 
                            ({funct3, opcode} == {`FUNCT3_I_ORI, `OPCODE_INST_I}) || 
                            ({funct3, opcode} == {`FUNCT3_I_XORI, `OPCODE_INST_I}) || 
                            ({funct3, opcode} == {`FUNCT3_I_SLTI, `OPCODE_INST_I}) || 
                            (opcode == `OPCODE_INST_I_LW) || 
                            (opcode == `OPCODE_INST_I_JALR);
    assign sext_op_101  =   ({funct3, opcode} == {`FUNCT3_I_SLLI, `OPCODE_INST_I}) || 
                            ({funct3, opcode} == {`FUNCT3_I_SRLI_A, `OPCODE_INST_I});
    assign sext_op_011  =   (opcode == `OPCODE_INST_U_LUI) || 
                            (opcode == `OPCODE_INST_U_AUIPC);
    assign sext_op_110  =   ({funct3, opcode} == {`FUNCT3_I_SLTIU, `OPCODE_INST_I});
    assign sext_op      =   (sext_op_000)                   ?   `SEXT_OP_I_INST_ELSE : 
                            (opcode == `OPCODE_INST_S)      ?   `SEXT_OP_S_INST : 
                            (opcode == `OPCODE_INST_B)      ?   `SEXT_OP_B_INST : 
                            (sext_op_011)                   ?   `SEXT_OP_U_INST : 
                            (opcode == `OPCODE_INST_J_JAL)  ?   `SEXT_OP_J_INST : 
                            (sext_op_101)                   ?   `SEXT_OP_I_INST_SLLI : 
                            (sext_op_110)                   ?   `SEXT_OP_I_INST_SLTIU : 
                                                                3'b000;
    // wd_sel
    wire wd_sel_001;
    wire wd_sel_010;
    wire wd_sel_011;
    wire wd_sel_100;
    wire wd_sel_101;
    assign wd_sel_001   =   ({funct3, opcode} == {`FUNCT3_I_LW, `OPCODE_INST_I_LW});
    assign wd_sel_010   =   ({funct3, opcode} == {`FUNCT3_I_LB, `OPCODE_INST_I_LW});
    assign wd_sel_011   =   ({funct3, opcode} == {`FUNCT3_I_LH, `OPCODE_INST_I_LW});
    assign wd_sel_100   =   (opcode == `OPCODE_INST_I_JALR) || 
                            (opcode == `OPCODE_INST_J_JAL);
    assign wd_sel_101   =   (opcode == `OPCODE_INST_U_LUI);
    assign wd_sel       =   (wd_sel_001)                    ?   3'b001 : 
                            (wd_sel_010)                    ?   3'b010 :
                            (wd_sel_011)                    ?   3'b011 : 
                            (wd_sel_100)                    ?   3'b100 : 
                            (wd_sel_101)                    ?   3'b101 : 
                                                                3'b000;
    // rf_we
    wire rf_we_0;
    assign rf_we_0  =   (opcode == `OPCODE_INST_S) || 
                        (opcode == `OPCODE_INST_B) || 
                        (opcode == `OPCODE_INST_NOP);
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
    wire alu_op_slt;
    wire alu_op_sltu;
    wire alu_op_mul;
    wire alu_op_mulh;
    wire alu_op_mulhu;
    wire alu_op_mulhsu;
    wire alu_op_div;
    wire alu_op_divu;
    wire alu_op_rem;
    wire alu_op_remu;
    wire alu_op_beq;
    wire alu_op_bne;
    wire alu_op_blt;
    wire alu_op_bge;
    wire alu_op_bltu;
    wire alu_op_bgeu;
    assign alu_op_add   =   ({funct7, funct3, opcode} == {`FUNCT7_R_ADD, `FUNCT3_R_ADD_SUB, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_ADDI, `OPCODE_INST_I}) || 
                            (opcode == `OPCODE_INST_I_LW) || 
                            (opcode == `OPCODE_INST_I_JALR) || 
                            (opcode == `OPCODE_INST_S) || 
                            (opcode == `OPCODE_INST_U_AUIPC);
    assign alu_op_sub   =   ({funct7, funct3, opcode} == {`FUNCT7_R_SUB, `FUNCT3_R_ADD_SUB, `OPCODE_INST_R});
    assign alu_op_and   =   ({funct3, opcode} == {`FUNCT3_R_AND, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_ANDI, `OPCODE_INST_I});
    assign alu_op_or    =   ({funct3, opcode} == {`FUNCT3_R_OR, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_ORI, `OPCODE_INST_I});
    assign alu_op_xor   =   ({funct3, opcode} == {`FUNCT3_R_XOR, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_XORI, `OPCODE_INST_I});
    assign alu_op_sll   =   ({funct3, opcode} == {`FUNCT3_R_SLL, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_SLLI, `OPCODE_INST_I});
    assign alu_op_srl   =   ({funct7, funct3, opcode} == {`FUNCT7_R_SRL, `FUNCT3_R_SRL_SRA, `OPCODE_INST_R}) || 
                            ({funct7, funct3, opcode} == {`FUNCT7_I_SRLI, `FUNCT3_I_SRLI_A, `OPCODE_INST_I});
    assign alu_op_sra   =   ({funct7, funct3, opcode} == {`FUNCT7_R_SRA, `FUNCT3_R_SRL_SRA, `OPCODE_INST_R}) || 
                            ({funct7, funct3, opcode} == {`FUNCT7_I_SRAI, `FUNCT3_I_SRLI_A, `OPCODE_INST_I});
    assign alu_op_slt   =   ({funct3, opcode} == {`FUNCT3_R_SLT, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_SLTI, `OPCODE_INST_I});
    assign alu_op_sltu  =   ({funct3, opcode} == {`FUNCT3_R_SLTU, `OPCODE_INST_R}) || 
                            ({funct3, opcode} == {`FUNCT3_I_SLTIU, `OPCODE_INST_I});
    assign alu_op_mul   =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_MUL, `OPCODE_INST_R});
    assign alu_op_mulh  =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_MULH, `OPCODE_INST_R});
    assign alu_op_mulhu =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_MULHU, `OPCODE_INST_R});
    assign alu_op_mulhsu =  ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_MULHSU, `OPCODE_INST_R});
    assign alu_op_div   =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_DIV, `OPCODE_INST_R});
    assign alu_op_divu  =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_DIVU, `OPCODE_INST_R});
    assign alu_op_rem   =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_REM, `OPCODE_INST_R});
    assign alu_op_remu  =   ({funct7, funct3, opcode} == {`FUNCT7_R_MDR, `FUNCT3_R_REMU, `OPCODE_INST_R});
    assign alu_op_beq   =   ({funct3, opcode} == {`FUNCT3_B_BEQ, `OPCODE_INST_B});
    assign alu_op_bne   =   ({funct3, opcode} == {`FUNCT3_B_BNE, `OPCODE_INST_B});
    assign alu_op_blt   =   ({funct3, opcode} == {`FUNCT3_B_BLT, `OPCODE_INST_B});
    assign alu_op_bge   =   ({funct3, opcode} == {`FUNCT3_B_BGE, `OPCODE_INST_B});
    assign alu_op_bltu  =   ({funct3, opcode} == {`FUNCT3_B_BLTU, `OPCODE_INST_B});
    assign alu_op_bgeu  =   ({funct3, opcode} == {`FUNCT3_B_BGEU, `OPCODE_INST_B});
    assign alu_op       =   alu_op_add      ?   `ALU_OP_ADD : 
                            alu_op_sub      ?   `ALU_OP_SUB : 
                            alu_op_and      ?   `ALU_OP_AND : 
                            alu_op_or       ?   `ALU_OP_OR : 
                            alu_op_xor      ?   `ALU_OP_XOR : 
                            alu_op_sll      ?   `ALU_OP_SLL : 
                            alu_op_srl      ?   `ALU_OP_SRL : 
                            alu_op_sra      ?   `ALU_OP_SRA : 
                            alu_op_slt      ?   `ALU_OP_SLT : 
                            alu_op_sltu     ?   `ALU_OP_SLTU : 
                            alu_op_mul      ?   `ALU_OP_MUL : 
                            alu_op_mulh     ?   `ALU_OP_MULH : 
                            alu_op_mulhu    ?   `ALU_OP_MULHU : 
                            alu_op_mulhsu   ?   `ALU_OP_MULHSU : 
                            alu_op_div      ?   `ALU_OP_DIV : 
                            alu_op_divu     ?   `ALU_OP_DIVU : 
                            alu_op_rem      ?   `ALU_OP_REM : 
                            alu_op_remu     ?   `ALU_OP_REMU : 
                            alu_op_beq      ?   `ALU_OP_BEQ : 
                            alu_op_bne      ?   `ALU_OP_BNE : 
                            alu_op_blt      ?   `ALU_OP_BLT : 
                            alu_op_bge      ?   `ALU_OP_BGE : 
                            alu_op_bltu     ?   `ALU_OP_BLTU : 
                            alu_op_bgeu     ?   `ALU_OP_BGEU : 
                                                `ALU_OP_ADD;
    // alua_sel
    assign alua_sel     =   (opcode == `OPCODE_INST_U_AUIPC);
    // alub_sel
    assign alub_sel     =   (opcode == `OPCODE_INST_I) || 
                            (opcode == `OPCODE_INST_I_LW) || 
                            (opcode == `OPCODE_INST_S) || 
                            (opcode == `OPCODE_INST_U_AUIPC);
    // dram_we
    assign dram_we  =   (opcode == `OPCODE_INST_S);
    // branch_o     如果 have_inst_i 是 0, 那么 branch_o 输出为 0 
    assign branch_o =   (opcode == `OPCODE_INST_B) & have_inst_i;
    // wdin_sel
    wire wdin_sel_00;
    wire wdin_sel_01;
    wire wdin_sel_10;
    assign wdin_sel_00  =   ({funct3, opcode} == {`FUNCT3_S_SW, `OPCODE_INST_S});
    assign wdin_sel_01  =   ({funct3, opcode} == {`FUNCT3_S_SB, `OPCODE_INST_S});
    assign wdin_sel_10  =   ({funct3, opcode} == {`FUNCT3_S_SH, `OPCODE_INST_S});
    assign wdin_sel     =   wdin_sel_00     ?   2'b00 : 
                            wdin_sel_01     ?   2'b01 : 
                            wdin_sel_10     ?   2'b10 : 
                                                2'b00;
endmodule
