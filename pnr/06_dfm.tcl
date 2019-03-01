##### add std cell filler and decap #####
insert_stdcell_filler -no_1x -cell_with_metal "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT" -connect_to_power {VDD} -connect_to_ground {VSS} -respect_keepout -metal_filler_coverage_area 500000 -respect_overlap


route_opt -incremental -size_only

##### postroute redundant via insertion #####
#source /tsmc28/pdk/2016.09.28/TN28CLPR002S1_1_5A/N28_PRTF_Syn_v1d5a/N28_PRTF_Syn_v1d5a/PR_tech/Synopsys/DFMViaSwapTcl/n28_ICC_DFMSWAP_4X2Y1Z_HVH.tcl

##### add std cell filler #####
insert_stdcell_filler -no_1x -cell_with_metal "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT" -connect_to_power {VDD} -connect_to_ground {VSS} -respect_keepout -respect_overlap

##### add well filler #####
insert_well_filler -layer NWELL -fill_gaps_smaller_than 15

derive_pg_connection -power_net $MW_POWER_NET -ground_net $MW_GROUND_NET -power_pin $MW_POWER_PORT -ground_pin $MW_GROUND_PORT

##Final Route clean-up - if needed:
##Once we hit minor cleanup, best to turn off ZRoute timing options
##This avoids extraction/timing hits
set_route_zrt_global_options -timing_driven false -crosstalk_driven false
set_route_zrt_track_options -timing_driven false -crosstalk_driven false
set_route_zrt_detail_options -timing_driven false

route_zrt_eco               ;#catch any opens and try to re-route them, recheck DRC

derive_pg_connection -power_net $MW_POWER_NET -ground_net $MW_GROUND_NET -power_pin $MW_POWER_PORT -ground_pin $MW_GROUND_PORT

remove_unconnected_ports -blast_buses [get_cells -all -hierarchical]
report_tie_nets

verify_lvs
