`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: pc
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


module pc(
    input               clk_i,
    input               rst_n_i,
    input       [31:0]  din_i,
    output  reg [31:0]  pc_o
    );
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   pc_o <= 32'h0000_0000;
        else            pc_o <= din_i;
    end
endmodule
