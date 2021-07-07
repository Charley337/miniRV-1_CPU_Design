`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 15:32:24
// Design Name: 
// Module Name: top_sim
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


module top_sim();
reg clk_i;
reg rst_n_i;

top U_top_0(
    .clk_i      (clk_i),
    .rst_n_i    (rst_n_i)
);

initial begin
    #0 begin
        clk_i = 0;
        rst_n_i = 0;
    end
    #20 rst_n_i = 1;
end

always begin
    #5 clk_i = ~clk_i;
end
endmodule
