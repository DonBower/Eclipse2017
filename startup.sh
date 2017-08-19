#!/bin/bash
BASEDIR="/mnt/usbstick"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
GPSERRFILE=$BASEDIR/gpserrlog.txt
WXERRFILE=$BASEDIR/wxerrlog.txt
LUXERRFILE=$BASEDIR/luxerrlog.txt
CAMERRFILE=$BASEDIR/camerrlog.txt
echo -e "$DATE Start LUX, WX, GPS, CAM" >> $BASEDIR/startlog.txt
nohup /home/pi/Developer/Eclipse2017/GPSHat/rungps.sh > /dev/null 2>$GPSERRFILE &
nohup /home/pi/Developer/Eclipse2017/runwx.py > /dev/null 2>$WXERRFILE &
nohup /home/pi/Developer/Eclipse2017/TSL2591/runlux.py > /dev/null 2>$LUXERRFILE &
nohup /home/pi/Developer/Eclipse2017/CAMERA/runcam.sh > /dev/null 2>$CAMERRFILE &
echo "UID        PID  PPID  C STIME TTY          TIME CMD" >> $BASEDIR/startlog.txt
ps -ef | grep Eclipse2017 | grep -v grep >> $BASEDIR/startlog.txt
