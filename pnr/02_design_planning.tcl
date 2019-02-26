##### create I/O pads and set locations #####
source ./design_data/insert_pads.tcl
read_pin_pad_physical_constraints ./design_data/pad_constraints.tdf
check_mv_design

##### floorplan and fp placement #####
source ./floorplan.tcl

##### manually specified PG connections #####
source ./upf.tcl

##### PG rings and straps #####
source ./powerplan.tcl

##### add end caps #####
#add_end_cap -mode bottom_left -lib_cell tcbn28hplbwphvt/BOUNDARY_LEFTBWP -respect_padding -respect_blockage -respect_keepout
#add_end_cap -mode upper_right -lib_cell tcbn28hplbwphvt/BOUNDARY_RIGHTBWP -respect_padding -respect_blockage -respect_keepout

##### add tap cells #####
#add_tap_cell_array -master_cell_name {TAPCELLBWP} -distance 20 -well_net_name $MW_POWER_NET -substrate_net_name $MW_GROUND_NET -connect_power_name $MW_POWER_NET -connect_ground_name $MW_GROUND_NET -respect_keepout -no_1x

##### fp place incr #####
create_fp_placement -incremental all
derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT
derive_pg_connection -power_net VDDIO -power_pin VDDIO -ground_net VSSIO -ground_pin VSSIO

##### preroute instances and std cells #####
preroute_instances -nets {VDD VSS} -ignore_macros -ignore_cover_cells -primary_routing_layer specified -specified_horizontal_layer M8 -specified_vertical_layer M9
preroute_instances -nets {VDDIO VSSIO} -specified_horizontal_layer M8 -specified_vertical_layer M9
preroute_standard_cells -connect horizontal -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn}

##### fp place incr #####
create_fp_placement -incremental all
derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT
