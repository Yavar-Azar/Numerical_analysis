#!/bin/bash

echo "This shell converts xyz format to siesta input format"


read -p "Please enter xyz file name	" xyzfile
sed -i 1,2d $xyzfile > temp

read -p "Please enetr Number of atom types	"  ntyp
for ((j=0;j<$ntyp;j++))
     	do 
        read -p 'please enter $((j+1)) th atom symbol	'   name
     	sed -i "s/$name/$((j+1))/g"  temp
     	done 
while read -r a b c d
do
echo $b $c $d $a >> siesta
done < $temp
