`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/22 16:03:23
// Design Name: 
// Module Name: rdata_helper
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


module rdata_helper(
    input       [31:0]  rdata_i,
    input       [1:0]   addr_i,
    output      [31:0]  wb_lb_o,
    output      [31:0]  wb_lh_o
    );
    wire [23:0] middle_24;
    wire [15:0] middle_16;
    wire        head_8;
    wire [6:0]  body_8;
    wire        head_16;
    wire [14:0] body_16;

    assign middle_24 =  (addr_i[1:0] == 2'b00)  ?   (24'h0 - rdata_i[7]) : 
                        (addr_i[1:0] == 2'b01)  ?   (24'h0 - rdata_i[15]) : 
                        (addr_i[1:0] == 2'b10)  ?   (24'h0 - rdata_i[23]) : 
                        (addr_i[1:0] == 2'b11)  ?   (24'h0 - rdata_i[31]) : 
                                                    (24'h0 - rdata_i[7]);
    assign middle_16 =  (addr_i[1] == 1'b0)     ?   (16'h0 - rdata_i[15]) : 
                        (addr_i[1] == 1'b1)     ?   (16'h0 - rdata_i[31]) : 
                                                    (16'h0 - rdata_i[15]);
    assign head_8 =     (addr_i[1:0] == 2'b00)  ?   rdata_i[7] : 
                        (addr_i[1:0] == 2'b01)  ?   rdata_i[15] : 
                        (addr_i[1:0] == 2'b10)  ?   rdata_i[23] : 
                        (addr_i[1:0] == 2'b11)  ?   rdata_i[31] : 
                                                    rdata_i[7];
    assign body_8 =     (addr_i[1:0] == 2'b00)  ?   rdata_i[6:0] : 
                        (addr_i[1:0] == 2'b01)  ?   rdata_i[14:8] :
                        (addr_i[1:0] == 2'b10)  ?   rdata_i[22:16] :
                        (addr_i[1:0] == 2'b11)  ?   rdata_i[30:24] :
                                                    rdata_i[6:0];
    assign head_16 =    (addr_i[1] == 1'b0)     ?   rdata_i[15] : 
                        (addr_i[1] == 1'b1)     ?   rdata_i[31] : 
                                                    rdata_i[15];
    assign body_16 =    (addr_i[1] == 1'b0)     ?   rdata_i[14:0] : 
                        (addr_i[1] == 1'b1)     ?   rdata_i[30:16] :
                                                    rdata_i[14:0];
    assign wb_lb_o =    {head_8, middle_24, body_8};
    assign wb_lh_o =    {head_16, middle_16, body_16};
endmodule
