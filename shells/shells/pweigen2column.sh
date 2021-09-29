#! /bin/bash

read -p "Enter eigenvalue file name:" fname
read -p "Enter you impulse heigth:"
read -p "Enter nbamd:" nband
	while read line
		do
			echo -e "$line" > fil 
			read -a array <fil
			for ((i=0;i<8;i++))
				do
				echo ${array[$i]} >>colm
				done
		done < $fname
#this is not standard!!!!!!!
     for ((j=0;j<$nband;j++))
     	do 
     	echo $impulse >> impdata
     	done
     	
     paste colm impdata > eigen.data
     
     rm impdata
     
#plot Dos with eigenvalues

cat > gnu.tmp << EOF
set term postscript eps enhanced color font 'Helvetica,10'
set size 0.6,0.6
set origin 0.15,0.15
set title '	'
set output 'dos.eps'
set xlabel 'Energy(eV)' 
set ylabel 'Density of states'
set xrange [-30:0]
set yrange [0:100]
set xtics -30,5
set mxtics 5 
plot 'eigen.data' using 1:2 with lines      
		
	


