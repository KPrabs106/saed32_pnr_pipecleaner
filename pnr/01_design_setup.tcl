##### library setup #####
source ./saed32_setup.tcl

#Create Milkyway Physical Library
set mw_design_library $par_dir/${design_name}_mwlib

file delete -force $mw_design_library

create_mw_lib $mw_design_library -technology $TECH_FILE -mw_reference_library $MW_REFERENCE_LIB_DIRS
open_mw_lib $mw_design_library
set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -min_tluplus $TLUPLUS_MIN_FILE -tech2itf_map $MAP_FILE

##### import design #####
import_designs -format verilog -top chip [concat ../rtl/chip.v ../syn/top.v]
uniquify_fp_mw_cel

set_fix_multiple_port_nets -outputs -exclude_clock_network

##### tie cell constraints #####
set_auto_disable_drc_nets -constant false
set_app_var physopt_new_fix_constants true
set tieoff_hierarchy_opt true
set tieoff_hierarchy_opt_keep_driver true
#set_attribute [get_lib_pins tcbn28hplbwphvttt1v25c/TIEHBWPHVT/Z] max_fanout 10 -type float
#set_attribute [get_lib_pins tcbn28hplbwphvttt1v25c/TIELBWPHVT/ZN] max_fanout 10 -type float
#set_attribute [get_lib_pins tcbn28hplbwphvttt1v25c/TIEHBWPHVT/Z] max_capacitance 0.2 -type float
#set_attribute [get_lib_pins tcbn28hplbwphvttt1v25c/TIELBWPHVT/ZN] max_capacitance 0.2 -type float

##### timing constraints #####
source ./constraints.tcl
