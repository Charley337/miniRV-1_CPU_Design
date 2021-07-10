`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/10 18:22:51
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
    input   [31:0]  irom_inst,          // 从irom读到的指令
    input   [31:0]  dram_rd_data,       // 从dram读到的数据
    output  [31:0]  irom_adr,           // 输出给irom的地址
    output  [31:0]  dram_addr,          // 输出给dram的地址
    output  [31:0]  dram_wr_data,       // 输出给dram的写数据
    output          dram_memwr,         // 输出给dram的读写控制信号
    // 测试用的输出信号
    output          debug_wb_have_inst,
    output  [31:0]  debug_wb_pc,
    output          debug_wb_ena,
    output  [4:0]   debug_wb_reg,
    output  [31:0]  debug_wb_value
    );
    // PC
    // 输入
    wire [31:0] pc_din;
    // 输出
    wire [31:0] pc_pc;
    wire [31:0] pc_pc4;
    // NPC
    // 输入
    wire [31:0] npc_pc;
    wire [31:0] npc_imm;
    wire [1:0] npc_op;
    // 输出
    wire [31:0] npc_npc;
    // SEXT
    // 输入
    wire [24:0] sext_din;
    wire [2:0] sext_op;
    // 输出
    wire [31:0] sext_ext;
    // BRANCH
    // 输入
    wire branch_ctrl;
    wire branch_alu;
    wire [31:0] branch_ext_i;
    // 输出
    wire [31:0] branch_ext_o;
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
    // ALU
    // 输入
    wire [31:0] alu_a;
    wire [31:0] alu_b;
    wire [3:0] alu_op;
    // 输出
    wire [31:0] alu_c;
    wire alu_branch;
    // 控制单元
    // 输入
    wire [31:0] ctrl_inst;
    // 输出
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
    
    // pc部件
    pc U_pc_0(
        .clk_i      (clk_cpu),
        .rst_n_i    (rst_n_i),
        .din_i      (pc_din),
        .pc_o       (pc_pc), 
        .pc4_o     (pc_pc4)
    );
    // npc部件
    npc U_npc_0(
        .pc_i       (npc_pc),
        .imm_i      (npc_imm),
        .npc_op     (npc_op),
        .npc_o      (npc_npc)
    );
    // sext部件
    sext U_sext_0(
        .inst_i     (sext_din),
        .sext_op    (sext_op),
        .ext_o      (sext_ext)
    );
    // rf部件
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
    // alu部件
    alu U_alu_0(
        .a_i        (alu_a),
        .b_i        (alu_b),
        .alu_op     (alu_op),
        .branch_o   (alu_branch),
        .c_o        (alu_c)
    );
    // branch部件
    branch U_branch_0(
        .ctrl_branch_i      (branch_ctrl),
        .alu_branch_i       (branch_alu),
        .ext_i              (branch_ext_i),
        .ext_o              (branch_ext_o)
    );
    // 控制单元
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
    
    // 开始连线
    // PC
    assign pc_din   =   npc_npc;
    // NPC
    assign npc_pc   =   ctrl_pc_sel         ?   rf_rd1 : 
                                                pc_pc;
    assign npc_imm  =   ctrl_imm_sel        ?   branch_ext_o : 
                                                sext_ext;
    assign npc_op   =   ctrl_npc_op;
    // IROM
    assign irom_adr =   pc_pc;
    // RF
    assign rf_rr1   =   irom_inst[19:15];
    assign rf_rr2   =   irom_inst[24:20];
    assign rf_wr    =   irom_inst[11:7];
    assign rf_wd    =   (ctrl_wd_sel == 2'b00)  ?   alu_c : 
                        (ctrl_wd_sel == 2'b01)  ?   dram_rd_data : 
                        (ctrl_wd_sel == 2'b10)  ?   pc_pc4 : 
                                                    sext_ext;
    assign rf_we    =   ctrl_rf_we;
    // SEXT
    assign sext_din =   irom_inst[31:7];
    assign sext_op  =   ctrl_sext_op;
    // BRANCH
    assign branch_ctrl  =   ctrl_branch;
    assign branch_alu   =   alu_branch;
    assign branch_ext_i =   sext_ext;
    // ALU
    assign alu_a    =   rf_rd1;
    assign alu_b    =   ctrl_alub_sel       ?   sext_ext : 
                                                rf_rd2;
    assign alu_op   =   ctrl_alu_op;
    // MEMRAM
    assign dram_addr    =   alu_c;
    assign dram_wr_data =   rf_rd2;
    assign dram_memwr   =   ctrl_dram_we;
    // 控制单元
    assign ctrl_inst    =   irom_inst;
    
    // 输出测试用的信号
    assign debug_wb_have_inst = 1'b1;
    assign debug_wb_pc = pc_pc;
    assign debug_wb_ena = ctrl_rf_we;
    assign debug_wb_reg = rf_wr;
    assign debug_wb_value = rf_wd;
endmodule
