source -echo -verbose ../pnr/saed32_setup.tcl
set link_path "* $target_library"

set report_path "primetime_power_reports"

read_verilog "../pnr/top.v"
current_design "top"
read_sdc "../pnr/top.sdc"
read_parasitics -format spef "../pnr/top.spef.max"
complete_net_parasitics -complete_with wlm
set_propagated_clock [all_clocks]

set power_enable_analysis true
set power_analysis_mode averaged
set power_clock_network_include_clock_gating_network true
set power_clock_network_include_register_clock_pin_power true
set power_enable_multi_rail_analysis true
set power_limit_extrapolation_range true

update_timing -full
read_vcd "../verif/chip_PR.vpd" -strip_path "tb/inst_top"
read_saif "../verif/chip_PR.saif" -strip_path "tb/inst_top"
update_power

report_power  > ${report_path}/power.rpt
report_power -nosplit -hierarchy -levels 2 > ${report_path}/power_nosplit_hierarchy_2_levels.rpt

exit
