`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: irom
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


module irom(
    input       [31:0]  adr_i,
    output      [31:0]  inst_o
    );
    prgrom U_irom_0(              // ROM 13 Î»µØÖ·£¬32 Î»¿í
        .a      (adr_i[15:2]),
        .spo    (inst_o)
    );
endmodule
