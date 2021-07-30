`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 15:45:50
// Design Name: 
// Module Name: alu_sll_sim
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


module alu_sll_sim();
reg [31:0] a_i;
reg [31:0] b_i;
wire [31:0] c_o;

alu_sll U_alu_sll_0(
    .a_i    (a_i),
    .b_i    (b_i),
    .c_o    (c_o)
);

initial begin
    #5 begin
        a_i = 32'h0000_0034;
        b_i = 32'h0000_0002;
    end
end

endmodule
