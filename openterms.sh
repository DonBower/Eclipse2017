#!/bin/bash -x
BASEDIR=/mnt/usbstick
gpsfile=`ls -1t $BASEDIR/data/gpsdata* | tail -1`

nohup lxterminal --title="Watch GPS Log" -e "bash -c tail -f ${gpsfile}" &
