#! /bin/bash
#!/bin/bash
# This script written by Yavar T. Azar may25,2014

echo "##################################################################################"
echo "------------SIESTA-BIULDER-VERSION-00-------------------------------------------- "
echo "THIS SCRIPT CONVERTS XYZ FILE To SIESTA format (input=*.xyz-> output=*.suffix.fdf)"
echo "##################################################################################"

cat > table << EOF
H	1	 Hydrogen	
He	2        Helium		
Li	3        Lithium		
Be	4        Beryllium	
B	5        Boron		
C	6        Carbon		
N	7        Nitrogen	
O	8        Oxygen		
F	9        Fluorine	
Ne	10       Neon		
Na	11       Sodium		
Mg	12       Magnesium	
Al	13       Aluminium 	
Si	14       Silicon		
P	15       Phosphorus	
S	16       Sulfur   	
Cl	17       Chlorine	
Ar	18       Argon		
K	19       Potassium	
Ca	20       Calcium		
Sc	21       Scandium	
Ti	22       Titanium	
V	23       Vanadium	
Cr	24       Chromium	
Mn	25       Manganese	
Fe	26       Iron		
Co	27       Cobalt		
Ni	28       Nickel		
Cu	29       Copper		
Zn	30       Zinc		
Ga	31       Gallium		
Ge	32       Germanium	
As	33       Arsenic		
Se	34       Selenium	
Br	35       Bromine		
Kr	36       Krypton		
Rb	37       Rubidium	
Sr	38       Strontium	
Y	39       Yttrium		
Zr	40       Zirconium	
Nb	41       Niobium		
Mo	42       Molybdenum	
Tc	43       Technetium	
Ru	44       Ruthenium	
Rh	45       Rhodium		
Pd	46       Palladium	
Ag	47       Silver		
Cd	48       Cadmium		
In	49       Indium		
Sn	50       Tin		
Sb	51       Antimony	
Te	52       Tellurium	
I	53       Iodine		
Xe	54       Xenon		
Cs	55       Caesium 	
Ba	56       Barium		
La	57       Lanthanum	
Ce	58       Cerium		
Pr	59       Praseodymium	
Nd	60       Neodymium	
Pm	61       Promethium	
Sm	62       Samarium	
Eu	63       Europium	
Gd	64       Gadolinium	
Tb	65       Terbium		
Dy	66       Dysprosium	
Ho	67       Holmium		
Er	68       Erbium		
Tm	69       Thulium		
Yb	70       Ytterbium	
Lu	71       Lutetium	
Hf	72       Hafnium		
Ta	73       Tantalum	
W	74       Tungsten	
Re	75       Rhenium		
Os	76       Osmium		
Ir	77       Iridium		
Pt	78       Platinum	
Au	79       Gold		
Hg	80       Mercury		
Tl	81       Thallium	
Pb	82       Lead		
Bi	83       Bismuth		
Po	84       Polonium	
At	85       Astatine	
Rn	86       Radon		
Fr	87       Francium	
Ra	88       Radium		
Ac	89       Actinium	
Th	90       Thorium	        
Pa	91       Protactinium	
U	92       Uranium		
Np	93       Neptunium	
Pu	94       Plutonium	
Am	95       Americium	
Cm	96       Curium		
Bk	97       Berkelium	
Cf	98       Californium	
Es	99       Einsteinium	
Fm	100      Fermium		
Md	101      Mendelevium	
No	102      Nobelium	
Lr	103      Lawrencium	
Rf	104      Rutherfordium	
Db	105      Dubnium		
Sg	106      Seaborgium	
Bh	107      Bohrium	        
Hs	108      Hassium	        
Mt	109      Meitnerium	
Ds	110      Darmstadtium	
Rg	111      Roentgenium	
Cp	112      Copernicium	
Uut	113      Ununtrium	
Uuq	114      Ununquadium	
Uup	115      Ununpentium	
Uuh	116      Ununhexium	
Uus	117      Ununseptium	
Uuo	118      Ununoctium	
EOF


read -p "Please enter name of xyz file  (with out xyz)          "   name1
echo    "Enter Lattice Vectors in angestrom ........   "
echo    ".............................................."
read -p "Components of first vecor like ( 2.5  0   0)       "    a1  a2  a3
read -p "components of second vecor like ( 0    2.5  0)     "   b1  b2  b3
read -p "components of third vecor like ( 2.5  0    3)      "   c1  c2  c3
read -p "Please enter MeshCutoff          "   cutoff

