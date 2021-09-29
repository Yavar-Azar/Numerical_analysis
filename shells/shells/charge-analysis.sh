#! /bin/bash

read -p "please enter namber of atoms:	" nat
read -p "please enter pdos output name:		" pdos

#read -p "please enter interval first and last atom in group"  fatom latom

grep -A $(($nat+1))  'Lowdin Charges:' $pdos > temp1

a=$(($nat+1))
colrm 41 < temp1 > temp2
colrm 1 33 <temp2 > totcharge
sed -i "1,2d" totcharge 
sed -i "s/ //g" totcharge

rm temp*
sum=0
sum1=0
sum2=0
for (( j=1; j<$a; j++ ))
     	
     	do 
	x=`sed -n ''$j'p' totcharge`
	sum1=$(echo "scale=6 ; ($x)+($sum1)" | bc -l)
	
	done
	
	
	echo $sum1
