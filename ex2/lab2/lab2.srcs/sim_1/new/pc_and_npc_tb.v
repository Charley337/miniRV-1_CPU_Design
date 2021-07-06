`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 09:41:36
// Design Name: 
// Module Name: module_testbench_tb
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


module pc_and_npc_tb();
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
wire [31:0] sext_din;
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
// PC �� NPC ����ģ��
pc U_pc_0(
    .clk_i              (clk_cpu),
    .rst_n_i            (rst_n_i),
    .din_i              (pc_din),
    .pc_o               (pc_pc)
);
npc U_npc_0(
    .pc_i               (npc_pc),
    .imm_i              (npc_imm),
    .npc_op             (npc_op),
    .npc_o              (npc_npc),
    .pc4_o              (npc_pc4)
);

// ���߷�ʽ
// PC �� NPC ����ģ��
assign pc_din = npc_npc;
assign npc_pc = pc_pc;

// �����ź�
// PC �� NPC ����ģ��
initial begin
    #0 begin 
        rst_n_i = 0;
        clk_cpu = 0;
        npc_op = 2'b00;
        npc_imm = 32'h44;
    end
    #25 begin
        rst_n_i = 1;
    end
    #50 begin 
        npc_op = 2'b01;
    end
end

// ʱ��
always begin
    #5 clk_cpu = ~clk_cpu;
end

endmodule
