#bin/bash!
 'please enter number of orbitals'

read -p 'please enter number of orbitals:' norb
echo norb=$norb

echo 'please enter prefix'
read prefix
echo prefix=$prefix

echo 'please enter exact outdir address'
read address
echo address=$address

echo 'please enter name of output:'
read oname
out_put_name=$oname


echo 'please enter name of frontier orbitals you want to visualize'
read nh
nh=$nh

for (( i=1; i<=nh ; i++))
do
j=$(($i-1))
cat > $oname.homo-$j.inp << EOF
&inputPP
 prefix='$prefix',
 outdir='$address'
 filplot = 'homo.$j.$oname.charge'
 plot_num = 7
 kpoint=1
 kband=$(($norb-$j))
/
&plot
 filepp(1)='homo.$j.$oname.charge',
 iflag=3
 output_format=6
 fileout='homo.$j.$oname.cube'
/
EOF

mpirun -np 8 /opt/QE432-THREADED-NEW/bin/pp.x <$oname.homo-$j.inp >$oname.homo-$j.out

cat > $oname.lumo+$j.inp << EOF
&inputPP
 prefix='$prefix',
 outdir='$address'
 filplot = 'lumo.$j.$oname.charge'
 plot_num = 7
 kpoint=1
 kband=$(($norb+$i))
/
&plot
 filepp(1)='lumo.$j.$oname.charge',
 iflag=3
 output_format=6
 fileout='lumo.$j.$oname.cube'
/
EOF

mpirun -np 8 /opt/QE432-THREADED-NEW/bin/pp.x <$oname.lumo+$j.inp > $oname.lumo+$j.out

done
