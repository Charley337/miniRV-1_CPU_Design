`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/22 17:21:53
// Design Name: 
// Module Name: peripheral
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


module peripheral(
    input               clk_i,
    input               rst_n_i,
    input       [31:0]  addr_i,
    input               we_i,
    input       [31:0]  wr_data_i,
    input       [23:0]  sw_data_i,
    output      [31:0]  rd_data_o,
    output      [7:0]   lt_high_o,
    output      [15:0]  lt_low_o
    );
    wire [31:0] sw_data;
    wire [31:0] sw_high;
    wire [31:0] sw_low;
    reg [31:0] lt_high;
    reg [31:0] lt_low;
    
    assign sw_high = {24'h0, sw_data_i[23:16]};
    assign sw_low = {8'h0, sw_data_i[15:0]};
    assign sw_data = (addr_i[31:0] == 32'hFFFFF070) ?   sw_low : 
                     (addr_i[31:0] == 32'hFFFFF072) ?   sw_high : 
                                                        32'h0;
    assign rd_data_o = (addr_i[31:4] == 28'hFFFFF07) ?  sw_data :
                                                        32'h0;
    
    always @ (*) begin
        if (~rst_n_i) lt_high = 32'h0;
        else if (we_i && (addr_i[31:0] == 32'hFFFFF062)) lt_high = wr_data_i;
        else;
    end
    always @ (*) begin
        if (~rst_n_i) lt_low = 32'h0;
        else if (we_i && (addr_i[31:0] == 32'hFFFFF060)) lt_low = wr_data_i;
        else;
    end
    
    assign lt_high_o = lt_high[7:0];
    assign lt_low_o = lt_low[15:0];
endmodule
