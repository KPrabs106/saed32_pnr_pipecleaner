# Library setup
source ../pnr/saed32_setup.tcl

# The above setup file must set
# search_path
# target_library
# for primetime

set link_path "* $target_library"

set power_enable_analysis "true"

set report_path "primetime_reports"
# Make sure that the folder exists, or that it is created in the run_pt_timing file

read_verilog "../pnr/top.v"
current_design "top"
read_sdc "../pnr/top.sdc"
read_parasitics -format spef "../pnr/top.spef.max"
complete_net_parasitics -complete_with wlm
set_propagated_clock [all_clocks]

report_timing > ${report_path}/timing.rpt
report_design > ${report_path}/design.rpt
report_clock > ${report_path}/clock.rpt
report_clock -skew > ${report_path}/skew.rpt
check_timing -verbose >> ${report_path}/timing_check.rpt
report_wire_load > ${report_path}/wire_load.rpt
report_port > ${report_path}/misc.rpt
report_net >> ${report_path}/misc.rpt
report_hier > ${report_path}/hier.rpt
report_reference >> ${report_path}/misc.rpt
report_path_group >> ${report_path}/misc.rpt
report_timing -max_paths 100 -delay_type max -slack_lesser_than 45.0 > ${report_path}/timing_setup.rpt
report_timing -max_paths 100 -delay_type min -path full_clock_expanded -slack_lesser_than 0.5 > ${report_path}/timing_hold.rpt
report_bottleneck > ${report_path}/timing_bottleneck.rpt
report_analysis_coverage > ${report_path}/analysis_coverage.rpt
