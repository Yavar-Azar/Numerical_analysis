#! /bin/bash
#This script written by Y.T.AZAR 17-Apr-2013 



read -p "Enter name of the group which you want to project Dos on it:"  gname
read -p "Enter nat in your group:" gnat
read -p "Enter prefix:" prefix
mkdir 00-$prefix-results
echo "Enter atom labels" 
read -a atlab

echo "/opt/QE432/bin/sumpdos.x" > $gname.sh

for ((i=0 ; i<$gnat; i++))
do  

sed -i.back 's/$/  '$prefix'.pdos_atm#'${atlab[$i]}'\\\(*/' $gname.sh

done
chmod +x $gname.sh
./$gname.sh > 00-$prefix-results/$gname.sposdata
