`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:54:35
// Design Name: 
// Module Name: reg_id_ex
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


module reg_id_ex(
    input               clk_i,
    input               rst_n_i,
    input       [31:0]  id_rd1,
    input       [31:0]  id_rd2,
    input       [31:0]  id_ext,
    input       [31:0]  id_pc,
    input       [31:0]  id_pc4,
    input       [4:0]   id_alu_op,
    input               id_alua_sel,
    input               id_alub_sel,
    input               id_branch_ctrl,
    input               id_pc_sel,
    input       [1:0]   id_npc_op,
    input               id_imm_sel,
    input               id_dram_we,
    input       [1:0]   id_wdin_sel,
    input               id_rf_we,
    input       [2:0]   id_wd_sel,
    input       [4:0]   id_wr,
    input               id_have_inst,
    input       [4:0]   id_reg1,
    input       [4:0]   id_reg2,
    
    output  reg [31:0]  ex_rd1,
    output  reg [31:0]  ex_rd2,
    output  reg [31:0]  ex_ext,
    output  reg [31:0]  ex_pc,
    output  reg [31:0]  ex_pc4,
    output  reg [4:0]   ex_alu_op,
    output  reg         ex_alua_sel,
    output  reg         ex_alub_sel,
    output  reg         ex_branch_ctrl,
    output  reg         ex_pc_sel,
    output  reg [1:0]   ex_npc_op,
    output  reg         ex_imm_sel,
    output  reg         ex_dram_we,
    output  reg [1:0]   ex_wdin_sel,
    output  reg         ex_rf_we,
    output  reg [2:0]   ex_wd_sel,
    output  reg [4:0]   ex_wr,
    output  reg         ex_have_inst,
    output  reg [4:0]   ex_reg1,
    output  reg [4:0]   ex_reg2
    );
    // ex_rd1
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_rd1 <= 32'h0;
        else            ex_rd1 <= id_rd1;
    end
    
    // ex_rd2
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_rd2 <= 32'h0;
        else            ex_rd2 <= id_rd2;
    end
    
    // ex_ext
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_ext <= 32'h0;
        else            ex_ext <= id_ext;
    end
    
    // ex_pc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_pc <= 32'h0;
        else            ex_pc <= id_pc;
    end
    
    // ¿ØÖÆÐÅºÅ
    // ex_alu_op
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_alu_op <= 5'h0;
        else            ex_alu_op <= id_alu_op;
    end
    
    // ex_alua_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_alua_sel <= 1'b0;
        else            ex_alua_sel <= id_alua_sel;
    end
    
    // ex_alub_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_alub_sel <= 1'b0;
        else            ex_alub_sel <= id_alub_sel;
    end
    
    // ex_branch_ctrl
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_branch_ctrl <= 1'b0;
        else            ex_branch_ctrl <= id_branch_ctrl;
    end
    
    // ex_pc_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_pc_sel <= 1'b0;
        else            ex_pc_sel <= id_pc_sel;
    end
    
    // ex_npc_op
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_npc_op <= 2'h0;
        else            ex_npc_op <= id_npc_op;
    end
    
    // ex_imm_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_imm_sel <= 1'b0;
        else            ex_imm_sel <= id_imm_sel;
    end
    
    // ex_dram_we
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_dram_we <= 1'b0;
        else            ex_dram_we <= id_dram_we;
    end
    
    // ex_wdin_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_wdin_sel <= 2'h0;
        else            ex_wdin_sel <= id_wdin_sel;
    end

    // ex_pc4
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_pc4 <= 32'h0;
        else            ex_pc4 <= id_pc4;
    end

    // ex_wr
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_wr <= 5'h0;
        else            ex_wr <= id_wr;
    end

    // ex_have_inst
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_have_inst <= 1'b0;
        else            ex_have_inst <= id_have_inst;
    end

    // ex_rf_we
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_rf_we <= 1'b0;
        else            ex_rf_we <= id_rf_we;
    end

    // ex_wd_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_wd_sel <= 3'h0;
        else            ex_wd_sel <= id_wd_sel;
    end
    
    // ex_reg1
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_reg1 <= 5'h0;
        else            ex_reg1 <= id_reg1;
    end
    
    // ex_reg2
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   ex_reg2 <= 5'h0;
        else            ex_reg2 <= id_reg2;
    end
endmodule
