# Place and route flow

In order to run the entire place and route flow beginning to end, type `./run.sh`. This will open ICC shell and source 00_run.tcl. 

To open ICC, type `icc_shell -gui`. Leave off the gui option if you do not wish to use the gui.

Once you have ICC open, you can source the scripts one-by-one by typing `source ./*script name*.tcl`. Just be sure that the design_name 
variable is set to the name of your top level design. Do this by typing `set design_name *your design name*` into icc_shell.
