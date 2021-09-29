#! /bin/bash

read -p "Enter up-eigenvalue file name:" ufname
read -p "Enter up-eigenvalue file name:" dfname
read -p "Enter you impulse heigth:"
read -p "Enter nband:" nband
	while read line
		do
			echo -e "$line" > fil 
			read -a array <fil
			for ((i=0;i<8;i++))
				do
				echo ${array[$i]} >>ucolm
				done
		done < $ufname
		
		
	while read line
		do
			echo -e "$line" > fild 
			read -a array <fild
			for ((i=0;i<8;i++))
				do
				echo ${array[$i]} >>dcolm
				done
		done < $dfname
#this is not standard!!!!!!!
     for ((j=0;j<$nband;j++))
     	do 
     	echo $impulse >> impdata
     	done
     	
     paste ucolm dcolm impdata > eigen.data
     
     rm impdata ucolm dcolm fil fild
     
#plot Dos with eigenvalues
