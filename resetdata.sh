#!/bin/bash
BASEDIR="/mnt/usbstick"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
GPSERRFILE=$BASEDIR/gpserrlog.txt
WXERRFILE=$BASEDIR/wxerrlog.txt
LUXERRFILE=$BASEDIR/luxerrlog.txt
CAMERRFILE=$BASEDIR/camerrlog.txt

~/Developer/Eclipse2017/killall.sh >> $BASEDIR/startlog.txt

echo "" > $GPSERRFILE
echo "" > $WXERRFILE
echo "" > $LUXERRFILE
echo "" > $CAMERRFILE
rm $BASEDIR/data/*
rm $BASEDIR/data/picures/*
rm $BASEDIR/data/rawgps/*

echo -e "$DATE Reset Data" >> $BASEDIR/startlog.txt
