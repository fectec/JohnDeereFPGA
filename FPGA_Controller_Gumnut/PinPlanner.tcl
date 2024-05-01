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

set_location_assignment PIN_B8 -to KEY[0]
set_location_assignment PIN_A7 -to KEY[1]
set_location_assignment PIN_A8 -to LEDR[0]
set_location_assignment PIN_A9 -to LEDR[1]
set_location_assignment PIN_A10 -to LEDR[2]
set_location_assignment PIN_B10 -to LEDR[3]
set_location_assignment PIN_D13 -to LEDR[4]
set_location_assignment PIN_C13 -to LEDR[5]
set_location_assignment PIN_E14 -to LEDR[6]
set_location_assignment PIN_D14 -to LEDR[7]
set_location_assignment PIN_A11 -to LEDR[8]
set_location_assignment PIN_B11 -to LEDR[9]
set_location_assignment PIN_C10 -to SW[0]
set_location_assignment PIN_C11 -to SW[1]
set_location_assignment PIN_D12 -to SW[2]
set_location_assignment PIN_C12 -to SW[3]
set_location_assignment PIN_A12 -to SW[4]
set_location_assignment PIN_B12 -to SW[5]
set_location_assignment PIN_A13 -to SW[6]
set_location_assignment PIN_A14 -to SW[7]
set_location_assignment PIN_B14 -to SW[8]
set_location_assignment PIN_F15 -to SW[9]
set_location_assignment PIN_AB16 -to GSENSOR_CS_N
set_location_assignment PIN_Y14 -to GSENSOR_INT[1]
set_location_assignment PIN_AB15 -to GSENSOR_SCLK
set_location_assignment PIN_V11 -to GSENSOR_SDI
set_location_assignment PIN_V12 -to GSENSOR_SDO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ADC_CLK_10
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY[0]
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_CS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_INT[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_SDI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_SDO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ARDUINO_IO[15]
set_location_assignment PIN_P11 -to CLOCK_50
set_location_assignment PIN_AA8 -to GPIO_24
set_location_assignment PIN_Y7 -to GPIO_25
set_location_assignment PIN_C14 -to SEGMENTS[0]
set_location_assignment PIN_E15 -to SEGMENTS[1]
set_location_assignment PIN_C15 -to SEGMENTS[2]
set_location_assignment PIN_C16 -to SEGMENTS[3]
set_location_assignment PIN_E16 -to SEGMENTS[4]
set_location_assignment PIN_D17 -to SEGMENTS[5]
set_location_assignment PIN_C17 -to SEGMENTS[6]
set_location_assignment PIN_C18 -to SEGMENTS[7]
set_location_assignment PIN_D18 -to SEGMENTS[8]
set_location_assignment PIN_E18 -to SEGMENTS[9]
set_location_assignment PIN_B16 -to SEGMENTS[10]
set_location_assignment PIN_A17 -to SEGMENTS[11]
set_location_assignment PIN_A18 -to SEGMENTS[12]
set_location_assignment PIN_B17 -to SEGMENTS[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_24
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_25
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GSENSOR_INT[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SEGMENTS[0]
set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY
