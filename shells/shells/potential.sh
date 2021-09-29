#! /bin/bash

#This shell written by Yavar Taghipour Azar, 1 sept 2013
# This shell makes directories and do the post process on slab in Z direction

echo "Hi $USER  it is `date`  have  good time"



read -p "please enter diretory name :         "  dname
read -p "please enter scf input file name:     "  fname
#read -p "please enter temp address       "  outdir
read -p "please enter parralell command prefix:       "  PARA_PREFIX
read -p "please enter bin directory address:      "   BIN_DIR
#read -p "please enter min and max for energy window (eV) ; Emin and Emax =   "  emin emax

# !!!under construction!!! add some lines to check the temporary files

grep "prefix" $fname > temp
sed -i "s/prefix=//g" temp
sed -i "s/ //g" temp
sed -i "s/'//g" temp
sed -i "s/,//g" temp

prefix=`cat temp`

grep "outdir" $fname > temp1
sed -i "s/outdir=//g" temp1
sed -i "s/ //g" temp
sed -i "s/'//g" temp1
sed -i "s/,//g" temp1

outdir=`cat temp1`

rm temp*




mkdir $dname-Post

cd ../$dname-Post

cat > $dname.pot.in << EOF
&inputPP
  prefix ="$prefix"
  outdir ="$outdir"
 filplot = "$dname-potential.data"
 plot_num = 11
/
EOF
$PARA_PREFIX $BIN_DIR/pp.x < $dname.pot.in > $dname.pot.out 

cat > $dname.avg.pot.in << EOF
1
$dname-potential.data
1.D0
3000.D0
3
1.00000
EOF
$BIN_DIR/average.x < $dname.avg.pot.in> $dname.avg.pot.out

echo " "
echo "Hartree and coloumb potential and their average in z direction calculated Succesfully"

cat > $dname.pot_plus_xc.in << EOF
&inputPP
 prefix ="$prefix"
 outdir ="$outdir"
 filplot = "$dname-pot_xc.data"
 plot_num = 1
/
EOF
$PARA_PREFIX $BIN_DIR/pp.x < $dname.pot_plus_xc.in  > $dname.pot_plus_xc.out 


cat > $dname.avg.pot_xc.in << EOF
1
$dname-pot_xc.data
1.D0
3000.D0
3
1.00000
EOF
$BIN_DIR/average.x < $dname.avg.pot_xc.in> $dname.avg.pot_xc.out

echo "Hartree, coloumb AND  XC potential and their average in z direction calculated Succesfully"


echo "      "

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!POST PROCESSING FINISHED SUCCESFULLY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"




