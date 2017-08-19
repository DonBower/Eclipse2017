#!/bin/bash
BASEDIR=/mnt/usbstick
luxfile=`ls -1tr $BASEDIR/data/luxdata* | tail -1`

tail -f ${luxfile}
