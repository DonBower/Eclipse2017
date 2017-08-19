#!/bin/bash
BASEDIR=/mnt/usbstick
gpsdata=$BASEDIR/data/gpsdata-2017-08-19_12-21-21.txt

nohup lxterminal --title="Watch GPS Log" -e "bash -c tail -f ${gpsdata}" &
