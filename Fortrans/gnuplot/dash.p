set terminal pngcairo font "helvetica,25" size 1000,1000
set termoption dash 
set output "DOS_O-BP.png"
#set style fill transparent solid 0.70 noborder
set key inside left top vertical Left reverse enhanced autotitles nobox
set key noinvert samplen 1 spacing 1 width 0 height 0
set arrow 1 from -12,0 to 2,0 lc 0 nohead
set style line 1  linecolor rgb "red"  linewidth 3.000 pointtype 2 dashtype 2 pointsize default pointinterval 0
set style line 2  linecolor rgb "orange"  linewidth 2.000 pointtype 2 dashtype 2 pointsize default pointinterval 0
set style line 3  linecolor rgb "blue"  linewidth 3.000 pointtype 2 dashtype 2 pointsize default pointinterval 0
set style line 4  linecolor rgb "red"  linewidth 3.000 dt (8, 4)
set xtics nomirror
set ytics nomirror
set xlabel 'Energy(eV)' 
set ylabel 'Density of states (arb. unit)'
set xrange [-12:2]
set yrange [-5:5]
set mxtics 2 
set ytics -7,15
plot "DOS_O-alpha.txt" using 1:2 w l lw 2 lc rgb "blue" t "O-BP", "DOS_O-beta.txt" using 1:(-$2) w l lw 2 lc rgb "blue" notitle, "DOS_Onh3-alpha.txt" using 1:2 w l ls 4 t "O-BP + NH_3", "DOS_Onh3-beta.txt" using 1:(-$2) w l ls 4 notitle
