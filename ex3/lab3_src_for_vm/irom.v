
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:33:32
// Design Name: 
// Module Name: prgrom
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
    input       [31:0]  addr_i,
    output      [31:0]  inst_o
    );
    // IP ��
    inst_mem imem(
        .a      (addr_i[17:2]),
        .spo    (inst_o)
    );
endmodule
