`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: npc
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


module npc(
    input   clk_i,
    input               rst_n_i,
    input       [31:0]  pc_i,
    input       [31:0]  imm_i,
    input       [1:0]   npc_op,
    output  reg [31:0]  npc_o,
    output  reg [31:0]  pc4_o
    );
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i) begin     // 复位
            pc4_o <= 32'h0000_0004;
            npc_o <= 32'h0000_0004;
        end
        else begin
            case(npc_op)        // 根据控制信号 npc_op 来选择模式
            2'b01   :   begin
                pc4_o <= pc_i + 32'h4;
                npc_o <= pc_i + imm_i;
            end
            default :   begin
                pc4_o <= pc_i + 32'h4;
                npc_o <= pc_i + 32'h4;
            end
            endcase
        end
    end
endmodule
