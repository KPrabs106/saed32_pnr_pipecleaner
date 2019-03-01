# VDD is our net name for the logic supply.
derive_pg_connection -power_net VDD -power_pin VDD -create_ports top
# VSS is our net name for the global VSS. 
derive_pg_connection -ground_net VSS -ground_pin VSS -create_ports top
# VDDIO is our net name for the pad ring 1.8 I/O supply. Pad cells connect to this net through the ring internally.
#derive_pg_connection -power_net VDDIO -power_pin VDDIO -create_ports top
## VSSIO is our net name for the pad ring 1.8 I/O supply. Pad cells connect to this net through the ring internally.
#derive_pg_connection -ground_net VSSIO -ground_pin VSSIO -create_ports top
# POC (power on control) is a net internal to the pad ring, not a port
# derive_pg_connection -power_net POC -power_pin POC -create_ports none
