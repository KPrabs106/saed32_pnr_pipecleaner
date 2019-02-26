create_rectangular_rings -nets {VDD VSS} -left_offset 5 -left_segment_layer M9 -left_segment_width 2 -right_offset 5 -right_segment_layer M9 -right_segment_width 2 -bottom_offset 5 -bottom_segment_layer M8 -bottom_segment_width 2 -top_offset 5 -top_segment_layer M8 -top_segment_width 2


# LCM of M8 and M9 pitch
set pitch 2.432

# how many wire pitches should power straps be spaced apart?
set num_pitches 29

set strap_start_l [expr $io_width + $left_io2core + ($pitch * $num_pitches)]
set strap_start_b [expr $io_height + $bottom_io2core + ($pitch * $num_pitches)]

set increment [expr $num_pitches * $pitch]

set num_straps_v [expr round($core_width/$increment) - 1]
set num_straps_h [expr round($core_height/$increment) - 1]

create_power_straps -direction vertical -start_at $strap_start_l -num_placement_strap $num_straps_v -increment_x_or_y $increment -nets {VDD VSS} -layer M9 -width 2

create_power_straps -direction horizontal -start_at $strap_start_b -num_placement_strap $num_straps_h -increment_x_or_y $increment -nets {VDD VSS} -layer M8 -width 2
