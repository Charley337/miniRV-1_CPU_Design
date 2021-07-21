set_property SRC_FILE_INFO {cfile:c:/Users/Administrator/Desktop/tjx_riscv_2021_07_21/mini-rv-1_-design/ex3/lab3/lab3.srcs/sources_1/ip/cpuclk/cpuclk.xdc rfile:../../../lab3.srcs/sources_1/ip/cpuclk/cpuclk.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
