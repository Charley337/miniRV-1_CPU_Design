
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
    wire ram_clk;
    assign ram_clk = ~clk_i;
    data_mem dmem(
        .clk    (ram_clk),
        .a      (addr_i[17:2]),
        .spo    (rdata_o),
        .we     (we),
        .d      (wdata_i)
    );
endmodule
