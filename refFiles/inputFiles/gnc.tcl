package require nanotube
package require psfgen
package require solvate
package require topotools

graphene -lx 12 -ly 12 -type zigzag -b 0
set sel [atomselect top all]
$sel set segname GR1
$sel moveby {-40 -40 0}
$sel writepdb 1graphene.pdb
$sel writepsf 1graphene.psf

readpsf  1graphene.psf
coordpdb 1graphene.pdb
writepsf gnc.psf
writepdb gnc.pdb

exec rm -f 1graphene.psf 1graphene.pdb
mol delete all
exit

