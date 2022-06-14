for fname in bmimBf4GraI 
do
	sed -i "s/FolderName/${fname}/g" ./in.script_aqua
	
	for Tequil in 200 225 275 350 450 600
	do
		sed -i "s/Tequil 888/Tequil ${Tequil}/g" ./in.script_aqua

		for Pequil in 1
		do
			sed -i "s/Pequil 5.5/Pequil ${Pequil}/g" ./in.script_aqua

			for dT in 100 200 
			do
				sed -i "s/dT 777/dT ${dT}/g" ./in.script_aqua

				for index in 1 
				do
					name=T${Tequil}P${Pequil}_dT${dT}_${index}
					sed -i "s/abhi_/${name}/g" ./in.script_aqua
					sed -i "s/index 99/index ${index}/g" ./in.script_aqua
	
					#qsub -o ~/scratch/$name/logfile.log -e ~/scratch/$name/errorfile.err in.script_aqua
					echo qsub -o ~/scratch/$name/logfile.log -e ~/scratch/$name/errorfile.err in.script_aqua
					awk '/tempdir=/{line=$0}END{print line}' ./in.script_aqua
					awk '/lmp_mpi/{line=$0}END{print line "\n"}' ./in.script_aqua
	
					sed -i "s/index ${index}/index 99/g" ./in.script_aqua
					sed -i "s/${name}/abhi_/g" ./in.script_aqua
				done
				
				sed -i "s/dT ${dT}/dT 777/g" ./in.script_aqua
			done

			sed -i "s/Pequil ${Pequil}/Pequil 5.5/g" ./in.script_aqua
		done

		sed -i "s/Tequil ${Tequil}/Tequil 888/g" ./in.script_aqua

	done
	
	sed -i "s/${fname}/FolderName/g" ./in.script_aqua
	
done
 
