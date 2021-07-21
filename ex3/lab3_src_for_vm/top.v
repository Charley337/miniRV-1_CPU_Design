
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
    input               rst_n,
    output        debug_wb_have_inst,
    output [31:0] debug_wb_pc,
    output        debug_wb_ena,
    output [4:0]  debug_wb_reg,
    output [31:0] debug_wb_value
    );
    // �����ź�
    // ʱ�Ӻ͸�λ
    wire clk_cpu;
    wire clk_lock;
    wire pll_clk;
    wire clk_disp;
    // CPU
    // ����
    wire [31:0] cpu_irom_inst;
    wire [31:0] cpu_dram_rd_data;
    // ���
    wire [31:0] cpu_irom_addr;
    wire [31:0] cpu_dram_addr;
    wire [31:0] cpu_dram_wr_data;
    wire cpu_dram_we;
    // ��������õ��ź�
    wire cpu_debug_wb_have_inst;
    wire [31:0] cpu_debug_wb_pc;
    wire cpu_debug_wb_ena;
    wire [4:0] cpu_debug_wb_reg;
    wire [31:0] cpu_debug_wb_value;
    wire [31:0] cpu_debug_reg_x19;
    // IROM
    // ����
    wire [31:0] irom_addr;
    // ���
    wire [31:0] irom_inst;
    // MEMRAM
    // ����
    wire [31:0] dram_addr;
    wire [31:0] dram_wr_data;
    wire dram_we;
    // ���
    wire [31:0] dram_rd_data;
    // DISPLAY
    // ����
    wire display_busy;
    wire [7:0] display_z1;
    wire [7:0] display_r1;
    wire [7:0] display_z2;
    wire [7:0] display_r2;
    // ���
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

    // ʱ�Ӳ���
    assign clk_cpu = clk;
    
    divider U_divider_0(
        .clk_i      (clk),
        .rst_n_i    (rst_n),
        .clk_disp   (clk_disp)
    );

    // CPU 
    cpu U_cpu_0(
        .clk_cpu                (clk_cpu),
        .rst_n_i                (rst_n),
        .irom_inst              (cpu_irom_inst),              // ��irom������ָ��
        .dram_rdata             (cpu_dram_rd_data),             // ��dram����������
        .irom_addr              (cpu_irom_addr),              // �����irom�ĵ�ַ
        .dram_addr              (cpu_dram_addr),              // �����dram�ĵ�ַ
        .dram_wdata             (cpu_dram_wr_data),             // �����dram��д����
        .dram_we                (cpu_dram_we),                // �����dram�Ķ�д�����ź�
        // �����õ�����ź�
        .debug_wb_have_inst     (cpu_debug_wb_have_inst),
        .debug_wb_pc            (cpu_debug_wb_pc),
        .debug_wb_ena           (cpu_debug_wb_ena),
        .debug_wb_reg           (cpu_debug_wb_reg),
        .debug_wb_value         (cpu_debug_wb_value),
        .debug_reg_x19          (cpu_debug_reg_x19)
    );

    // irom����
    irom U_irom_0(
        .addr_i      (irom_addr),
        .inst_o     (irom_inst)
    );

    // memram����
    memram U_memram_0(
        .clk_i      (clk_cpu),
        .addr_i     (dram_addr),
        .we         (dram_we),
        .wdata_i    (dram_wr_data),
        .rdata_o    (dram_rd_data)
    );

    // display ����
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

    // ��ʼ����
    // ��λ
    // CPU
    assign cpu_irom_inst =      irom_inst;
    assign cpu_dram_rd_data =   dram_rd_data;
    // IROM
    assign irom_addr = cpu_irom_addr;
    // MEMRAM
    assign dram_addr =      cpu_dram_addr;
    assign dram_wr_data =   cpu_dram_wr_data;
    assign dram_we =        cpu_dram_we;
    // DISPLAY
    assign display_busy =   1'b0;
    assign display_z1 =     cpu_debug_reg_x19[31:24];
    assign display_r1 =     cpu_debug_reg_x19[23:16];
    assign display_z2 =     cpu_debug_reg_x19[15:8];
    assign display_r2 =     cpu_debug_reg_x19[7:0];

    // ����ź�
    //
    assign debug_wb_have_inst = cpu_debug_wb_have_inst;
    assign debug_wb_pc = cpu_debug_wb_pc;
    assign debug_wb_ena = cpu_debug_wb_ena;
    assign debug_wb_reg = cpu_debug_wb_reg;
    assign debug_wb_value = cpu_debug_wb_value;
    
endmodule
