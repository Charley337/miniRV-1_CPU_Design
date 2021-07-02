`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 16:09:13
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
    // define local parameter
    localparam  I_INST  = 3'b000;
    localparam  S_INST  = 3'b001;
    localparam  B_INST  = 3'b010;
    localparam  U_INST  = 3'b011;
    localparam  J_INST  = 3'b100;
    // ×éºÏÂß¼­
    always @ (*) begin
        case(sext_op)
        I_INST  :   ext_o <= {inst_i[24], 20'hFFFFF, inst_i[23:13]};
        S_INST  :   ext_o <= {inst_i[24], 20'hFFFFF, inst_i[23:18], inst_i[4:0]};
        B_INST  :   ext_o <= {inst_i[24], 20'hFFFFF, inst_i[0], inst_i[23:18], inst_i[4:1]};
        U_INST  :   ext_o <= {inst_i[24:5], 12'hFFF};
        J_INST  :   ext_o <= {inst_i[24], 11'h7FF, inst_i[12:5], inst_i[13], inst_i[23:14], 1'b0};
        default;
        endcase
    end
endmodule
