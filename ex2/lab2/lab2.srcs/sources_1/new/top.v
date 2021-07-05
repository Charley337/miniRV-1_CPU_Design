`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:25:35
// Design Name: 
// Module Name: top
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


module top(
    input   clk_i,
    input   rst_n_i
    );
    // CPU 时钟
    wire clk_cpu;
    // PC
    wire [31:0] pc_din;
    wire [31:0] pc_pc;
    // NPC
    wire [31:0] npc_pc;
    wire [31:0] npc_npc;
    wire [31:0] npc_pc4;
    wire [31:0] npc_imm;
    wire [1:0] npc_op;
    // IROM
    wire [31:0] irom_adr;
    wire [31:0] irom_inst;
    // SEXT
    wire [31:0] sext_din;
    wire [31:0] 
    // 时钟部件
    cpuclk U_cpuclk_0(
        .clk_in1    (clk_i),
        .clk_out1   (clk_cpu)
    );
    // pc部件
    pc U_pc_0(
        .clk_i      (clk_cpu),
        .rst_n_i    (rst_n_i),
        .din_i      (pc_din),
        .pc_o       (pc_pc)
    );
    // npc部件
    npc U_npc_0(
        .pc_i       (),
        .imm_i      (),
        .npc_op     (),
        .npc_o      (),
        .pc4_o      ()
    );
    // irom部件
    irom U_irom_0(

    );
    // sext部件
    sext U_sext_0(

    );
    // rf部件
    rf U_rf_0(

    );
    // alu部件
    alu U_alu_0(

    );
    // memram部件
    memram U_memram_0(

    );
    // branch部件
    branch U_branch_0(

    );
    // 控制单元
    control U_control_0(

    );
endmodule
