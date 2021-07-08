`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 20:26:21
// Design Name: 
// Module Name: memram
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


module memram(
    input               clk_i,
    input       [31:0]  addr_i,
    input               memwr_i,
    input       [31:0]  wr_data_i,
    output      [31:0]  rd_data_o
    );
    wire ram_clk;
    assign ram_clk = ~clk_i;
    dram U_dram_0(
        .clk    (ram_clk),
        .a      (addr_i[15:2]),
        .qspo   (rd_data_o),
        .we     (memwr_i),
        .d      (wr_data_i)
    );
endmodule
