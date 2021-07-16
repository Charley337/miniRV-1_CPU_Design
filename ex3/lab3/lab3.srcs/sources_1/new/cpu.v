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
    input   [31:0]  irom_inst,              // 从irom读到的指令
    input   [31:0]  dram_rdata,             // 从dram读到的数据
    output  [31:0]  irom_addr,              // 输出给irom的地址
    output  [31:0]  dram_addr,              // 输出给dram的地址
    output  [31:0]  dram_wdata,             // 输出给dram的写数据
    output          dram_we,                // 输出给dram的读写控制信号
    // 测试用的输出信号
    output          debug_wb_have_inst,
    output  [31:0]  debug_wb_pc,
    output          debug_wb_ena,
    output  [4:0]   debug_wb_reg,
    output  [31:0]  debug_wb_value
    );
    // 所有信号
    // 取址 IF
    // PC
    // 输入
    wire [31:0] pc_din;
    // 输出
    wire [31:0] pc_pc;
    wire [31:0] pc_pc4;
    
    // IF/ID 寄存器
    // 输入
    wire [31:0] if_id_pc4_i;
    wire [31:0] if_id_inst_i;
    wire [31:0] if_id_pc_i;
    // 输出
    wire [31:0] if_id_pc4_o;
    wire [31:0] if_id_inst_o;
    wire [31:0] if_id_pc_o;
    
    // 译码 ID
    // RF
    // 输入
    wire [4:0] rf_rr1;
    wire [4:0] rf_rr2;
    wire [4:0] rf_wr;
    wire [31:0] rf_wd;
    wire rf_we;
    // 输出
    wire [31:0] rf_rd1;
    wire [31:0] rf_rd2;
    // SEXT
    // 输入
    wire [24:0] sext_inst;
    wire [2:0] sext_op;
    // 输出
    wire [31:0] sext_ext;
    // CONTROL
    // 输入
    
    // 输出
    
    
    // ID/EX 寄存器
    // 输入
    wire [31:0] id_ex_rd1_i;
    wire [31:0] id_ex_rd2_i;
    wire [31:0] id_ex_ext_i;
    wire [31:0] id_ex_pc_i;
    wire [4:0] id_ex_alu_op_i;
    wire id_ex_alua_sel_i;
    wire id_ex_alub_sel_i;
    wire id_ex_branch_ctrl_i;
    wire id_ex_pc_sel_i;
    wire [1:0] id_ex_npc_op_i;
    wire id_ex_imm_sel_i;
    wire id_ex_dram_we_i;
    wire [1:0] id_ex_wdin_sel_i;
    // 输出
    wire [31:0] id_ex_rd1_o;
    wire [31:0] id_ex_rd2_o;
    wire [31:0] id_ex_ext_o;
    wire [31:0] id_ex_pc_o;
    wire [4:0] id_ex_alu_op_o;
    wire id_ex_alua_sel_o;
    wire id_ex_alub_sel_o;
    wire id_ex_branch_ctrl_o;
    wire id_ex_pc_sel_o;
    wire [1:0] id_ex_npc_op_o;
    wire id_ex_imm_sel_o;
    wire id_ex_dram_we_o;
    wire [1:0] id_ex_wdin_sel_o;
    
    // 执行 EX
    // ALU
    // 输入
    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire [4:0] alu_op;
    // 输出
    wire [31:0] alu_c;
    wire alu_branch;
    // NPC
    // 输出
    wire [31:0] npc_pc;
    wire [31:0] npc_imm;
    wire [1:0] npc_op;
    // 输出
    wire [31:0] npc_npc;
    // BRANCH
    // 输入
    wire branch_ctrl;
    wire branch_alu;
    wire [31:0] branch_exti;
    // 输出
    wire [31:0] branch_exto;
    
    // EX/MEM 寄存器
    // 输入
    wire [31:0] ex_mem_aluc_i;
    wire [31:0] ex_mem_rd2_i;
    wire ex_mem_dram_we_i;
    wire [1:0] ex_mem_wdin_sel_i;
    // 输出
    wire [31:0] ex_mem_aluc_o;
    wire [31:0] ex_mem_rd2_o;
    wire ex_mem_dram_we_o;
    wire [1:0] ex_mem_wdin_sel_o;
    
    // 访存 MEM
    
    // MEM/WB 寄存器
    // 输入
    wire [31:0] mem_wb_aluc_i;
    wire [31:0] mem_wb_dramrd_i;
    // 输出
    wire [31:0] mem_wb_aluc_o;
    wire [31:0] mem_wb_dramrd_o;
    
    
    // 开始实例化
    // 取址 IF
    // PC
    pc U_pc_0(
        .clk_i      (clk_cpu),
        .rst_n_i    (rst_n_i),
        .din_i      (pc_din),
        .pc_o       (pc_pc),
        .pc4_o      (pc_pc4)
    );
    
    // IF/ID 寄存器
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
    
    // 译码 ID
    // RF
    rf U_rf_0(
        .clk_i      (clk_cpu),
        .rst_n_i    (rst_n_i),
        .rr1_i      (rf_rr1),
        .rr2_i      (rf_rr2),
        .wr_i       (rf_wr),
        .wd_i       (rf_wd),
        .we         (rf_we),
        .rd1_o      (rf_rd1),
        .rd2_o      (rf_rd2)
    );
    // SEXT
    sext U_sext_0(
        .inst_i     (sext_inst),         // inst[31:7]
        .sext_op    (sext_op),
        .ext_o      (sext_ext)
    );
    // CONTROL
    control U_control_0(
        
    );
    
    // ID/EX 寄存器
    reg_id_ex U_reg_id_ex_0(
        .clk_i              (clk_cpu),
        .rst_n_i            (rst_n_i),
        .id_rd1             (id_ex_rd1_i),
        .id_rd2             (id_ex_rd2_i),
        .id_ext             (id_ex_ext_i),
        .id_pc              (id_ex_pc_i),
        .ex_rd1             (id_ex_rd1_o),
        .ex_rd2             (id_ex_rd2_o),
        .ex_ext             (id_ex_ext_o),
        .ex_pc              (id_ex_pc_o),
        .id_alu_op          (id_ex_alu_op_i),
        .id_alua_sel        (id_ex_alua_sel_i),
        .id_alub_sel        (id_ex_alub_sel_i),
        .id_branch_ctrl     (id_ex_branch_ctrl_i),
        .id_pc_sel          (id_ex_pc_sel_i),
        .id_npc_op          (id_ex_npc_op_i),
        .id_imm_sel         (id_ex_imm_sel_i),
        .id_dram_we         (id_ex_dram_we_i),
        .id_wdin_sel        (id_ex_wdin_sel_i),
        .ex_alu_op          (id_ex_alu_op_o),
        .ex_alua_sel        (id_ex_alua_sel_o),
        .ex_alub_sel        (id_ex_alub_sel_o),
        .ex_branch_ctrl     (id_ex_branch_ctrl_o),
        .ex_pc_sel          (id_ex_pc_sel_o),
        .ex_npc_op          (id_ex_npc_op_o),
        .ex_imm_sel         (id_ex_imm_sel_o),
        .ex_dram_we         (id_ex_dram_we_o),
        .ex_wdin_sel        (id_ex_wdin_sel_o)
    );
    
    // 执行 EX
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
    
    // EX/MEM 寄存器
    reg_ex_mem U_reg_ex_mem(
        .clk_i          (clk_cpu),
        .rst_n_i        (rst_n_i),
        .ex_aluc        (ex_mem_aluc_i),
        .ex_rd2         (ex_mem_rd2_i),
        .mem_aluc       (ex_mem_aluc_o),
        .mem_rd2        (ex_mem_rd2_o),
        .ex_dram_we     (ex_mem_dram_we_i),
        .ex_wdin_sel    (ex_mem_wdin_sel_i),
        .mem_dram_we    (ex_mem_dram_we_o),
        .mem_wdin_sel   (ex_mem_wdin_sel_o)
    );
    
    // 访存 MEM
    
    // MEM/WB 寄存器
    reg_mem_wb U_reg_mem_wb_0(
        .clk_i          (clk_cpu),
        .rst_n_i        (rst_n_i),
        .mem_aluc       (mem_wb_aluc_i),
        .mem_dramrd     (mem_wb_dramrd_i),
        .wb_aluc        (mem_wb_aluc_o),
        .wb_dramrd      (mem_wb_dramrd_o)
    );
    
endmodule
