#!/bin/bash
BASEDIR="/mnt/usbstick/pictures"
while true; do 
	DATE=$(date +"%Y-%m-%d_%H-%M-%S")
	#raspistill -n -vf -hf -o $BASEDIR/$DATE.jpg
	raspistill --preview 740,40,540,320 -t 5000 -vf -hf -o $BASEDIR/$DATE.jpg
	#sleep 5s
done
