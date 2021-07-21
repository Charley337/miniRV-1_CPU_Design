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
    // ͣ�ټ�����
    reg [5:0] stop_cnt;
    
    wire opcode_jal;
    wire opcode_inst_b;
    wire opcode_jalr;
    assign opcode_jal = (opcode == `OPCODE_INST_J_JAL);
    assign opcode_inst_b = (opcode == `OPCODE_INST_B);
    assign opcode_jalr = (opcode == `OPCODE_INST_I_JALR);
    
    reg state;
    // ״̬�� cnt һ����֪ͨ have_inst_o ��һ��
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                               state <= 1'b0;
        else if ((opcode_jal || opcode_inst_b || opcode_jalr) && (~state)) begin
            state <= 1'b1;
        end
        else if (have_inst_o) begin
            
        end
    end
    
    // ���� have_inst_o �ź�
    always @ (posedge clk_cpu or negedge rst_n_i) begin
        if (~rst_n_i)                               have_inst_o <= 1'b0;
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
    wire clk_pipline_stop;
    assign clk_pipline_stop = ~clk_cpu;
    always @ (posedge clk_pipline_stop or negedge rst_n_i) begin
        if (~rst_n_i)                   pipline_stop <= 1'b0;
        else if (stop_cnt != 6'h0)      pipline_stop <= 1'b1;
        else                            pipline_stop <= 1'b0;
    end
endmodule
