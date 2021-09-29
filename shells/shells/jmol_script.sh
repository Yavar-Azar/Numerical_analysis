#!/bin/bash

read -p "Enter your output name in this directory:" fname
read -p "Enter number of orbital to visualize" orbnumb
read -p "Enter cutoff value" Cutoff

cat > script1 << EOF

load $fname; wireframe 0.06;spacefill 0.5; set color rasmol TRUE; background white; isourface cutoff $Cutoff color green yellow mo $orbnumb translucent

EOF

jmol -s script1


