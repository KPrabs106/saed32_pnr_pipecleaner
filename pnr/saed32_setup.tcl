puts "Info: Using Synopsys EDK Gate Libraries (6M, 32nm)"

set SAED32_EDK_PATH      "$::env(SAED32_PATH)"
set SAED32_EDK_TECH_PATH "${SAED32_EDK_PATH}/tech"
set SAED32_EDK_LIB_PATH  "${SAED32_EDK_PATH}/lib"
# This script uses Tcl arrays to describe technology constants.
# Standard library cells are keyed on pvt corner.
# Note that not all process corners are compatible with all voltages (see table below).
#
# Variable      | Description                       | Values
# --
# $transistor   | Transistor n+p process corner     | ss    | tt    | ff
# $voltage      | Primary voltage                   | 0p70v | 0p78v | 0p85v
#               |                                   | 0p75v | 0p85v | 0p95v
#               |                                   | 0p95v | 1p05v | 1p16v
#
# Additionally, you can also key on threshold voltage (low, regular, or high)
# and tempurature.
#
# Variable      | Description                       | Values
# --
# $threshold    | Transistor threshold              | lvt, rvt, hvt
# $temperature  | Operating temperature             | 125c, 25c, n40c
set slow_corner_pvt     ss0p95v125c
set typical_corner_pvt  tt1p05v25c
set fast_corner_pvt     ff1p16vn40c

# TLU+ and Nxtgrd files are keyed on extraction corner
# Valid extraction corners are shown below.
#
# Variable | Description          | Values
# --
# $corner  | RC extraction corner | slow | typical | fast
set slow_corner_extraction slow
set typ_corner_extraction  typical
set fast_corner_extraction fast

#######
# Library search paths and Milkyway reference libraries (Include IC Compiler ILMs here)
#######
set ADDITIONAL_SEARCH_PATH  " \
${SAED32_EDK_LIB_PATH}/io_std/db_nldm/ \
${SAED32_EDK_LIB_PATH}/pll/db_nldm/ \
${SAED32_EDK_LIB_PATH}/sram/db_nldm/ \
${SAED32_EDK_LIB_PATH}/sram_lp/db_nldm/ \
${SAED32_EDK_LIB_PATH}/stdcell_hvt/db_nldm \
${SAED32_EDK_LIB_PATH}/stdcell_lvt/db_nldm \
${SAED32_EDK_LIB_PATH}/stdcell_rvt/db_nldm \
"

set MW_REFERENCE_LIB_DIRS  [list \
${SAED32_EDK_LIB_PATH}/io_std/milkyway/saed32_io_wb \
${SAED32_EDK_LIB_PATH}/sram/milkyway/SRAM32NM \
${SAED32_EDK_LIB_PATH}/sram_lp/milkyway/saed32sram_lp \
${SAED32_EDK_LIB_PATH}/stdcell_hvt/milkyway/saed32nm_hvt_1p9m \
${SAED32_EDK_LIB_PATH}/stdcell_lvt/milkyway/saed32nm_lvt_1p9m \
${SAED32_EDK_LIB_PATH}/stdcell_rvt/milkyway/saed32nm_rvt_1p9m]

# Reference Control File to define the MW reference libraries
set MW_REFERENCE_CONTROL_FILE ""

########
# NLDM .db filenames
########
foreach vt {hvt lvt rvt} {
    foreach pvt {ss0p95v125c tt1p05v25c ff1p16vn40c} {
        set stdcell_library(db,$vt,$pvt) [list saed32${vt}_${pvt}.db]
    }
}

set sram_library(db,ff1p16v125c) [list saed32sram_ff1p16v125c.db]
set sram_library(db,ff1p16v25c)  [list saed32sram_ff1p16v25c.db]
set sram_library(db,ff1p16vn40c) [list saed32sram_ff1p16vn40c.db]

set sram_library(db,tt1p05v125c) [list saed32sram_tt1p05v125c.db]
set sram_library(db,tt1p05v25c)  [list saed32sram_tt1p05v25c.db]
set sram_library(db,tt1p05vn40c) [list saed32sram_tt1p05vn40c.db]

set sram_library(db,ss0p95v125c) [list saed32sram_ss0p95v125c.db]
set sram_library(db,ss0p95v25c)  [list saed32sram_ss0p95v25c.db]
set sram_library(db,ss0p95vn40c) [list saed32sram_ss0p95vn40c.db]

set io_wb_library(db,ff1p16v125c) [list saed32io_wb_ff1p16v125c_2p75v.db]
set io_wb_library(db,ff1p16v25c)  [list saed32io_wb_ff1p16v25c_2p75v.db]
set io_wb_library(db,ff1p16vn40c) [list saed32io_wb_ff1p16vn40c_2p75v.db]

set io_wb_library(db,tt1p05v125c) [list saed32io_wb_tt1p05v125c_2p5v.db]
set io_wb_library(db,tt1p05v25c)  [list saed32io_wb_tt1p05v25c_2p5v.db]
set io_wb_library(db,tt1p05vn40c) [list saed32io_wb_tt1p05vn40c_2p5v.db]

set io_wb_library(db,ss0p95v125c) [list saed32io_wb_ss0p95v125c_2p25v.db]
set io_wb_library(db,ss0p95v25c)  [list saed32io_wb_ss0p95v25c_2p25v.db]
set io_wb_library(db,ss0p95vn40c) [list saed32io_wb_ss0p95vn40c_2p25v.db]


