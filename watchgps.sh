#!/bin/bash
BASEDIR=/mnt/usbstick
gpsfile=`ls -1t $BASEDIR/data/gpsdata* | tail -1`

tail -f ${gpsfile}
