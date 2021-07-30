`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/10 22:39:53
// Design Name: 
// Module Name: divider_tb
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


module divider_tb();
// input
reg clk_i;
reg rst_n_i;
// output
wire clk_disp;

divider U_divider_0(
    .clk_i      (clk_i),
    .rst_n_i    (rst_n_i),
    .clk_disp   (clk_disp)
);

always #5 clk_i = ~clk_i;

initial begin
    #0  rst_n_i = 0;
    #0  clk_i = 0;
    #20 rst_n_i = 1;
end

endmodule
