`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 14:41:31
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
// 所有的信号
reg clk_cpu;
reg rst_n_i;
// PC
// 输入
wire [31:0] pc_din;
// 输出
wire [31:0] pc_pc;
// NPC
// 输入
wire [31:0] npc_pc;
reg [31:0] npc_imm;
reg [1:0] npc_op;
// 输出
wire [31:0] npc_npc;
wire [31:0] npc_pc4;
// IROM
// 输入
wire [31:0] irom_adr;
// 输出
wire [31:0] irom_inst;
// SEXT
// 输入
wire [31:0] sext_din;
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
// MEMRAM
// 输入
wire [31:0] dram_addr;
wire [31:0] dram_wr_data;
wire dram_memwr;
// 输出
wire [31:0] dram_rd_data;
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

// 待测模块
alu U_alu_0(
    .a_i        (alu_a),
    .b_i        (alu_b),
    .alu_op     (alu_op),
    .branch_o   (alu_branch),
    .c_o        (alu_c)
);

// 连线方式
reg [3:0] op_i;
reg [31:0] a_i;
reg [31:0] b_i;
assign alu_a = a_i;
assign alu_b = b_i;
assign alu_op = op_i;

// 激励信号
initial begin
    #0 begin 
        clk_cpu = 0;
        rst_n_i = 0;
        op_i = `ALU_ADD;
        a_i = 32'hC;
        b_i = 32'h4;
    end
    #20 begin
        rst_n_i = 1;
    end
    #20 begin
        op_i = `ALU_SUB;
    end
    #20 begin
        op_i = `ALU_AND;
    end
    #20 begin
        op_i = `ALU_OR;
    end
    #20 begin
        op_i = `ALU_XOR;
    end
    #20 begin
        op_i = `ALU_SLL;
    end
    #20 begin
        op_i = `ALU_SRL;
    end
    #20 begin
        op_i = `ALU_SRA;
    end
    #20 begin
        op_i = `ALU_BEQ;
    end
    #20 begin
        op_i = `ALU_BNE;
    end
    #20 begin
        op_i = `ALU_BLT;
    end
    #20 begin
        op_i = `ALU_BGE;
    end
end

// 时钟
always begin
    #5 clk_cpu = ~clk_cpu;
end
endmodule
