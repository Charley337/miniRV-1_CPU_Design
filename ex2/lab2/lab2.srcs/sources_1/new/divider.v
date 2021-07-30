`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/10 22:09:59
// Design Name: 
// Module Name: divider
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


module divider(
    input           clk_i,
    input           rst_n_i,
    output  reg     clk_disp
    );
    reg [16:0] cnt;
    // 控制cnt变化，1ms一轮
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)                   cnt <= 17'd0;
        else if (cnt == 17'd99999)      cnt <= 17'd0;
        else                            cnt <= cnt + 1'b1;
    end
    
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)                   clk_disp <= 1'b0;
        else if (cnt == 17'd99998)      clk_disp <= ~clk_disp;
        else;
    end
endmodule
