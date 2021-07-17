`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:55:07
// Design Name: 
// Module Name: reg_mem_wb
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


module reg_mem_wb(
    input               clk_i,
    input               rst_n_i,
    
    input       [31:0]  mem_aluc,
    input       [31:0]  mem_dramrd,
    input       [31:0]  mem_pc4,
    input       [31:0]  mem_ext,
    
    output  reg [31:0]  wb_aluc,
    output  reg [31:0]  wb_dramrd,
    output  reg [31:0]  wb_pc4,
    output  reg [31:0]  wb_ext,
    
    // пе╨е
    input               mem_rf_we,
    input               mem_wd_sel,
    
    output  reg         wb_rf_we,
    output  reg [2:0]   wb_wd_sel
    );
    // wb_aluc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_aluc <= 32'h0;
        else            wb_aluc <= mem_aluc;
    end
    
    // wb_dramrd
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_dramrd <= 32'h0;
        else            wb_dramrd <= mem_dramrd;
    end
endmodule
