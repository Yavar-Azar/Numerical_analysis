for ((i=1 ; i<=71; i++))
do  

sed -i.back 's/$/  rdchem5-c0-2scf.pdos_atm#'$i'\\\(*/' rd5.test

done
