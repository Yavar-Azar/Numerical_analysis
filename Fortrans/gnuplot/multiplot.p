set term post eps enhanced 
set output 'pyr-2lay.eps'
set size 0.6,0.7
set origin 0.25,0.25
set multiplot
set size 0.6,0.2
set origin 0.25,0.7
unset key
set title ''
set xlabel '' 
set ylabel '	'
set xrange [-7:0]
set yrange [0:85]
set xtics -11,12
set mxtics 24 
set ytics 0,20
plot 'dos.2layer' using ($1+1.8):($2*6) with lines  t '' lw 2
unset label
set size 0.6,0.23
set origin 0.25,0.51
set title ''
set xlabel '' 
set ylabel 'Density of States'
set xrange [-7:0]
set yrange [0:85]
set xtics -11,12
set mxtics 24 
set ytics 0,20
plot 'dos.23pyr' using ($1+0.8):2 with lines  t '' lw 2
unset label
set size 0.6,0.24
set origin 0.25,0.3
set title ''
set xlabel 'Energy (eV)' 
set ylabel '	'
set xrange [-7:0]
set yrange [0:85]
set xtics -10,1
set mxtics 2 
set ytics 0,20
plot 'dos.pyr2l-o-pas' using ($1+0.2):2 with lines  t '' lw 2
unset multiplot
