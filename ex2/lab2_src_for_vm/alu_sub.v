
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 15:30:18
// Design Name: 
// Module Name: alu_sub
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


module alu_sub(
    input       [31:0]  a_i,
    input       [31:0]  b_i,
    output      [31:0]  c_o
    );
    wire [31:0] b_n;
    // 例化一个取负逻辑
    alu_neg_num U_alu_neg_num_0 (
        .imm_i      (b_i),
        .n_imm_o    (b_n)
    );
    // 减法就是加上负数的补码
    assign c_o = a_i + b_n;
endmodule
