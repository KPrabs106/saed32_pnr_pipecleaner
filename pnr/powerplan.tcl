##### Manual powerplanning approach using template file #####
create_rectangular_rings -nets {VDD VSS} -left_offset 5 -left_segment_layer M9 -left_segment_width 4 -right_offset 5 -right_segment_layer M9 -right_segment_width 4 -bottom_offset 5 -bottom_segment_layer M8 -bottom_segment_width 2 -top_offset 5 -top_segment_layer M8 -top_segment_width 2

set_power_plan_strategy core \
-nets {VDD VSS} \
-core \
-template saed_32nm.tpl:m89_mesh(2.0,2.0) \
-extension {stop: outermost_ring}

#set_power_plan_strategy core_m3 \
#-nets {VDD VSS} \
#-core \
#-template saed_32nm.tpl:m3_mesh(0.5) \
#-extension {stop: design_boundary}
#

compile_power_plan
# LCM of M8 and M9 pitch


##### Automatic power planning approach using power constraints #####
#set pitch 2.432
#
#set_fp_rail_constraints -add_layer  -layer M9 -direction vertical -max_pitch 30.4 -min_pitch $pitch -max_width 5 -min_width 3 -spacing minimum
#set_fp_rail_constraints -add_layer  -layer M8 -direction horizontal -max_pitch 30.4 -min_pitch $pitch  -max_width 5 -min_width 3 -spacing minimum
#
## 
##set_fp_rail_constraints -set_global   -no_routing_over_hard_macros -no_routing_over_soft_macros
##set_fp_block_ring_constraints -add -nets {VDD VSS} -horizontal_layer M8 -vertical_layer M9 -horizontal_offset 5 -vertical_offset 5 -horizontal_width 5 -vertical_width 5
#
#synthesize_fp_rail  -nets {VDD VSS} -voltage_supply 1.2 -synthesize_power_plan -power_budget 100 -use_strap_ends_as_pads
#commit_fp_rail
#
#derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT
#set_preroute_drc_strategy -min_layer M2 -max_layer MRDL

##### End #####
# Connect power pads to ring... ignore this for now
#preroute_instances -ignore_macros -ignore_cover_cells \
#-connect_instances specified \
#-cells [get_cells -all {pad_vdd pad_vss}] \
#-select_net_by_type specified \
#-nets {VDD VSS} \
#-primary_routing_layer pin
