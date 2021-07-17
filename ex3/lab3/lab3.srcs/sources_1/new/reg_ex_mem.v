`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:54:51
// Design Name: 
// Module Name: reg_ex_mem
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


module reg_ex_mem(
    input               clk_i,
    input               rst_n_i,
    
    input       [31:0]  ex_aluc,
    input       [31:0]  ex_rd2,
    input       [31:0]  ex_pc4,
    input       [31:0]  ex_ext,
    
    output  reg [31:0]  mem_aluc,
    output  reg [31:0]  mem_rd2,
    output  reg [31:0]  mem_pc4,
    output  reg [31:0]  mem_ext,
    
    // ¿ØÖÆÐÅºÅ
    input               ex_dram_we,
    input       [1:0]   ex_wdin_sel,
    input               ex_rf_we,
    input       [2:0]   ex_wd_sel,
    
    output  reg         mem_dram_we,
    output  reg [1:0]   mem_wdin_sel,
    output  reg         mem_rf_we,
    output  reg [2:0]   mem_wd_sel
    );
    // mem_aluc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_aluc <= 32'h0;
        else            mem_aluc <= ex_aluc;
    end
    
    // mem_rd2
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_rd2 <= 32'h0;
        else            mem_rd2 <= ex_rd2;
    end
    
    // mem_dram_we
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_dram_we <= 1'b0;
        else            mem_dram_we <= ex_dram_we;
    end
    
    // mem_wdin_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_wdin_sel <= 2'h0;
        else            mem_wdin_sel <= ex_wdin_sel;
    end
endmodule
