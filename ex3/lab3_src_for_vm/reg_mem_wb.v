
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
    input               mem_rf_we,
    input       [2:0]   mem_wd_sel,
    input               mem_have_inst,
    input       [4:0]   mem_wr,
    input       [31:0]  mem_pc,
    
    output  reg [31:0]  wb_aluc,
    output  reg [31:0]  wb_dramrd,
    output  reg [31:0]  wb_pc4,
    output  reg [31:0]  wb_ext,
    output  reg         wb_rf_we,
    output  reg [2:0]   wb_wd_sel,
    output  reg         wb_have_inst,
    output  reg [4:0]   wb_wr,
    output  reg [31:0]  wb_pc
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

    // wb_pc4
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_pc4 <= 32'h0;
        else            wb_pc4 <= mem_pc4;
    end

    // wb_ext
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_ext <= 32'h0;
        else            wb_ext <= mem_ext;
    end

    // wb_rf_we
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_rf_we <= 1'b0;
        else            wb_rf_we <= mem_rf_we;
    end

    // wb_wd_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_wd_sel <= 3'h0;
        else            wb_wd_sel <= mem_wd_sel;
    end

    // wb_have_inst
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_have_inst <= 1'b0;
        else            wb_have_inst <= mem_have_inst;
    end

    // wb_wr
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_wr <= 5'h0;
        else            wb_wr <= mem_wr;
    end

    // wb_pc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   wb_pc <= 32'h0;
        else            wb_pc <= mem_pc;
    end
endmodule
