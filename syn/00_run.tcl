set_host_options -max_cores 8

set user_name $::env(USER)
set design_name history_fsm_chip

set rtl_dir /home/$user_name/digital/$design_name/rtl
set syn_dir /sim/$user_name/digital/$design_name/syn

file mkdir $syn_dir

source /home/$user_name/tsmc28-pipecleaner/syn/saed32_setup.tcl
source /home/$user_name/tsmc28-pipecleaner/syn/synth.tcl
