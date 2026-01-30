# build.tcl (Vivado 2019.1) - run inside Vivado Tcl Shell:
#   cd F:/zynq/fpga/template
#   source hw/scripts/build.tcl

set part "xc7z015clg485-2"
set repo_root [file normalize [pwd]]

file mkdir "$repo_root/build"
file mkdir "$repo_root/hw/reports"

if {[llength [get_projects -quiet]] > 0} {
  close_project
}

create_project template "$repo_root/build" -part $part -force
set_property target_language Verilog [current_project]

set rtl_sv [glob -nocomplain "$repo_root/hw/rtl/*.sv"]
set rtl_v  [glob -nocomplain "$repo_root/hw/rtl/*.v"]
set rtl_files [concat $rtl_sv $rtl_v]
if {[llength $rtl_files] == 0} {
  puts "ERROR: No RTL files found under $repo_root/hw/rtl"
  exit 1
}
add_files -norecurse $rtl_files
set_property top top [get_filesets sources_1]

set xdc_files [glob -nocomplain "$repo_root/hw/constraints/*.xdc"]
if {[llength $xdc_files] > 0} {
  add_files -fileset constrs_1 -norecurse $xdc_files
}

update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 4
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

set st [get_property STATUS [get_runs impl_1]]
if {![string match "*Complete*" $st]} { puts "ERROR: impl_1 not complete: $st"; exit 1 }
open_run impl_1


report_timing_summary -file "$repo_root/hw/reports/timing_summary.rpt"
report_utilization    -file "$repo_root/hw/reports/utilization.rpt"

set bitfile [get_property BITSTREAM.FILE [get_runs impl_1]]
if {$bitfile ne ""} {
  file copy -force $bitfile "$repo_root/hw/reports/top.bit"
  puts "Bitstream copied to hw/reports/top.bit"
} else {
  puts "WARNING: bitstream not found."
}

puts "DONE"