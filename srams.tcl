suppress_message {MWDC-133 MWUI-511 MW-300}

proc create_sram_mw_lib {sram_dir tech_file} {
    set lib [file tail $sram_dir]
    create_mw_lib SRAMlib -technology $tech_file -open

    # read LEF and antenna LEF in that order
    # this will create CEL and FRAM views in the mw lib
    # CEL view has layout information (in this case, partial info because LEF doesn't have all info)
    # FRAM view has pins, blockages, etc.
    read_lef -lib_name SRAMlib -cell_lef_files [glob $sram_dir/*.lef]

    # read GDS. GDS is hierarchical so mark only top-level cell as macro
    # this will add complete layout info
    set cellname [get_attribute [get_mw_cels] name]
    echo "gdsMacroCell $cellname\ngdsOtherCell *" > cell_types.txt
    read_gds -lib_name SRAMlib -ignore_text_box -cell_version update_existing_cell -cell_type cell_types.txt [glob $sram_dir/*.gds]

    # Optional: flatten top-level sram and remove lower-level modules.
    # This was useful before when all hierarchical cells were marked as macro cells and ICC
    # would complain that logic libraries didn't have timing models for those cells.
    # Marking them as "other" cells seems to solve this problem.
    # Another reason to flatten is if you have to extract pins and other information
    # from the layout (create FRAM from CEL). But we have the LEF file for that.

    #flatten_cell -cell $cellname -library $lib -level 10000 ;# 10000 should hopefully be enough
    #remove_mw_cel [get_mw_cels -filter "name != $cellname"]

    close_mw_lib -save
    dbSetMacroCellOrient SRAMlib $cellname {R0 R0_MX R0_MY R180}
}

set tech_file $::env(SAED32_PATH)/tech/milkyway/saed32nm_1p9m_mw.tf

#foreach sram_dir [glob /homes/mtikekar/hevc-2/toplevel/bsv/sram_gen/ts*] {
create_sram_mw_lib . $tech_file
#}
