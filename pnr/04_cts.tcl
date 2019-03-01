#set_clock_tree_references -references [remove_from_collection [get_lib_cells {tcbn28hplbwplvttt1v25c/CKND* tcbn28hplbwplvttt1v25c/CKBD*}] tcbn28hplbwplvttt1v25c/CKND2D*]
#set_clock_tree_references -sizing_only -references [get_lib_cells {tcbn28hplbwplvttt1v25c/CKAN2D* tcbn28hplbwplvttt1v25c/CKLHQD* tcbn28hplbwplvttt1v25c/CKLNQD* tcbn28hplbwplvttt1v25c/CKMUX2D* tcbn28hplbwplvttt1v25c/CKND2D* tcbn28hplbwplvttt1v25c/CKXOR2D*}]

report_clock
report_clock -skew
report_clock_tree -summary
report_constraint -all

set_fix_hold_options -effort high
set_fix_hold [all_clocks]

check_physical_design -stage pre_clock_opt

clock_opt -fix_hold_all_clocks
report_clock_tree
report_timing

derive_pg_connection -power_net $MW_POWER_NET -ground_net $MW_GROUND_NET -power_pin $MW_POWER_PORT -ground_pin $MW_GROUND_PORT

save_mw_cel -as ${design_name}_cts.CEL
