#!/bin/bash
BASEDIR="/mnt/usbstick"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
GPSERRFILE=$BASEDIR/gpserrlog$DATE.txt
WXERRFILE=$BASEDIR/wxerrlog$DATE.txt
LUXERRFILE=$BASEDIR/luxerrlog$DATE.txt
CAMERRFILE=$BASEDIR/camerrlog$DATE.txt
echo $ts "Start WX, GPS, CAM" >>  $BASEDIR/startlog.txt
nohup /home/pi/Eclipse2017/GPSHat/rungps.sh > /dev/null 2>$GPSERRFILE &
nohup /home/pi/Eclipse2017/runwx.py > /dev/null 2>$WXERRFILE &
nohup /home/pi/Eclipse2017/TSL2591/runlux.py > /dev/null 2>$LUXERRFILE &
nohup /home/pi/Eclipse2017/CAMERA/runcam.sh > /dev/null 2>$CAMERRFILE &
