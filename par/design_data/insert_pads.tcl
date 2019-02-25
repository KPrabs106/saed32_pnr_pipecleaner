######## CORNERS
create_cell {corner_lb} CORNER
create_cell {corner_lt} CORNER
create_cell {corner_rt} CORNER
create_cell {corner_rb} CORNER

######## WEST
#exists pad_clk
#exists pad_reset
#exists pad_a

######## NORTH
create_cell {pad_vssio_n} IOVSS_NS
create_cell {pad_vdd} CVDDVSS_NS 
create_cell {pad_vddio_n} IOVDD_NS

######## SOUTH
create_cell {pad_vssio_s} IOVSS_NS
create_cell {pad_vss} CVDDVSS_NS
create_cell {pad_vddio_s} IOVDD_NS

######## EAST
#exists pad_x
#exists pad_y
