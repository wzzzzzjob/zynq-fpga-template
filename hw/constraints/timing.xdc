## ACZ7015 (Zynq-7015) FPGA-side pins

# 50MHz clock input
set_property PACKAGE_PIN L5 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]

# Key (use as reset_n)
set_property PACKAGE_PIN R4 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]
set_property PULLUP true [get_ports sys_rst_n]

# LEDs
set_property PACKAGE_PIN P7 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

set_property PACKAGE_PIN R7 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
