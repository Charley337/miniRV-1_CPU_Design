`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:25:35
// Design Name: 
// Module Name: top
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


module top(
    input   clk_i,
    input   rst_n_i
    );
    wire clk_cpu;
    cpuclk U_cpuclk(
        .clk_in1    (clk_i),
        .clk_out1   (clk_cpu)
    );
    
endmodule
