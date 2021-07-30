`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:33:52
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
    input               we,
    input       [31:0]  wdata_i,
    output      [31:0]  rdata_o
    );
    wire [31:0] addr_tmp;
    wire ram_clk;
    assign ram_clk = ~clk_i;
    assign addr_tmp = addr_i - 16'h4000;
    // IP ºË
    dram U_dram_0 (
        .clk    (ram_clk),
        .a      (addr_tmp[15:2]),
        .spo    (rdata_o),
        .we     (we),
        .d      (wdata_i)
    );
endmodule
