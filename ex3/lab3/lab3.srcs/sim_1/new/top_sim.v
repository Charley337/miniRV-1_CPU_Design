`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/23 00:41:38
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
reg clk;
reg rst;
reg  [23:0] sw_data;
wire [23:0] lt_data;
wire led0_en;
wire led1_en;
wire led2_en;
wire led3_en;
wire led4_en;
wire led5_en;
wire led6_en;
wire led7_en;
wire led_ca;
wire led_cb;
wire led_cc;
wire led_cd;
wire led_ce;
wire led_cf;
wire led_cg;
wire led_dp;

top U_top_0(
    .clk        (clk),
    .rst        (rst),
    .sw_data    (sw_data),
    .lt_data    (lt_data),
    .led0_en    (led0_en),
    .led1_en    (led1_en),
    .led2_en    (led2_en),
    .led3_en    (led3_en),
    .led4_en    (led4_en),
    .led5_en    (led5_en),
    .led6_en    (led6_en),
    .led7_en    (led7_en),
    .led_ca     (led_ca),
    .led_cb     (led_cb),
    .led_cc     (led_cc),
    .led_cd     (led_cd),
    .led_ce     (led_ce),
    .led_cf     (led_cf),
    .led_cg     (led_cg),
    .led_dp     (led_dp)
);

always begin
    #5 clk = ~clk;
end

initial begin
    #0 begin
        clk = 1'b0;
        rst = 1'b1;
        sw_data = 24'h6;
    end
    #22 begin
        rst = 1'b0;
    end
end

endmodule
