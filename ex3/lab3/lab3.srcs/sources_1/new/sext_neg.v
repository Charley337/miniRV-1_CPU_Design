`timescale 1ns / 1ps
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:36:42
// Design Name: 
// Module Name: sext_neg
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


module sext_neg(
    input       [24:0]  inst_i,
    input       [2:0]   sext_op,
    output  reg [31:0]  ext_o
    );
    // ×éºÏÂß¼­
    always @ (*) begin
        case(sext_op)
        `I_INST_ELSE    :   ext_o <= {inst_i[24], 20'hFFFFF, inst_i[23:13]};
        `S_INST         :   ext_o <= {inst_i[24], 20'hFFFFF, inst_i[23:18], inst_i[4:0]};
        `B_INST         :   ext_o <= {inst_i[24], 19'h7FFFF, inst_i[0], inst_i[23:18], inst_i[4:1], 1'b0};
        `U_INST         :   ext_o <= {inst_i[24:5], 12'h000};
        `J_INST         :   ext_o <= {inst_i[24], 11'h7FF, inst_i[12:5], inst_i[13], inst_i[23:14], 1'b0};
        `I_INST_SLLI    :   ext_o <= {27'h0, inst_i[17:13]};
        `I_INST_SLTIU   :   ext_o <= {inst_i[24], 20'h00000, inst_i[23:13]};
        default;
        endcase
    end
endmodule
