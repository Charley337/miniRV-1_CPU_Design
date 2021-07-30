
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
    data_mem dmem(
        .clk    (ram_clk),
        .a      (addr_i[17:2]),
        .spo   (rd_data_o),
        .we     (memwr_i),
        .d      (wr_data_i)
    );
endmodule
