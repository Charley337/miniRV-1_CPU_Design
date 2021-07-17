`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:32:22
// Design Name: 
// Module Name: cpu
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


module cpu(
    input           clk_cpu,
    input           rst_n_i,
    input   [31:0]  irom_inst,              // ��irom������ָ��
    input   [31:0]  dram_rdata,             // ��dram����������
    output  [31:0]  irom_addr,              // �����irom�ĵ�ַ
    output  [31:0]  dram_addr,              // �����dram�ĵ�ַ
    output  [31:0]  dram_wdata,             // �����dram��д����
    output          dram_we,                // �����dram�Ķ�д�����ź�
    // �����õ�����ź�
    output          debug_wb_have_inst,
    output  [31:0]  debug_wb_pc,
    output          debug_wb_ena,
    output  [4:0]   debug_wb_reg,
    output  [31:0]  debug_wb_value,
    output  [31:0]  debug_reg_x19
    );
    // �����ź�
    // ȡַ IF
    // PC
    // ����
    wire [31:0] pc_din;
    // ���
    wire [31:0] pc_pc;
    wire [31:0] pc_pc4;
    
    // IF/ID �Ĵ���
    // ����
    wire [31:0] if_id_pc4_i;
    wire [31:0] if_id_inst_i;
    wire [31:0] if_id_pc_i;
    // ���
    wire [31:0] if_id_pc4_o;
    wire [31:0] if_id_inst_o;
    wire [31:0] if_id_pc_o;
    
    // ���� ID
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
    // SEXT
    // ����
    wire [24:0] sext_inst;
    wire [2:0] sext_op;
    // ���
    wire [31:0] sext_ext;
    // CONTROL
    // ����
    wire [31:0] ctrl_inst;
    // ���
    wire [1:0] ctrl_npc_op;
    wire ctrl_pc_sel;
    wire ctrl_imm_sel;
    wire [2:0] ctrl_sext_op;
    wire [2:0] ctrl_wd_sel;
    wire ctrl_rf_we;
    wire [4:0] ctrl_alu_op;
    wire ctrl_alua_sel;
    wire ctrl_alub_sel;
    wire ctrl_dram_we;
    wire ctrl_branch;
    wire [1:0] ctrl_wdin_sel;
    
    // ID/EX �Ĵ���
    // ����
    wire [31:0] id_ex_rd1_i;
    wire [31:0] id_ex_rd2_i;
    wire [31:0] id_ex_ext_i;
    wire [31:0] id_ex_pc_i;
    wire [31:0] id_ex_pc4_i;
    wire [4:0] id_ex_alu_op_i;
    wire id_ex_alua_sel_i;
    wire id_ex_alub_sel_i;
    wire id_ex_branch_ctrl_i;
    wire id_ex_pc_sel_i;
    wire [1:0] id_ex_npc_op_i;
    wire id_ex_imm_sel_i;
    wire id_ex_dram_we_i;
    wire [1:0] id_ex_wdin_sel_i;
    wire id_ex_rf_we_i;
    wire [2:0] id_ex_wd_sel_i;
    // ���
    wire [31:0] id_ex_rd1_o;
    wire [31:0] id_ex_rd2_o;
    wire [31:0] id_ex_ext_o;
    wire [31:0] id_ex_pc_o;
    wire [31:0] id_ex_pc4_o;
    wire [4:0] id_ex_alu_op_o;
    wire id_ex_alua_sel_o;
    wire id_ex_alub_sel_o;
    wire id_ex_branch_ctrl_o;
    wire id_ex_pc_sel_o;
    wire [1:0] id_ex_npc_op_o;
    wire id_ex_imm_sel_o;
    wire id_ex_dram_we_o;
    wire [1:0] id_ex_wdin_sel_o;
    wire id_ex_rf_we_o;
    wire [2:0] id_ex_wd_sel_o;
    
    // ִ�� EX
    // ALU
    // ����
    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire [4:0] alu_op;
    // ���
    wire [31:0] alu_c;
    wire alu_branch;
    // NPC
    // ����
    wire [31:0] npc_pc;
    wire [31:0] npc_imm;
    wire [1:0] npc_op;
    // ���
    wire [31:0] npc_npc;
    // BRANCH
    // ����
    wire branch_ctrl;
    wire branch_alu;
    wire [31:0] branch_exti;
    // ���
    wire [31:0] branch_exto;
    
    // EX/MEM �Ĵ���
    // ����
    wire [31:0] ex_mem_aluc_i;
    wire [31:0] ex_mem_rd2_i;
    wire [31:0] ex_mem_pc4_i;
    wire [31:0] ex_mem_ext_i;
    wire ex_mem_dram_we_i;
    wire [1:0] ex_mem_wdin_sel_i;
    wire ex_mem_rf_we_i;
    wire [2:0] ex_mem_wd_sel_i;
    // ���
    wire [31:0] ex_mem_aluc_o;
    wire [31:0] ex_mem_rd2_o;
    wire [31:0] ex_mem_pc4_o;
    wire [31:0] ex_mem_ext_o;
    wire ex_mem_dram_we_o;
    wire [1:0] ex_mem_wdin_sel_o;
    wire ex_mem_rf_we_o;
    wire [2:0] ex_mem_wd_sel_o;
    
    // �ô� MEM
    
    // MEM/WB �Ĵ���
    // ����
    wire [31:0] mem_wb_aluc_i;
    wire [31:0] mem_wb_dramrd_i;
    wire [31:0] mem_wb_pc4_i;
    wire [31:0] mem_wb_ext_i;
    wire mem_wb_rf_we_i;
    wire [2:0] mem_wb_wd_sel_i;
    // ���
    wire [31:0] mem_wb_aluc_o;
    wire [31:0] mem_wb_dramrd_o;
    wire [31:0] mem_wb_pc4_o;
    wire [31:0] mem_wb_ext_o;
    wire mem_wb_rf_we_o;
    wire [2:0] mem_wb_wd_sel_o;
    
    
    // ��ʼʵ����
    // ȡַ IF
    // PC
    pc U_pc_0(
        .clk_i      (clk_cpu),
        .rst_n_i    (rst_n_i),
        .din_i      (pc_din),
        .pc_o       (pc_pc),
        .pc4_o      (pc_pc4)
    );
    
    // IF/ID �Ĵ���
    reg_if_id U_reg_if_id_0(
        .clk_i      (clk_cpu),
        .rst_n_i    (rst_n_i),
        .if_pc4     (if_id_pc4_i),
        .if_inst    (if_id_inst_i),
        .if_pc      (if_id_pc_i),
        .id_pc4     (if_id_pc4_o),
        .id_inst    (if_id_inst_o),
        .id_pc      (if_id_pc_o)
    );
    
    // ���� ID
    // RF
    rf U_rf_0(
        .clk_i          (clk_cpu),
        .rst_n_i        (rst_n_i),
        .rr1_i          (rf_rr1),
        .rr2_i          (rf_rr2),
        .wr_i           (rf_wr),
        .wd_i           (rf_wd),
        .we             (rf_we),
        .rd1_o          (rf_rd1),
        .rd2_o          (rf_rd2),
        .debug_reg_x19  (debug_reg_x19)
    );
    // SEXT
    sext U_sext_0(
        .inst_i     (sext_inst),         // inst[31:7]
        .sext_op    (sext_op),
        .ext_o      (sext_ext)
    );
    // CONTROL
    control U_control_0(
        .inst_i     (ctrl_inst),
        .npc_op     (ctrl_npc_op),
        .pc_sel     (ctrl_pc_sel),
        .imm_sel    (ctrl_imm_sel),
        .sext_op    (ctrl_sext_op),
        .wd_sel     (ctrl_wd_sel),
        .rf_we      (ctrl_rf_we),
        .alu_op     (ctrl_alu_op),
        .alua_sel   (ctrl_alua_sel),
        .alub_sel   (ctrl_alub_sel),
        .dram_we    (ctrl_dram_we),
        .branch_o   (ctrl_branch),
        .wdin_sel   (ctrl_wdin_sel)
    );
    
    // ID/EX �Ĵ���
    reg_id_ex U_reg_id_ex_0(
        .clk_i              (clk_cpu),
        .rst_n_i            (rst_n_i),
        .id_rd1             (id_ex_rd1_i),
        .id_rd2             (id_ex_rd2_i),
        .id_ext             (id_ex_ext_i),
        .id_pc              (id_ex_pc_i),
        .id_pc4             (id_ex_pc4_i),
        .ex_rd1             (id_ex_rd1_o),
        .ex_rd2             (id_ex_rd2_o),
        .ex_ext             (id_ex_ext_o),
        .ex_pc              (id_ex_pc_o),
        .ex_pc4             (id_ex_pc4_o),
        .id_alu_op          (id_ex_alu_op_i),
        .id_alua_sel        (id_ex_alua_sel_i),
        .id_alub_sel        (id_ex_alub_sel_i),
        .id_branch_ctrl     (id_ex_branch_ctrl_i),
        .id_pc_sel          (id_ex_pc_sel_i),
        .id_npc_op          (id_ex_npc_op_i),
        .id_imm_sel         (id_ex_imm_sel_i),
        .id_dram_we         (id_ex_dram_we_i),
        .id_wdin_sel        (id_ex_wdin_sel_i),
        .id_rf_we           (id_ex_rf_we_i),
        .id_wd_sel          (id_ex_wd_sel_i),
        .ex_alu_op          (id_ex_alu_op_o),
        .ex_alua_sel        (id_ex_alua_sel_o),
        .ex_alub_sel        (id_ex_alub_sel_o),
        .ex_branch_ctrl     (id_ex_branch_ctrl_o),
        .ex_pc_sel          (id_ex_pc_sel_o),
        .ex_npc_op          (id_ex_npc_op_o),
        .ex_imm_sel         (id_ex_imm_sel_o),
        .ex_dram_we         (id_ex_dram_we_o),
        .ex_wdin_sel        (id_ex_wdin_sel_o),
        .ex_rf_we           (id_ex_rf_we_o),
        .ex_wd_sel          (id_ex_wd_sel_o)
    );
    
    // ִ�� EX
    // ALU
    alu U_alu_0(
        .a_i        (alu_a),
        .b_i        (alu_b),
        .alu_op     (alu_op),
        .branch_o   (alu_c),
        .c_o        (alu_branch)
    );
    // NPC
    npc U_npc_0(
        .pc_i       (npc_pc),
        .imm_i      (npc_imm),
        .npc_op     (npc_op),
        .npc_o      (npc_npc)
    );
    // BRANCH
    branch U_branch_0(
        .ctrl_branch_i      (branch_ctrl),
        .alu_branch_i       (branch_alu),
        .ext_i              (branch_exti),
        .ext_o              (branch_exto)
    );
    
    // EX/MEM �Ĵ���
    reg_ex_mem U_reg_ex_mem(
        .clk_i          (clk_cpu),
        .rst_n_i        (rst_n_i),
        .ex_aluc        (ex_mem_aluc_i),
        .ex_rd2         (ex_mem_rd2_i),
        .ex_pc4         (ex_mem_pc4_i),
        .ex_ext         (ex_mem_ext_i),
        .mem_aluc       (ex_mem_aluc_o),
        .mem_rd2        (ex_mem_rd2_o),
        .mem_pc4        (ex_mem_pc4_o),
        .mem_ext        (ex_mem_ext_o),
        .ex_dram_we     (ex_mem_dram_we_i),
        .ex_wdin_sel    (ex_mem_wdin_sel_i),
        .ex_rf_we       (ex_mem_rf_we_i),
        .ex_wd_sel      (ex_mem_wd_sel_i),
        .mem_dram_we    (ex_mem_dram_we_o),
        .mem_wdin_sel   (ex_mem_wdin_sel_o),
        .mem_rf_we      (ex_mem_rf_we_o),
        .mem_wd_sel     (ex_mem_wd_sel_o)
    );
    
    // �ô� MEM
    
    // MEM/WB �Ĵ���
    reg_mem_wb U_reg_mem_wb_0(
        .clk_i          (clk_cpu),
        .rst_n_i        (rst_n_i),
        .mem_aluc       (mem_wb_aluc_i),
        .mem_dramrd     (mem_wb_dramrd_i),
        .mem_pc4        (mem_wb_pc4_i),
        .mem_ext        (mem_wb_ext_i),
        .wb_aluc        (mem_wb_aluc_o),
        .wb_dramrd      (mem_wb_dramrd_o),
        .wb_pc4         (mem_wb_pc4_o),
        .wb_ext         (mem_wb_ext_o),
        .mem_rf_we      (mem_wb_rf_we_i),
        .mem_wd_sel     (mem_wb_wd_sel_i),
        .wb_rf_we       (mem_wb_rf_we_o),
        .wb_wd_sel      (mem_wb_wd_sel_o)
    );
    
    // ��ʼ����
    // ȡַ IF
    // PC
    assign pc_din = npc_npc;
    
    // IF/ID
    assign if_id_pc4_i = pc_pc4;
    assign if_id_inst_i = irom_inst;
    assign if_id_pc_i = pc_pc;
    
    // ���� ID
    // RF
    assign rf_rr1 = if_id_inst_o[19:15];
    assign rf_rr2 = if_id_inst_o[24:20];
    assign rf_wr = if_id_inst_o[11:7];
    assign rf_wd =  (mem_wb_wd_sel_o == 3'b000) ?   mem_wb_aluc_o : 
                    (mem_wb_wd_sel_o == 3'b001) ?   mem_wb_dramrd_o : 
                    (mem_wb_wd_sel_o == 3'b010) ?   {24'h0, mem_wb_dramrd_o[7:0]} : 
                    (mem_wb_wd_sel_o == 3'b011) ?   {16'h0, mem_wb_dramrd_o[15:0]} : 
                    (mem_wb_wd_sel_o == 3'b100) ?   mem_wb_pc4_o : 
                    (mem_wb_wd_sel_o == 3'b101) ?   mem_wb_ext_o : 
                                                    32'h0;
    assign rf_we = mem_wb_rf_we_o;
    // SEXT
    assign sext_inst = if_id_inst_o[31:7];
    assign sext_op = ctrl_sext_op;
    // CONTROL
    assign ctrl_inst = if_id_inst_o;
    
    // ID/EX
    assign id_ex_rd1_i = rf_rd1;
    assign id_ex_rd2_i = rf_rd2;
    assign id_ex_ext_i = sext_ext;
    assign id_ex_pc_i = if_id_pc_o;
    assign id_ex_pc4_i = if_id_pc4_o;
    assign id_ex_alu_op_i = ctrl_alu_op;
    assign id_ex_alua_sel_i = ctrl_alua_sel;
    assign id_ex_alub_sel_i = ctrl_alub_sel;
    assign id_ex_branch_ctrl_i = ctrl_branch;
    assign id_ex_pc_sel_i = ctrl_pc_sel;
    assign id_ex_npc_op_i = ctrl_npc_op;
    assign id_ex_imm_sel_i = ctrl_imm_sel;
    assign id_ex_dram_we_i = ctrl_dram_we;
    assign id_ex_wdin_sel_i = ctrl_wdin_sel;
    assign id_ex_rf_we_i = ctrl_rf_we;
    assign id_ex_wd_sel_i = ctrl_wd_sel;

    // ִ�� EX
    // ALU
    
endmodule
