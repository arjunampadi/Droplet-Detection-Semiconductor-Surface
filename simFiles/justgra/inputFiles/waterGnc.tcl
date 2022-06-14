package require psfgen
package require topotools

mol load psf gnc.psf pdb gnc.pdb
set cnt [atomselect top "segname GR1"]
$cnt set type 3CAL1

topo writelammpsdata Gnc.lmpsys

topo readlammpsdata Gnc.lmpsys
set sel [atomselect top "type 3CAL1"]
set mm [measure minmax $sel]
set xlo [format %.4f [expr [lindex $mm 0 0]-0.71] ]
set xhi [format %.4f [expr [lindex $mm 1 0]+0.71] ]
set ylo [format %.4f [expr [lindex $mm 0 1]-0.61] ]
set yhi [format %.4f [expr [lindex $mm 1 1]+0.61] ]
set zlo [format %.4f [expr [lindex $mm 0 2]-50.0] ]
set zhi [format %.4f [expr [lindex $mm 1 2]+50.0] ]

exec sed -i "12s/.*/  $xlo $xhi  xlo xhi/" Gnc.lmpsys
exec sed -i "13s/.*/  $ylo $yhi  ylo yhi/" Gnc.lmpsys
exec sed -i "14s/.*/  $zlo $zhi  zlo zhi/" Gnc.lmpsys

mol delete all
exit
