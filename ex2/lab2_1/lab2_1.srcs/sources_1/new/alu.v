`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 15:15:50
// Design Name: 
// Module Name: alu
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


module alu(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    input       [3:0]   alu_op,
    input               branch,
    output  reg [31:0]  c_o
    );
    wire [31:0] c_add;
    wire [31:0] c_sub;
    // ¼Ó·¨Æ÷
    alu_add U_alu_add_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_add)
    );
    // ¼õ·¨Æ÷
    alu_sub U_alu_sub_0(
        .a_i    (a_i),
        .b_i    (b_i),
        .c_o    (c_sub)
    );
endmodule


