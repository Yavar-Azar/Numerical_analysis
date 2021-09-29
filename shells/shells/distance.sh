#! /bin/bash
#script written by Y.T.azar to analysis the car-parrinello dynamic

read -p "Enter pos filename: 	 "  fname

read -p "Enter label of atoms: 		 "  atom1 atom2

read -p "Enter all number of atoms:	"  nat

wc -l $fname > temp
cp $fname original-file.pos
sed -i 's/'$fname'/ /g' temp
lines=`cat temp`
rm temp
rm distances
rm positions
sed -i 's/E/ /g' $fname
sed -i 's/+//g' $fname

nat1=$(($nat+1))
steps=$(($lines/$nat1))

echo "steps is=$steps"

    for ((j=0; j<$steps; j++))
     	
     	do 
     	s=$(($j*$nat1))
       	a=$(($atom1+$s))
     	b=$(($atom2+$s))
     	
     	x=`sed -n ''$a'p' $fname`
     	x11=`echo $x | awk '{print $1}'`
     	p=`echo $x | awk '{print $2}'`
        x1=$(echo "scale=6 ; ($x11)*(10^($p))" | bc -l)
     	
     	y11=`echo $x | awk '{print $3}'`
     	p=`echo $x | awk '{print $4}'`
     	y1=$(echo "scale=6 ;($y11)*(10^($p))" | bc -l)
     	
   	z11=`echo $x | awk '{print $5}'`
     	p=`echo $x | awk '{print $6}'`
   	z1=$(echo "scale=6 ; ($z11)*(10^($p))" | bc -l)
    	
    	xx=`sed -n ''$b'p' $fname`
     	x21=`echo $xx | awk '{print $1}'`
     	p=`echo $xx | awk '{print $2}'`
        x2=$(echo "scale=6 ; ($x21)*(10^($p))" | bc -l)
     	
    	y21=`echo $xx | awk '{print $3}'`
    	p=`echo $xx | awk '{print $4}'`
     	y2=$(echo "scale=6 ; ($y21)*(10^($p))" | bc -l)
     	
    	z21=`echo $xx | awk '{print $5}'`
     	p=`echo $xx | awk '{print $6}'`
        z2=$(echo "scale=6 ; ($z21)*(10^($p))" | bc -l)
    	
    	
    	dist=$(echo "scale=6 ; sqrt((($x1-$x2)^2)+(($y1-$y2)^2)+(($z1-$z2)^2))" | bc -l)
    	
    	echo "$j  $x1 $y1 $z1 $x2 $y2 $z2 " >> positions
    	echo "$j  $dist" >> distances
     	done
     	
     	
   cp original-file.pos oleic.surf.pos




