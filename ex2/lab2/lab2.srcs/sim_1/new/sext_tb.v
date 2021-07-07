`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 15:13:51
// Design Name: 
// Module Name: sext_tb
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


module sext_tb();
// ���е��ź�
reg clk_cpu;
reg rst_n_i;
// PC
// ����
wire [31:0] pc_din;
// ���
wire [31:0] pc_pc;
// NPC
// ����
wire [31:0] npc_pc;
reg [31:0] npc_imm;
reg [1:0] npc_op;
// ���
wire [31:0] npc_npc;
wire [31:0] npc_pc4;
// IROM
// ����
wire [31:0] irom_adr;
// ���
wire [31:0] irom_inst;
// SEXT
// ����
wire [24:0] sext_din;
wire [2:0] sext_op;
// ���
wire [31:0] sext_ext;
// BRANCH
// ����
wire branch_ctrl;
wire branch_alu;
wire [31:0] branch_ext_i;
// ���
wire [31:0] branch_ext_o;
// RF
// ����
wire [4:0] rf_rr1;
wire [4:0] rf_rr2;
wire [4:0] rf_wr;
wire [31:0] rf_wd;
wire rf_we;
// ���
wire [31:0] rf_rd1;
wire [31:0] rf_rd2;
// ALU
// ����
wire [31:0] alu_a;
wire [31:0] alu_b;
wire [3:0] alu_op;
// ���
wire [31:0] alu_c;
wire alu_branch;
// MEMRAM
// ����
wire [31:0] dram_addr;
wire [31:0] dram_wr_data;
wire dram_memwr;
// ���
wire [31:0] dram_rd_data;
// ���Ƶ�Ԫ
// ����
wire [31:0] ctrl_inst;
// ���
wire [1:0] ctrl_npc_op;
wire ctrl_pc_sel;
wire ctrl_imm_sel;
wire [2:0] ctrl_sext_op;
wire [1:0] ctrl_wd_sel;
wire ctrl_rf_we;
wire [3:0] ctrl_alu_op;
wire ctrl_alub_sel;
wire ctrl_dram_we;
wire ctrl_branch;

// ����ģ��
control U_control_0(
    .inst_i     (ctrl_inst),
    .npc_op     (ctrl_npc_op),
    .pc_sel     (ctrl_pc_sel),
    .imm_sel    (ctrl_imm_sel),
    .sext_op    (ctrl_sext_op),
    .wd_sel     (ctrl_wd_sel),
    .rf_we      (ctrl_rf_we),
    .alu_op     (ctrl_alu_op),
    .alub_sel   (ctrl_alub_sel),
    .dram_we    (ctrl_dram_we),
    .branch_o   (ctrl_branch)
);
sext U_sext_0(
    .inst_i     (sext_din),     // inst[31:7]
    .sext_op    (sext_op),
    .ext_o      (sext_ext)
);

// ���߷�ʽ;
reg [31:0] inst_i;
assign ctrl_inst = inst_i;
assign sext_din = inst_i[31:7];
assign sext_op = ctrl_sext_op;

// �����ź�
initial begin
    #0 begin 
        clk_cpu = 0;
        rst_n_i = 0;
        inst_i = 31'hfffff4b7;
    end
end

// ʱ��
always begin
    #5 clk_cpu = ~clk_cpu;
end
endmodule
