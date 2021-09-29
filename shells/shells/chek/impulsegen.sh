for ((i=1 ; i<=140; i++))
do  
w=$(($i-$i+10))
sed -i.back 's/$/            '$w'/' test2.data

done
