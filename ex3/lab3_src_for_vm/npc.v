
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:31:54
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
    input       [31:0]  pc_i,
    input       [31:0]  pc_pc_i,        // 当前pc的值（主要用于pc+4）
    input       [31:0]  imm_i,
    input       [1:0]   npc_op,
    output      [31:0]  npc_o
    );
    // 都用组合逻辑
    assign npc_o =          (npc_op == `NPC_OP_PC_IMM_JALR)     ?   ((pc_i + imm_i) & 32'hFFFF_FFFE) : 
                            (npc_op == `NPC_OP_PC_ADD_IMM)      ?   (pc_i + imm_i) : 
                                                                        (pc_pc_i + 32'h4);
endmodule
