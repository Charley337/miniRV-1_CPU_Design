`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 01:48:25
// Design Name: 
// Module Name: control
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


module control(
    input       [31:0]  inst_i,
    output      [1:0]   npc_op,
    output              pc_sel,
    output              imm_sel,
    output      [2:0]   sext_op,
    output      [1:0]   wd_sel,
    output              rf_we,
    output      [3:0]   alu_op,
    output              alub_sel,
    output              dram_we,
    output              branch_o
    );
    
endmodule
