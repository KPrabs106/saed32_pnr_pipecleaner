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

