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

set_location_assignment PIN_B8 -to KEY_i[0]
set_location_assignment PIN_A7 -to KEY_i[1]
set_location_assignment PIN_AB16 -to GSENSOR_CS_N_i
set_location_assignment PIN_Y14 -to GSENSOR_INT_i[1]
set_location_assignment PIN_AB15 -to GSENSOR_SCLK_i
set_location_assignment PIN_V11 -to GSENSOR_SDI_i
set_location_assignment PIN_V12 -to GSENSOR_SDO_i
set_location_assignment PIN_A8 -to accelerometer_x_value_i[9]
set_location_assignment PIN_A9 -to accelerometer_x_value_i[8]
set_location_assignment PIN_A10 -to accelerometer_x_value_i[7]
set_location_assignment PIN_B10 -to accelerometer_x_value_i[6]
set_location_assignment PIN_D13 -to accelerometer_x_value_i[5]
set_location_assignment PIN_C13 -to accelerometer_x_value_i[4]
set_location_assignment PIN_E14 -to accelerometer_x_value_i[3]
set_location_assignment PIN_D14 -to accelerometer_x_value_i[2]
set_location_assignment PIN_A11 -to accelerometer_x_value_i[1]
set_location_assignment PIN_B11 -to accelerometer_x_value_i[0]
set_location_assignment PIN_P1 -to B_i[0]
set_location_assignment PIN_T1 -to B_i[1]
set_location_assignment PIN_P4 -to B_i[2]
set_location_assignment PIN_N2 -to B_i[3]
set_location_assignment PIN_P11 -to clk_i
set_location_assignment PIN_C10 -to down_s_i
set_location_assignment PIN_C11 -to up_s_i
set_location_assignment PIN_W1 -to G_i[0]
set_location_assignment PIN_T2 -to G_i[1]
set_location_assignment PIN_R2 -to G_i[2]
set_location_assignment PIN_R1 -to G_i[3]
set_location_assignment PIN_AA1 -to R_i[0]
set_location_assignment PIN_V1 -to R_i[1]
set_location_assignment PIN_Y2 -to R_i[2]
set_location_assignment PIN_Y1 -to R_i[3]
set_location_assignment PIN_N3 -to Hsync_i
set_location_assignment PIN_N1 -to Vsync_i
set_location_assignment PIN_D12 -to restart_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to accelerometer_x_value_i[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B_i[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B_i[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B_i[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to B_i[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to down_s_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G_i[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G_i[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G_i[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to G_i[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_CS_N_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_INT_i[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_SCLK_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_SDI_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_SDO_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Hsync_i
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY_i[1]
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY_i[0]
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R_i[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to Vsync_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to up_s_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to restart_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R_i[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R_i[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to R_i[2]
