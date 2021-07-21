`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/21 09:26:54
// Design Name: 
// Module Name: stop
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


module stop(
    input               clk_cpu,
    input               rst_n_i,
    input        [31:0] inst_i,
    output  reg         have_inst_o,
    output  reg         pipline_stop
    );
    wire [6:0] opcode;
    assign opcode = inst_i[6:0];
    // 停顿计数器
    reg [5:0] stop_cnt;
    
    wire opcode_jal;
    assign opcode_jal = (opcode == `OPCODE_INST_J_JAL);
    
    // 控制 have_inst_o 信号
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                   have_inst_o <= 1'b0;
        else if (pipline_stop)          have_inst_o <= 1'b0;
        else                            have_inst_o <= 1'b1;
    end
    
    // 控制 cnt 
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                           stop_cnt <= 6'h0;
        else if (opcode_jal & (~pipline_stop))  stop_cnt <= 6'b111111;
        else if (stop_cnt == 6'h0)              stop_cnt <= 6'h0;
        else                                    stop_cnt <= stop_cnt + 6'h1;
    end
    
    // 控制 pipline_stop
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                   pipline_stop <= 1'b0;
        else if (stop_cnt != 6'h0)      pipline_stop <= 1'b1;
        else                            pipline_stop <= 1'b0;
    end
endmodule
