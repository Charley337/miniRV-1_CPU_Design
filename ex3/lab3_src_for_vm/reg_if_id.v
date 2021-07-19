
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:54:14
// Design Name: 
// Module Name: reg_if_id
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


module reg_if_id(
    input               clk_i,
    input               rst_n_i,
    input       [31:0]  if_pc4,
    input       [31:0]  if_inst,
    input       [31:0]  if_pc,
    input               if_have_inst,

    output  reg [31:0]  id_pc4,
    output  reg [31:0]  id_inst,
    output  reg [31:0]  id_pc,
    output  reg         id_have_inst
    );
    // ¿ØÖÆ id_pc4
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   id_pc4 <= if_pc4;
        else            id_pc4 <= if_pc4;
    end
    
    // ¿ØÖÆ id_inst
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   id_inst <= 32'h0;
        else            id_inst <= if_inst;
    end
    
    // ¿ØÖÆ id_pc
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   id_pc <= 32'h0;
        else            id_pc <= if_pc;
    end

    // id_have_inst
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   id_have_inst <= 1'b0;
        else            id_have_inst <= if_have_inst;
    end
endmodule
