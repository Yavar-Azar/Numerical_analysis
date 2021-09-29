for ((i=1 ; i<=140; i++))
do  
read array[$i]
cat array[$i] >> newcol
sed -i.back 's/$/            '$w'/' test2.data

done
