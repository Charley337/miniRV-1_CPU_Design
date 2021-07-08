
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:24:59
// Design Name: 
// Module Name: pc
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


module pc(
    input               clk_i,
    input               rst_n_i,
    input       [31:0]  din_i,
    output  reg [31:0]  pc_o,
    output      [31:0]  pc4_o
    );
    reg state;
    // 状态机
    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i) state <= 1'b0;
        else begin
            state <= 1'b1;
        end
    end

    always @ (posedge clk_i or negedge rst_n_i) begin
        if (~rst_n_i)   pc_o <= 32'h0000_0000;
        else            pc_o <= state ? din_i : 32'h0;
    end

    assign pc4_o = pc_o + 32'h4;
endmodule
