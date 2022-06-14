package require psfgen
package require topotools

mol load pdb waterBoxPrime.pdb
set sel [atomselect top "type OH 1HH 2HH"]
$sel set segname TIPS3P
$sel set resname TIP3

set sel [atomselect top "type OH"]
$sel set type OT
$sel set name OH2
set sel [atomselect top "type 1HH"]
$sel set type HT
$sel set name H1
set sel [atomselect top "type 2HH"]
$sel set type HT
$sel set name H2

set sel [atomselect top "type HT OT"]
$sel writepdb waterBox.pdb

resetpsf
mol delete all

topology water.top
segment TIP {pdb waterBox.pdb}
coordpdb waterBox.pdb TIP
writepsf waters.psf
writepdb waters.pdb

resetpsf

readpsf waters.psf 
coordpdb waters.pdb
readpsf gnc.psf
coordpdb gnc.pdb
writepsf waterGnc.psf
writepdb waterGnc.pdb

mol load psf waterGnc.psf pdb waterGnc.pdb
set hyd [atomselect top "type HT"]
$hyd set type 1HT
$hyd set charge 0.4238
set oxy [atomselect top "type OT"]
$oxy set type 2OT
$oxy set charge -0.8476
set cnt [atomselect top "segname GR1"]
$cnt set type 3CAL1

topo writelammpsdata waterGnc.lmpsys

topo readlammpsdata waterGnc.lmpsys
set sel [atomselect top "type 3CAL1"]
set mm [measure minmax $sel]
set xlo [format %.4f [expr [lindex $mm 0 0]-0.71] ]
set xhi [format %.4f [expr [lindex $mm 1 0]+0.71] ]
set ylo [format %.4f [expr [lindex $mm 0 1]-0.61] ]
set yhi [format %.4f [expr [lindex $mm 1 1]+0.61] ]
set zlo [format %.4f [expr [lindex $mm 0 2]-50.0] ]
set zhi [format %.4f [expr [lindex $mm 1 2]+50.0] ]

exec sed -i "12s/.*/  $xlo $xhi  xlo xhi/" waterGnc.lmpsys
exec sed -i "13s/.*/  $ylo $yhi  ylo yhi/" waterGnc.lmpsys
exec sed -i "14s/.*/  $zlo $zhi  zlo zhi/" waterGnc.lmpsys

mol delete all
exec rm -f waterBox.pdb 
exec rm -f waterBoxPrime.pdb
exec rm -f gnc.pdb gnc.psf
exec rm -f waters.pdb waters.psf

exit
