set term pngcairo dashed enhanced font "helvetica,25" size 1000,700
set output "$var.png"
set style fill transparent solid 0.60 noborder
set key inside left top vertical Left reverse enhanced autotitles nobox
set key noinvert samplen 1 spacing 1 width 0 height 0
unset colorbox
set xlabel 'Energy(eV)' 
set ylabel 'Density of states'
set xrange [-10:2]
set xtics -10,1
set mxtics 2 
plot "$DOS" using 1:2 with filledcurves y1=0 lc rgb "blue" t "DOS", "$PDOS" using 1:2 with filledcurves y1=0 lc rgb "red" t "PDOS"
