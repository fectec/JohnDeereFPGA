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
# File: C:\Users\fecte\Downloads\Cuarto Semestre\QuartusPrimeProjects\VGA\pin_planning.tcl
# Generated on: Sun Apr 14 00:52:05 2024

package require ::quartus::project

set_location_assignment PIN_AA1 -to R[0]
set_location_assignment PIN_V1 -to R[1]
set_location_assignment PIN_Y2 -to R[2]
set_location_assignment PIN_Y1 -to R[3]
set_location_assignment PIN_W1 -to G[0]
set_location_assignment PIN_T2 -to G[1]
set_location_assignment PIN_R2 -to G[2]
set_location_assignment PIN_R1 -to G[3]
set_location_assignment PIN_P1 -to B[0]
set_location_assignment PIN_T1 -to B[1]
set_location_assignment PIN_P4 -to B[2]
set_location_assignment PIN_N2 -to B[3]
set_location_assignment PIN_N1 -to Vsync
set_location_assignment PIN_N3 -to Hsync
set_location_assignment PIN_P11 -to clk
set_location_assignment PIN_C10 -to left_s
set_location_assignment PIN_C11 -to right_s
set_location_assignment PIN_D12 -to down_s
set_location_assignment PIN_C12 -to up_s
set_location_assignment PIN_B8 -to restart
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Vsync
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Hsync
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to left_s
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to down_s
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to restart
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to right_s
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to up_s
