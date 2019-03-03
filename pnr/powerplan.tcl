##### Automatic power planning approach using power constraints #####
set pitch 2.432

set_fp_rail_constraints -add_layer  -layer M9 -direction vertical -max_pitch 30.4 -min_pitch $pitch -max_width 5 -min_width 3 -spacing minimum
set_fp_rail_constraints -add_layer  -layer M8 -direction horizontal -max_pitch 30.4 -min_pitch $pitch  -max_width 5 -min_width 3 -spacing minimum


synthesize_fp_rail \
     -nets {VDD VSS} \
     -voltage_supply 1.2 \
     -synthesize_power_plan \
     -power_budget 100 \
     -use_strap_ends_as_pads \
     -create_virtual_rails "M1"

commit_fp_rail

derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT

