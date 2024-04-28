# Copyright (C) 2018  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition

package require ::quartus::project

set_location_assignment PIN_C10 -to d_in[0]
set_location_assignment PIN_C11 -to d_in[1]
set_location_assignment PIN_D12 -to d_in[2]
set_location_assignment PIN_C12 -to d_in[3]
set_location_assignment PIN_A12 -to d_in[4]
set_location_assignment PIN_B12 -to d_in[5]
set_location_assignment PIN_A13 -to d_in[6]
set_location_assignment PIN_A14 -to d_in[7]
set_location_assignment PIN_B14 -to reset_baudrate_gen
set_location_assignment PIN_F15 -to reset_UART_TX
set_location_assignment PIN_A8 -to tx_done_tick
set_location_assignment PIN_Y7 -to tx
set_location_assignment PIN_A7 -to tx_start
set_location_assignment PIN_P11 -to clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to d_in
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset_baudrate_gen
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset_UART_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to tx
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to tx_done_tick
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to tx_start
