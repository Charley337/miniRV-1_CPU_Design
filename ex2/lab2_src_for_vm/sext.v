
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


// ��Ӧ��ϵ
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
    output      [31:0]  ext_o
    );
    wire [31:0] ext_pos;
    wire [31:0] ext_neg;
    // �����ķ�����չ��Ԫ
    sext_pos U_sext_pos_0(
        .inst_i     (inst_i),
        .sext_op    (sext_op),
        .ext_o      (ext_pos)
    );
    // �����ķ�����չ��Ԫ
    sext_neg U_sext_neg_0(
        .inst_i     (inst_i),
        .sext_op    (sext_op),
        .ext_o      (ext_neg)
    );
    assign ext_o = inst_i[24] ? ext_neg : ext_pos;      // ��������������������ķ�����չ������Ǹ������ø����ķ���
endmodule
