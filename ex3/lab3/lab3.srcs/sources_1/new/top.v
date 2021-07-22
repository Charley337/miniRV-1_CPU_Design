`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 14:32:10
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
    input               clk,
    input               rst,
    output  reg         led0_en,
    output  reg         led1_en,
    output  reg         led2_en,
    output  reg         led3_en,
    output  reg         led4_en,
    output  reg         led5_en,
    output  reg         led6_en,
    output  reg         led7_en,
    output  reg         led_ca ,
    output  reg         led_cb ,
    output  reg         led_cc ,
    output  reg         led_cd ,
    output  reg         led_ce ,
    output  reg         led_cf ,
    output  reg         led_cg ,
    output  reg         led_dp
    );
    // 所有信号
    // 时钟和复位
    wire clk_cpu;
    wire clk_lock;
    wire pll_clk;
    wire clk_disp;
    wire rst_n;
    // CPU
    // 输入
    wire [31:0] cpu_irom_inst;
    wire [31:0] cpu_dram_rd_data;
    // 输出
    wire [31:0] cpu_irom_addr;
    wire [31:0] cpu_dram_addr;
    wire [31:0] cpu_dram_wr_data;
    wire cpu_dram_we;
    // 输出测试用的信号
    wire cpu_debug_wb_have_inst;
    wire [31:0] cpu_debug_wb_pc;
    wire cpu_debug_wb_ena;
    wire [4:0] cpu_debug_wb_reg;
    wire [31:0] cpu_debug_wb_value;
    wire [31:0] cpu_debug_reg_x19;
    // IROM
    // 输入
    wire [31:0] irom_addr;
    // 输出
    wire [31:0] irom_inst;
    // MEMRAM
    // 输入
    wire [31:0] dram_addr;
    wire [31:0] dram_wr_data;
    wire dram_we;
    // 输出
    wire [31:0] dram_rd_data;
    // DISPLAY
    // 输入
    wire display_busy;
    wire [7:0] display_z1;
    wire [7:0] display_r1;
    wire [7:0] display_z2;
    wire [7:0] display_r2;
    // 输出
    wire display_led0_en;
    wire display_led1_en;
    wire display_led2_en;
    wire display_led3_en;
    wire display_led4_en;
    wire display_led5_en;
    wire display_led6_en;
    wire display_led7_en;
    wire display_led_ca;
    wire display_led_cb;
    wire display_led_cc;
    wire display_led_cd;
    wire display_led_ce;
    wire display_led_cf;
    wire display_led_cg;
    wire display_led_dp;
    // 外设 PERIPHERAL
    // 输入
    wire [31:0] peripheral_addr;
    wire        peripheral_we;
    wire [31:0] peripheral_wdata;
    wire [23:0] peripheral_sw_data;
    // 输出
    wire [31:0] peripheral_rdata;
    wire [7:0]  peripheral_lt_high;
    wire [15:0] peripheral_lt_low;

    // 时钟部件
    cpuclk U_cpuclk_0(
        .clk_in1    (clk),
        .locked     (clk_lock),
        .clk_out1   (pll_clk)
    );
    assign clk_cpu = pll_clk & clk_lock;
    divider U_divider_0(
        .clk_i      (clk),
        .rst_n_i    (rst_n),
        .clk_disp   (clk_disp)
    );

    // CPU 
    cpu U_cpu_0(
        .clk_cpu                (clk_cpu),
        .rst_n_i                (rst_n),
        .irom_inst              (cpu_irom_inst),              // 从irom读到的指令
        .dram_rdata             (cpu_dram_rd_data),             // 从dram读到的数据
        .irom_addr              (cpu_irom_addr),              // 输出给irom的地址
        .dram_addr              (cpu_dram_addr),              // 输出给dram的地址
        .dram_wdata             (cpu_dram_wr_data),             // 输出给dram的写数据
        .dram_we                (cpu_dram_we),                // 输出给dram的读写控制信号
        // 测试用的输出信号
        .debug_wb_have_inst     (cpu_debug_wb_have_inst),
        .debug_wb_pc            (cpu_debug_wb_pc),
        .debug_wb_ena           (cpu_debug_wb_ena),
        .debug_wb_reg           (cpu_debug_wb_reg),
        .debug_wb_value         (cpu_debug_wb_value),
        .debug_reg_x19          (cpu_debug_reg_x19)
    );

    // irom部件
    irom U_irom_0(
        .addr_i      (irom_addr),
        .inst_o     (irom_inst)
    );

    // memram部件
    memram U_memram_0(
        .clk_i      (clk_cpu),
        .addr_i     (dram_addr),
        .we         (dram_we),
        .wdata_i    (dram_wr_data),
        .rdata_o    (dram_rd_data)
    );

    // display 部件
    display U_display_0(
        .clk            (clk_disp),
        .rst_n          (rst_n),
        .busy           (display_busy),
        .z1             (display_z1),
        .r1             (display_r1),
        .z2             (display_z2),
        .r2             (display_r2),
        .led0_en        (display_led0_en),
        .led1_en        (display_led1_en),
        .led2_en        (display_led2_en),
        .led3_en        (display_led3_en),
        .led4_en        (display_led4_en),
        .led5_en        (display_led5_en),
        .led6_en        (display_led6_en),
        .led7_en        (display_led7_en),
        .led_ca         (display_led_ca),
        .led_cb         (display_led_cb),
        .led_cc         (display_led_cc),
        .led_cd         (display_led_cd),
        .led_ce         (display_led_ce),
        .led_cf         (display_led_cf),
        .led_cg         (display_led_cg),
        .led_dp         (display_led_dp)
    );
    
    // 外设 PERIPHERAL
    peripheral U_peripheral_0(
        .clk_i          (clk_cpu),
        .rst_n_i        (rst_n),
        .addr_i         (peripheral_addr),
        .we_i           (peripheral_we),
        .wr_data_i      (peripheral_wdata),
        .sw_data_i      (peripheral_sw_data),
        .rd_data_o      (peripheral_rdata),
        .lt_high_o      (peripheral_lt_high),
        .lt_low_o       (peripheral_lt_low)
    );

    // 开始连线
    // 复位
    assign rst_n = ~rst;
    // CPU
    assign cpu_irom_inst =      irom_inst;
    assign cpu_dram_rd_data =   dram_rd_data;
    // IROM
    assign irom_addr = cpu_irom_addr;
    // MEMRAM
    assign dram_addr =          cpu_dram_addr;
    assign dram_wr_data =       cpu_dram_wr_data;
    assign dram_we =            (cpu_dram_addr[31:12] == 20'hFFFFF) ?   1'b0 : 
                                                                        cpu_dram_we;
    // 外设 PERIPHERAL
    assign peripheral_addr =    cpu_dram_addr;
    assign peripheral_we =      (cpu_dram_addr[31:12] == 20'hFFFFF) ?   cpu_dram_we : 
                                                                        1'b0;
    assign peripheral_wdata =   cpu_dram_wr_data;
    assign peripheral_sw_data = 24'h0;
    // DISPLAY
    assign display_busy =   1'b0;
    assign display_z1 =     cpu_debug_reg_x19[31:24];
    assign display_r1 =     cpu_debug_reg_x19[23:16];
    assign display_z2 =     cpu_debug_reg_x19[15:8];
    assign display_r2 =     cpu_debug_reg_x19[7:0];

    // 输出信号
    always @ (*) begin
        led0_en = display_led0_en;
    end
    always @ (*) begin
        led1_en = display_led1_en;
    end
    always @ (*) begin
        led2_en = display_led2_en;
    end
    always @ (*) begin
        led3_en = display_led3_en;
    end
    always @ (*) begin
        led4_en = display_led4_en;
    end
    always @ (*) begin
        led5_en = display_led5_en;
    end
    always @ (*) begin
        led6_en = display_led6_en;
    end
    always @ (*) begin
        led7_en = display_led7_en;
    end
    always @ (*) begin
        led_ca = display_led_ca;
    end
    always @ (*) begin
        led_cb = display_led_cb;
    end
    always @ (*) begin
        led_cc = display_led_cc;
    end
    always @ (*) begin
        led_cd = display_led_cd;
    end
    always @ (*) begin
        led_ce = display_led_ce;
    end
    always @ (*) begin
        led_cf = display_led_cf;
    end
    always @ (*) begin
        led_cg = display_led_cg;
    end
    always @ (*) begin
        led_dp = display_led_dp;
    end
endmodule
