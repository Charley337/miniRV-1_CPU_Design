
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 15:24:13
// Design Name: 
// Module Name: alu_add
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


module alu_add(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    output      [31:0]  c_o
    );
    assign c_o = a_i + b_i;
endmodule
