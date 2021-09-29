#! /bin/bash
echo "Hi $USER  it is `date`  have a good time"
fname=test2.dos
echo $fname
if [ -f $fname ]
then
echo "yes"
read a
else
echo "hey $USER there is a problem"
exit
fi
