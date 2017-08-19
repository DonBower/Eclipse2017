#!/bin/bash
BASEDIR=/mnt/usbstick
wxfile=`ls -1t $BASEDIR/data/wxdata* | tail -1`

tail -f ${wxfile}
