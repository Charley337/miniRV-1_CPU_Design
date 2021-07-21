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
    // ��ʱ��
    wire clk_cpu_n;
    assign clk_cpu_n = ~clk_cpu;
    // opcode
    wire [6:0] opcode;
    assign opcode = inst_i[6:0];
    // ͣ�ټ�����
    reg [5:0] stop_cnt;
    
    wire opcode_jal;
    wire opcode_inst_b;
    wire opcode_jalr;
    assign opcode_jal = (opcode == `OPCODE_INST_J_JAL);
    assign opcode_inst_b = (opcode == `OPCODE_INST_B);
    assign opcode_jalr = (opcode == `OPCODE_INST_I_JALR);
    
    reg warning;
    // ��ǰԤ��
    always @ (posedge clk_cpu_n or negedge rst_n_i) begin
        if (~rst_n_i)                               warning <= 1'b0;
        else if (opcode_jal || opcode_inst_b || opcode_jalr) begin
            warning <= 1'b1;
        end
        else                                        warning <= 1'b0;
    end
    
    // ���� have_inst_o �ź�
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                               have_inst_o <= 1'b0;
        else if (have_inst_o && warning)            have_inst_o <= 1'b0;
        else if (pipline_stop)                      have_inst_o <= 1'b0;
        else                                        have_inst_o <= 1'b1;
    end
    
    // ���� cnt 
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                               stop_cnt <= 6'h0;
        else if (opcode_jal & (~pipline_stop))      stop_cnt <= 6'b111110;
        else if (opcode_inst_b & (~pipline_stop))   stop_cnt <= 6'b111110;
        else if (opcode_jalr & (~pipline_stop))     stop_cnt <= 6'b111110;
        else if (stop_cnt == 6'h0)                  stop_cnt <= 6'h0;
        else                                        stop_cnt <= stop_cnt + 6'h1;
    end
    
    // ���� pipline_stop
    always @ (posedge clk_cpu_n or negedge rst_n_i) begin
        if (~rst_n_i)                   pipline_stop <= 1'b0;
        else if (stop_cnt != 6'h0)      pipline_stop <= 1'b1;
        else                            pipline_stop <= 1'b0;
    end
endmodule
