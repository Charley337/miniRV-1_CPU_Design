`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/22 16:03:37
// Design Name: 
// Module Name: wdata_helper
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


// ���ģ�����ûʲô�ð�����ʱ��ʱ�����ɾ��
module wdata_helper(
    input       [31:0]  wdata_i,
    input       [1:0]   add_i,
    output      [31:0]  wdata_sb_o,
    output      [31:0]  wdata_sh_o
    );
    assign wdata_sb_o = 32'h0;
    assign wdata_sh_o = 32'h0;
endmodule