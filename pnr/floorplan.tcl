##### chip width not including seal ring #####
set chip_width      1200
set chip_height     1200

##### pad ring dimensions #####
# with pads
set io_width        300
set io_height       300

##### io2core margin #####
set left_io2core    40
set right_io2core   40
set top_io2core     40
set bottom_io2core  40

##### set the area of the design #####
set core_width [expr $chip_width - (2*$io_width + $left_io2core + $right_io2core)]
set core_height [expr $chip_height - (2*$io_height + $top_io2core + $bottom_io2core)]

##### create floorplan #####
#create_floorplan \
#    -control_type width_and_height \
#    -core_width $core_width \
#    -core_height $core_height \
#    -start_first_row \
#    -left_io2core $left_io2core \
#    -right_io2core $right_io2core \
#    -top_io2core $top_io2core \
#    -bottom_io2core $bottom_io2core
create_floorplan \
    -control_type aspect_ratio \
    -core_aspect_ratio 1 \
    -core_utilization 0.5 \
    -row_core_ratio 1 \
    -start_first_row \
    -left_io2core $left_io2core \
    -right_io2core $right_io2core \
    -top_io2core $top_io2core \
    -bottom_io2core $bottom_io2core

# This creates a collection of all of the macros in your design. You may wish you use this 
# if you want to set constraints on your macros or iterate over them to manually place them.
# Type "man collections" into icc_shell for more info on working with Synopsys collections
set all_macros [get_cells -hierarchical -all * -filter (is_hard_macro==true || is_soft_macro==true)]

# Example of auto macro constraints
set_fp_placement_strategy -macros_on_edge on -auto_grouping high -minimize_auto_grouping_channels true -pin_routing_aware true
set_fp_placement_strategy -sliver_size 20

# Example of explicit macro placement
# Note that the x and y values you provide should be on the standard cell grid for this
# technology. (i.e. x should be a multiple of 0.152 and y should be a multiple of 1.672)
# 
# set macro [get_cells *path to cell*]
# set_cell_location -fixed -coordinates {x y}
