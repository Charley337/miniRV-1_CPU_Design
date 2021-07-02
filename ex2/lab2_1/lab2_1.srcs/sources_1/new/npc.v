`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: npc
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


module npc(
    input       [31:0]  pc_i,
    input       [31:0]  imm_i,
    input       [1:0]   npc_op,
    output      [31:0]  npc_o,
    output      [31:0]  pc4_o
    );
    // define parameter
    localparam  PC_ADD_4    = 2'b00;
    localparam  PC_ADD_IMM  = 2'b01;
    localparam  PC_IMM_JALR = 2'b10; 
    // 都用组合逻辑
    assign pc4_o = pc_i + 32'h4;
    assign npc_o = (npc_op == PC_IMM_JALR) ? ((pc_i + imm_i) & 32'hFFFF_FFFE) : (npc_op == PC_ADD_IMM) ? (pc_i + imm_i) : (pc_i + 32'h4);
endmodule
