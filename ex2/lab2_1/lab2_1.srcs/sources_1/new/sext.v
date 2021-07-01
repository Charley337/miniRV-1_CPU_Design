`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: sext
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


// 对应关系
// inst[31:7]   ------  inst_i[24:0]
// inst[31:20]  ------  inst_i[24:13]
// inst[31:25]  ------  inst_i[24:18]
// inst[11:7]   ------  inst_i[4:0]
// inst[31]     ------  inst_i[24]
// inst[7]      ------  inst_i[0]
// inst[30:25]  ------  inst_i[23:18]
// inst[11:8]   ------  inst_i[4:1]
// inst[31:12]  ------  inst_i[24:5]
// inst[19:12]  ------  inst_i[12:5]
// inst[20]     ------  inst_i[13]
// inst[30:21]  ------  inst_i[23:14]
module sext(
    input       [24:0]  inst_i,     // inst[31:7]
    input       [2:0]   sext_op,
    output  reg [31:0]  ext_o
    );
    // 组合逻辑
    always @ (*) begin
        case(sext_op)
        3'b000  :   ext_o <= {inst_i[24], 20'h00000, inst_i[23:13]};
        3'b001  :   ext_o <= {inst_i[24], 20'h00000, inst_i[23:18], inst_i[4:0]};
        3'b010  :   ext_o <= {inst_i[24], 20'h00000, inst_i[0], inst_i[23:18], inst_i[4:1]};
        3'b011  :   ext_o <= {inst_i[24:5], 12'h000};
        3'b100  :   ext_o <= {inst_i[24], 11'h0, inst_i[12:5], inst_i[13], inst_i[23:14], 1'b0};
        default :   ext_0 <= 32'h0;
        endcase
    end
endmodule
