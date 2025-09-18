###############################################################################
# Created by write_sdc
###############################################################################
current_design top
###############################################################################
# Timing Constraints
###############################################################################
create_clock [get_ports $::env(CLOCK_PORT)] -name clk -period 10
set_clock_uncertainty 0.2500 clk
set_input_delay 1.2000 -clock [get_clocks {clk}] -add_delay [get_ports -regexp {a.* b.*}]
set_output_delay 1.2000 -clock [get_clocks {clk}] -add_delay [all_outputs]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [all_outputs]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports -regexp {a.* b.*}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_capacitance 0.2000 [current_design]
set_max_fanout 10.0000 [current_design]
