DESIGN_NAME=chip

# For RTL simulation
#vcs -full64 -f ./verilog_file_list_RTL.txt \
#    -sverilog  \
#    -timescale=1ns/1ps \
#    +define+UNIT_DELAY \
#    +sdfverbose \
#    -debug_access+pp \
#    -lca \
#    +define+DUMP_FILE=\"${DESIGN_NAME}_RTL.vpd\" \
#    | tee output.log


# For post place and route netlist simulation
vcs -full64 -f ./verilog_file_list_PR.txt \
    -sverilog  \
    -timescale=1ns/1ps \
    -sdf max:tb.inst_top:../pnr/top.sdf \
    +sdfverbose \
    -debug_access+pp \
    -lca \
    +neg_tchk \
    +lint=TFIPC-L \
    +define+DUMP_FILE=\"${DESIGN_NAME}_PR.vpd\" \
    +define+PR=\"PR\" \
    | tee output.log

# run compiled verilog code
#./simv
