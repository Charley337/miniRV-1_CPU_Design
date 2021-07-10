
`include "param.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 16:25:35
// Design Name: 
// Module Name: top
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


module top(
    input   clk,
    input   rst_n,
    output                  debug_wb_have_inst,
    output   [31:0]       debug_wb_pc,
    output                  debug_wb_ena,
    output   [4:0]         debug_wb_reg,
    output    [31:0]      debug_wb_value
    );
    // 连接信号
    // 时钟
    wire clk_cpu;
    assign clk_cpu = clk;
    // CPU
    // 输入
    wire [31:0] cpu_irom_inst;
    wire [31:0] cpu_dram_rd_data;
    // 输出
    wire [31:0] cpu_irom_adr;
    wire [31:0] cpu_dram_addr;
    wire [31:0] cpu_dram_wr_data;
    wire cpu_dram_memwr;
    // 输出测试用的信号
    wire cpu_debug_wb_have_inst;
    wire [31:0] cpu_debug_wb_pc;
    wire cpu_debug_wb_ena;
    wire [4:0] cpu_debug_wb_reg;
    wire [31:0] cpu_debug_wb_value;
    // IROM
    // 输入
    wire [31:0] irom_adr;
    // 输出
    wire [31:0] irom_inst;
    // MEMRAM
    // 输入
    wire [31:0] dram_addr;
    wire [31:0] dram_wr_data;
    wire dram_memwr;
    // 输出
    wire [31:0] dram_rd_data;
    
    // cpu部件
    cpu U_cpu_0(
        .clk_cpu            (clk_cpu),
        .rst_n_i            (rst_n),
        .irom_inst          (cpu_irom_inst),
        .dram_rd_data       (cpu_dram_rd_data),
        .irom_adr           (cpu_irom_adr),
        .dram_addr          (cpu_dram_addr),
        .dram_wr_data       (cpu_dram_wr_data),
        .dram_memwr         (cpu_dram_memwr),
        .debug_wb_have_inst (cpu_debug_wb_have_inst),
        .debug_wb_pc        (cpu_debug_wb_pc),
        .debug_wb_ena       (cpu_debug_wb_ena),
        .debug_wb_reg       (cpu_debug_wb_reg),
        .debug_wb_value     (cpu_debug_wb_value)
    );
    // irom部件
    irom U_irom_0(
        .adr_i      (irom_adr),
        .inst_o     (irom_inst)
    );
    // memram部件
    memram U_memram_0(
        .clk_i      (clk_cpu),
        .addr_i     (dram_addr),
        .memwr_i    (dram_memwr),
        .wr_data_i  (dram_wr_data),
        .rd_data_o  (dram_rd_data)
    );
    
    // 开始连线
    // CPU
    assign cpu_irom_inst    = irom_inst;
    assign cpu_dram_rd_data = dram_rd_data;
    // IROM
    assign irom_adr =   cpu_irom_adr;
    // MEMRAM
    assign dram_addr    =   cpu_dram_addr;
    assign dram_wr_data =   cpu_dram_wr_data;
    assign dram_memwr   =   cpu_dram_memwr;

    // 输出测试用的信号
    assign debug_wb_have_inst = cpu_debug_wb_have_inst;
    assign debug_wb_pc = cpu_debug_wb_pc;
    assign debug_wb_ena = cpu_debug_wb_ena;
    assign debug_wb_reg = cpu_debug_wb_reg;
    assign debug_wb_value = cpu_debug_wb_value;
endmodule
