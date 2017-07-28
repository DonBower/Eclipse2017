#!/bin/bash
ts=$(date +"%Y/%m/%d %H:%M:%S")
echo $ts "Start WX, GPS, CAM" >>  /home/pi/balloon/testlog.txt
nohup /home/pi/Eclipse2017/GPSHat/rungps.sh > /dev/null 2>&1 &
nohup /home/pi/Eclipse2017/BMP280/runbmp.py > /dev/null 2>&1 &
nohup /home/pi/Eclipse2017/DHT22/rundht.py > /dev/null 2>&1 &
nohup /home/pi/balloon/runcam.sh > /dev/null 2>&1 &