read -p "Please enter a suffix for file name (for example your cutoff value)          "   suff

sed 1,2d $name1.xyz >  xyznew
awk '{ print $1 }' $name1.xyz | sort | uniq  | sed 1d > temp1
read -r nat < temp1



read -p " your structure has $nat atoms, is this correct [y/n]?    " check
	if [ "$check" = "n" ]
   	then
        echo "            *           "
        echo "           * *          "
        echo "          *   *         "
        echo "         * * * *        "
        echo "Dear $USER check again you xyz file carefully"
      	rm table
        rm xyznew temp1
        exit 0
        fi

sed 1d temp1 > list1

i=1
while read -r var 
do 
sed -i "s/$var /$i/g" xyznew
echo $i $var >> species-list
i=$(($i+1))
done <list1


while read -r a b c d

do
echo $b  "  "  $c "  " $d  "  "  $a  >> $name1.siesta
done < xyznew

j=1
while read -r  var
	do
		while read -r a b c 
			do
				if [ "$a" = "$var" ]
				then
        	        	echo $j "   "  $b "   " $a >>  species
				echo $c >> speciesname
				fi 
			done < table
	j=$(($j+1))
done<list1

echo -e "your structure contains\n`cat speciesname` "

nas=$(($j-1))

rm temp1 xyznew  list1 



################################################



read -p "Please enter a label for your system:         " label


cat > $name1.$suff.fdf << EOF

SystemName    
SystemLabel     $label

NumberOfAtoms     $nat

NumberOfSpecies    $nas
%block ChemicalSpeciesLabel
`cat species`
%endblock ChemicalSpeciesLabel


LatticeConstant     1.00 Ang
%block LatticeVectors
 $a1   $a2  $a3
 $b1   $b2  $b3
 $c1   $c2  $c3
%endblock LatticeVectors

MeshCutoff          $cutoff  Ry
%block kgrid_Monkhorst_Pack
  1   0   0     0.0
  0   1   0     0.0
  0   0   1     0.0
%endblock kgrid_Monkhorst_Pack

#%block LocalDensityOfStates
 -10.0 1.0 eV
#%endblock LocalDensityOfStates
#%block ProjectedDensityOfStates
 -10.0 1.0 0.12 2000 eV
#%endblock ProjectedDensityOfStates

WriteMullikenPop    0    # 0 #Default value

MaxSCFIterations    10000
DM.MixingWeight      0.08
DM.NumberPulay       8
#DM.Tolerance         1.0d-4
#DM.UseSaveDM

SolutionMethod       diagon
ElectronicTemperature  25 meV

xc.functional   GGA   # Default value
xc.authors      PBE   # Default value

#**************************************************

PAO.EnergyShift    100  meV 
PAO.SplitNorm    0.30
PAO.SplitNormH   0.50

#PAO.SoftDefault true
#PAO.SoftPotential 50.0 Ry
#PAO.SoftInnerRadius 0.80

PAO.BasisSize   DZP

#**************************************************

MD.TypeOfRun         cg
MD.NumCGsteps        10000
MD.MaxCGDispl         0.05  Ang
MD.MaxForceTol        0.03 eV/Ang

MD.VariableCell   T  #

WriteCoorStep      .true.
WriteCoorXmol      .true.
WriteMDXmol        .true.

#WriteForces        .true.
#WriteMDHistory     .true.

#MD.UseSaveXV       T
#MD.TypeOfRun         Nose
#MD.InitialTemperature 300 K
#MD.TargetTemperature 300 K
#MD.Initial.Time.Step      1
#MD.Final.Time.Step        2000
#MD.Length.Time.Step       1 fs

 MM.Cutoff 20.0 Ang
%block MM.Potentials

#  1  C
1  1   Grimme   1.75   1.452 
 
#  2   Si
2  2  Grimme   9.23  1.716  

1  2  Grimme   5.49   1.600
%endblock MM.Potentials

AtomicCoordinatesFormat  Ang
%block AtomicCoordinatesAndAtomicSpecies
`cat $name1.siesta`
%endblock AtomicCoordinatesAndAtomicSpecies


EOF


echo " the file $name1.$suff.fdf was created in `pwd` please check it "

rm species*
rm *siesta
rm table

