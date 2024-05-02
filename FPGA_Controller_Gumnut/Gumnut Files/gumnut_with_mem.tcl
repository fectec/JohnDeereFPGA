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

# Quartus Prime: Generate Tcl File for Project
# File: gumnut_with_mem.tcl
# Generated on: Wed May 01 00:42:26 2024

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "gumnut_with_mem"]} {
		puts "Project gumnut_with_mem is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists gumnut_with_mem]} {
		project_open -revision gumnut_with_mem gumnut_with_mem
	} else {
		project_new -revision gumnut_with_mem gumnut_with_mem
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "MAX 10"
	set_global_assignment -name DEVICE 10M50DAF484C7G
	set_global_assignment -name TOP_LEVEL_ENTITY GUMNUT_E7
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "14:33:53  JANUARY 18, 2021"
	set_global_assignment -name LAST_QUARTUS_VERSION "18.1.0 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name VHDL_FILE debounce.vhd
	set_global_assignment -name VERILOG_FILE inst_mem.v
	set_global_assignment -name VHDL_FILE "gumnut-rtl_unpipelined.vhd"
	set_global_assignment -name VHDL_FILE "gumnut_with_mem-struct.vhd"
	set_global_assignment -name VHDL_FILE gumnut_with_mem.vhd
	set_global_assignment -name VHDL_FILE gumnut_defs.vhd
	set_global_assignment -name VHDL_FILE gumnut.vhd
	set_global_assignment -name VERILOG_FILE data_mem.v
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name VHDL_FILE GUMNUT_E7.vhd
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_location_assignment PIN_P11 -to CLOCK_50
	set_location_assignment PIN_A7 -to KEY[1]
	set_location_assignment PIN_B8 -to KEY[0]
	set_location_assignment PIN_B11 -to LEDR[9]
	set_location_assignment PIN_A11 -to LEDR[8]
	set_location_assignment PIN_D14 -to LEDR[7]
	set_location_assignment PIN_E14 -to LEDR[6]
	set_location_assignment PIN_C13 -to LEDR[5]
	set_location_assignment PIN_D13 -to LEDR[4]
	set_location_assignment PIN_B10 -to LEDR[3]
	set_location_assignment PIN_A10 -to LEDR[2]
	set_location_assignment PIN_A9 -to LEDR[1]
	set_location_assignment PIN_A8 -to LEDR[0]
	set_location_assignment PIN_F15 -to SW[9]
	set_location_assignment PIN_B14 -to SW[8]
	set_location_assignment PIN_A14 -to SW[7]
	set_location_assignment PIN_A13 -to SW[6]
	set_location_assignment PIN_B12 -to SW[5]
	set_location_assignment PIN_A12 -to SW[4]
	set_location_assignment PIN_C12 -to SW[3]
	set_location_assignment PIN_D12 -to SW[2]
	set_location_assignment PIN_C11 -to SW[1]
	set_location_assignment PIN_C10 -to SW[0]
	set_location_assignment PIN_B20 -to DISPLAY[0]
	set_location_assignment PIN_A20 -to DISPLAY[1]
	set_location_assignment PIN_B19 -to DISPLAY[2]
	set_location_assignment PIN_A21 -to DISPLAY[3]
	set_location_assignment PIN_B21 -to DISPLAY[4]
	set_location_assignment PIN_C22 -to DISPLAY[5]
	set_location_assignment PIN_B22 -to DISPLAY[6]
	set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY
	set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY[1]
	set_instance_assignment -name IO_STANDARD "3.3 V SCHMITT TRIGGER" -to KEY[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[9]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[8]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[7]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[0]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[6]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[5]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[4]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[2]
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DISPLAY[1]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