#########
# Target technology logical libraries
#########
set TARGET_LIBRARY_FILES " \
$stdcell_library(db,hvt,$slow_corner_pvt) \
$stdcell_library(db,rvt,$slow_corner_pvt) \
$stdcell_library(db,lvt,$slow_corner_pvt) \
"

# Extra link logical libraries (e.g. libraries that can be referenced but are
# not targeted) that are not included in TARGET_LIBRARY_FILES
#
# PLACE ADDITIONAL SRAM .DB FILES HERE
set ADDITIONAL_LINK_LIB_FILES "$sram_library(db,$slow_corner_pvt) \
                               $io_wb_library(db,$slow_corner_pvt)"
                                

# Associate libraries with min libraries
# This should be a list of max-min library paris "max1 min1 max2 min2 ..."
set MIN_LIBRARY_FILES ""
foreach vt {hvt lvt rvt} {
    foreach max_lib [concat $stdcell_library(db,$vt,$slow_corner_pvt)] \
        min_lib [concat $stdcell_library(db,$vt,$fast_corner_pvt)] {
        lappend MIN_LIBRARY_FILES $max_lib $min_lib
    }
}
foreach max_lib [concat $sram_library(db,$slow_corner_pvt)] \
        min_lib [concat $sram_library(db,$fast_corner_pvt)] {
    lappend MIN_LIBRARY_FILES $max_lib $min_lib
}

foreach max_lib [concat $io_wb_library(db,$slow_corner_pvt)] \
        min_lib [concat $io_wb_library(db,$fast_corner_pvt)] {
    lappend MIN_LIBRARY_FILES $max_lib $min_lib
}

########
# Tech files and metal stack extraction models
########
set tluplus_file(typical) "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_1p9m_nominal.tluplus"
set tluplus_file(fast)    "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set tluplus_file(slow)    "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set nxtgrd_file(typical)  "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_1p9m_nominal.nxtgrd"
set nxtgrd_file(fast)     "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_1p9m_Cmin.nxtgrd"
set nxtgrd_file(slow)     "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_1p9m_Cmax.nxtgrd"

# Tech files
set TECH_FILE        "${SAED32_EDK_TECH_PATH}/milkyway/saed32nm_1p9m_mw.tf"
set MAP_FILE         "${SAED32_EDK_TECH_PATH}/star_rcxt/saed32nm_tf_itf_tluplus.map"
set TLUPLUS_MAX_FILE "$tluplus_file($slow_corner_extraction)"
set TLUPLUS_MIN_FILE "$tluplus_file($fast_corner_extraction)"

# Name of power/ground ports/nets
set MW_POWER_NET   "VDD"
set MW_POWER_PORT  "VDD"
set MW_GROUND_NET  "VSS"
set MW_GROUND_PORT "VSS"

# Max/Min layers for routing
set MIN_ROUTING_LAYER "M2"
set MAX_ROUTING_LAYER "M8"

###########
# Don't Use File
###########
# Tcl file to prevent Synopsys from considering irrelevent or unneeded library
# components.
# set LIBRARY_DONT_USE_FILE                   "../scripts/common/dont_use.tcl"
set LIBRARY_DONT_USE_PRE_COMPILE_LIST       ""
set LIBRARY_DONT_USE_PRE_INCR_COMPILE_LIST  ""

##########################################################################################
# Multi-Voltage Common Variables
#
# Define the following MV common variables for the RM scripts for multi-voltage flows.
# Use as few or as many of the following definitions as needed by your design.
##########################################################################################

set PD1              ""           ;# Name of power domain/voltage area  1
set PD1_CELLS        ""           ;# Instances to include in power domain/voltage area 1
set VA1_COORDINATES  {}           ;# Coordinates for voltage area 1
set MW_POWER_NET1    "VDD1"       ;# Power net for voltage area 1
set MW_POWER_PORT1   "VDD"        ;# Power port for voltage area 1

set PD2              ""           ;# Name of power domain/voltage area  2
set PD2_CELLS        ""           ;# Instances to include in power domain/voltage area 2
set VA2_COORDINATES  {}           ;# Coordinates for voltage area 2
set MW_POWER_NET2    "VDD2"       ;# Power net for voltage area 2
set MW_POWER_PORT2   "VDD"        ;# Power port for voltage area 2

set PD3              ""           ;# Name of power domain/voltage area  3
set PD3_CELLS        ""           ;# Instances to include in power domain/voltage area 3
set VA3_COORDINATES  {}           ;# Coordinates for voltage area 3
set MW_POWER_NET3    "VDD3"       ;# Power net for voltage area 3
set MW_POWER_PORT3   "VDD"        ;# Power port for voltage area 3

set PD4              ""           ;# Name of power domain/voltage area  4
set PD4_CELLS        ""           ;# Instances to include in power domain/voltage area 4
set VA4_COORDINATES  {}           ;# Coordinates for voltage area 4
set MW_POWER_NET4    "VDD4"       ;# Power net for voltage area 4
set MW_POWER_PORT4   "VDD"        ;# Power port for voltage area 4

set_app_var search_path [list \
$SAED32_EDK_PATH \
$ADDITIONAL_SEARCH_PATH]

set_app_var target_library ${TARGET_LIBRARY_FILES}
set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"
foreach {max_library min_library} $MIN_LIBRARY_FILES {
    set_min_library $max_library -min_version $min_library
}
