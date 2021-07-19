
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
    input               ex_dram_we,
    input       [1:0]   ex_wdin_sel,
    input               ex_rf_we,
    input       [2:0]   ex_wd_sel,
    input               ex_have_inst,
    input       [4:0]   ex_wr,
    input       [31:0]  ex_pc,
    
    output  reg [31:0]  mem_aluc,
    output  reg [31:0]  mem_rd2,
    output  reg [31:0]  mem_pc4,
    output  reg [31:0]  mem_ext,
    output  reg         mem_dram_we,
    output  reg [1:0]   mem_wdin_sel,
    output  reg         mem_rf_we,
    output  reg [2:0]   mem_wd_sel,
    output  reg         mem_have_inst,
    output  reg [4:0]   mem_wr,
    output  reg [31:0]  mem_pc
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

    // mem_pc4
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_pc4 <= 32'h0;
        else            mem_pc4 <= ex_pc4;
    end

    // mem_ext
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_ext <= 32'h0;
        else            mem_ext <= ex_ext;
    end

    // mem_rf_we
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_rf_we <= 1'b0;
        else            mem_rf_we <= ex_rf_we;
    end

    // mem_wd_sel
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_wd_sel <= 3'h0;
        else            mem_wd_sel <= ex_wd_sel;
    end

    // mem_have_inst
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_have_inst <= 1'b0;
        else            mem_have_inst <= ex_have_inst;
    end

    // mem_wr
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_wr <= 5'h0;
        else            mem_wr <= ex_wr;
    end

    // mem_pc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   mem_pc <= 32'h0;
        else            mem_pc <= ex_pc;
    end
endmodule
