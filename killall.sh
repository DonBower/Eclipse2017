#!/bin/bash
BASEDIR="/mnt/usbstick"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

echo -e "$DATE Reset Data" >> $BASEDIR/startlog.txt
echo "UID        PID  PPID  C STIME TTY          TIME CMD" >> $BASEDIR/startlog.txt
ps -ef | grep Eclipse2017 | grep -v grep >> $BASEDIR/startlog.txt

pkill --signal 9 -f '/home/pi/Developer/Eclipse2017'
