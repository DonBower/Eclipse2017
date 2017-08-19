#!/bin/bash
BASEDIR=/mnt/usbstick
wxfile=`ls -1tr $BASEDIR/data/wxdata* | tail -1`

tail -f ${wxfile}
