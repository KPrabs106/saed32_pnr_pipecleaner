######## CORNERS
create_cell {corner_lb} CORNER
create_cell {corner_lt} CORNER
create_cell {corner_rt} CORNER
create_cell {corner_rb} CORNER

######## WEST
#exists pad_clk
#exists pad_reset
#exists pad_a
set num_fill 12
for {set i 0} {$i<$num_fill} {incr i} {
    create_cell w_fill_$i FILLER
}

######## NORTH
create_cell {pad_vssio_n} IOVSS_NS
create_cell {pad_vdd} VDD_NS 
create_cell {pad_vddio_n} IOVDD_NS
for {set i 0} {$i<$num_fill} {incr i} {
    create_cell n_fill_$i FILLER
}

######## SOUTH
create_cell {pad_vssio_s} IOVSS_NS
create_cell {pad_vss} VSS_NS
create_cell {pad_vddio_s} IOVDD_NS
for {set i 0} {$i<$num_fill} {incr i} {
    create_cell s_fill_$i FILLER
}

######## EAST
#exists pad_x
#exists pad_y

for {set i 0} {$i<$num_fill+1} {incr i} {
    create_cell e_fill_$i FILLER
}
