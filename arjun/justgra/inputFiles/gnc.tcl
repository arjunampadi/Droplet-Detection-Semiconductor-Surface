package require nanotube
package require psfgen
package require solvate
package require topotools

graphene -lx 15 -ly 15 -type zigzag -b 0
set sel [atomselect top all]
set mm [measure minmax $sel]
set xmid [expr -0.5* ([format %.4f [expr [lindex $mm 0 0]] ]+[format %.4f [expr [lindex $mm 1 0]]])]
set ymid [expr -0.5* ([format %.4f [expr [lindex $mm 0 1]] ]+[format %.4f [expr [lindex $mm 1 1]]])]
$sel set segname GR1
$sel moveby [list $xmid $ymid 0]
$sel writepdb 1graphene.pdb
$sel writepsf 1graphene.psf

readpsf  1graphene.psf
coordpdb 1graphene.pdb
writepsf gnc.psf
writepdb gnc.pdb

exec rm -f 1graphene.psf 1graphene.pdb
mol delete all
exit

