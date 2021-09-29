#!/bin/sh

rm -f temp.png
rm -f gnu.p
read -p "enter your DOS datafile name here :       "  fdos
read -p "enter your fermi energy  :"  fermi
read -p "enter your vacuum level  :"  vac
max=`sort -nrk 2,2 $fdos  | head -1 | awk '{print $2}'`
read -p "enter a name for your plot:    "  plot
upper=`echo "$max*1.1" | bc`
pos1=`echo "$upper*0.17" | bc`
wf=`echo "$fermi-($vac)" | bc`
work=`echo "$wf*-1.0" | bc`
pos2=`echo "$wf+0.2" | bc`
cat > gnu.p << EOF
set terminal pngcairo dashed font "helvetica,30" size 1400,1000
set output "temp.png"
set key outside
set size 0.9,0.9
set origin 0.1,0.1
set style fill transparent solid 0.60 noborder
set key inside left top vertical Left reverse enhanced autotitles nobox
set key noinvert samplen 1 spacing 1 width 0 height 0
unset colorbox
unset xlabel
set label 1 "Energy(eV)" at -5,-$pos1 rotate by 180
set xrange [2:-10]
set yrange [0:$upper]
unset ylabel
unset ytics
unset y2tics 
set y2label 'Density of states'
set xtics -10,1  nomirror rotate by 90 offset 0,-1
set arrow 1 from $wf,0 to $wf,$upper lt 2 lw 3 lc 3 nohead
#set arrow 2 from 0,0 to 0,$upper lt 6 lw 2 lc 3 nohead
#set label 2 "Vacuum" at 0.2,$max rotate by 90
set label 3 "$work" at $pos2,$max-5 rotate by 90
set label 4 "WF=" at $pos2,$max-10 rotate by 90
set mxtics 2 
filter_lt(x,xmax) = ((x < xmax) ? x : 1/0)
f(x) = x
xmax = $wf
plot "$fdos" using (filter_lt(`echo '$1'`-$vac,xmax)):2 with filledcurves x1 lc rgb "royalblue" notitle,  "$fdos" using (`echo '$1'`-$vac):2 with line lt 1 lc 1 lw 3 notitle
EOF
gnuplot gnu.p
convert temp.png -rotate 90 $plot.png
