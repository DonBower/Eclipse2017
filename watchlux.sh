#!/bin/bash
BASEDIR=/mnt/usbstick
luxfile=`ls -1t $BASEDIR/data/luxdata* | tail -1`

tail -f ${luxfile}
