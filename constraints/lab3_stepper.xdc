# Combo II-DLD S75 / MAIN CLOCK F = 50 MHz.

set_property PACKAGE_PIN B6 [get_ports clk_50mhz]
set_property PACKAGE_PIN K4 [get_ports rst_p]
set_property PACKAGE_PIN N8 [get_ports enable]
set_property PACKAGE_PIN N4 [get_ports direction]

set_property PACKAGE_PIN Y20 [get_ports {stepmotor[3]}]
set_property PACKAGE_PIN Y22 [get_ports {stepmotor[2]}]
set_property PACKAGE_PIN AA20 [get_ports {stepmotor[1]}]
set_property PACKAGE_PIN AA21 [get_ports {stepmotor[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports *]

create_clock -name clk_50mhz -period 20.000 [get_ports clk_50mhz]

set_false_path -from [get_ports {rst_p enable direction}]
