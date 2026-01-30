# XSIM simulation script
# Usage:
#   vivado -mode batch -source hw/scripts/sim.tcl

set repo_root [file normalize [pwd]]

create_project -in_memory -part xc7z015clg485-2
set_property target_language Verilog [current_project]

add_files -norecurse [glob -nocomplain "$repo_root/hw/rtl/*.sv"]
add_files -fileset sim_1 -norecurse [glob -nocomplain "$repo_root/hw/tb/*.sv"]

set_property top top    [get_filesets sources_1]
set_property top tb_top [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

launch_simulation
run 50 us
quit
