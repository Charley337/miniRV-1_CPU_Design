
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:38:03
// Design Name: 
// Module Name: alu_neg_num
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


module alu_neg_num(
    input       [31:0]  imm_i,
    output      [31:0]  n_imm_o
    );
    // ��� imm_i ����������ôֻҪȡ����������룻��� imm_i �Ǹ�������ôֻҪ������ȡ��
    wire [31:0] imm_pos;
    wire [31:0] imm_neg;
    // imm_pos: ��ȡ����������
    assign imm_pos = ~imm_i + 1;
    // imm_neg: �����룬��ȡ��
    wire [31:0] imm_n1;
    assign imm_n1 = {imm_i[31], ~imm_i[30:0]} + 1;
    assign imm_neg = {~imm_n1[31], imm_n1[30:0]};
    // ��� imm_i �������ͨ imm_neg; ����������ͨ imm_pos;
    assign n_imm_o = imm_i[31] ? imm_neg : imm_pos;
endmodule
