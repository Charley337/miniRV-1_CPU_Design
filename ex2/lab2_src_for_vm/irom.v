
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
    inst_mem imem(              // ROM 13 λ��ַ��32 λ��
        .a      (adr_i[17:2]),
        .spo    (inst_o)
    );
endmodule
