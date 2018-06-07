#!/bin/bash
#
# Create custom fan SPEED for AMD GPUs
# adapted from India guy @jimkarter at Hive OS Chat (English) Telegram Group by
# @alecsandrofs (just a "normal" brazilian guy)
 
# Set display, else nvidia commands will not work (commented not necessary to AMD I think)
#export DISPLAY=:0
 
echo "---------------"
/bin/date
 
# Get number of AMD GPUs in the system
NO_OF_GPUS=`/hive/sbin/amdcovc |grep -i adapter| wc |awk '{print $1}'`
echo "$NO_OF_GPUS GPUs found."
NO_OF_GPUS=$((NO_OF_GPUS - 1));
 
# For every GPU, check the temperature and set fan speed
for i in `seq 0 $NO_OF_GPUS`;
do
        TEMP=`/hive/sbin/amdcovc -a $i |grep "Temp" | awk '{print $12}'`
        echo "GPU $i : Temp: $TEMP"
        if [ "$TEMP" -ge 70 ]; then
                /hive/sbin/amdcovc fanspeed:$i=100
        elif [ "$TEMP" -ge 67 ]; then
                /hive/sbin/amdcovc fanspeed:$i=90
        elif [ "$TEMP" -ge 65 ]; then
                /hive/sbin/amdcovc fanspeed:$i=85
        elif [ "$TEMP" -ge 63 ]; then
                /hive/sbin/amdcovc fanspeed:$i=80
        elif [ "$TEMP" -ge 62 ]; then
                /hive/sbin/amdcovc fanspeed:$i=75
        elif [ "$TEMP" -ge 61 ]; then
                /hive/sbin/amdcovc fanspeed:$i=70
        elif [ "$TEMP" -ge 59 ]; then
                /hive/sbin/amdcovc fanspeed:$i=65
        elif [ "$TEMP" -ge 57 ]; then
                /hive/sbin/amdcovc fanspeed:$i=60
        elif [ "$TEMP" -ge 55 ]; then
                /hive/sbin/amdcovc fanspeed:$i=50
        else
                /hive/sbin/amdcovc fanspeed:$i=45
        fi
done
