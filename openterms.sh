#!/bin/bash -x
nohup lxterminal --title="Watch GPS Log" -e "bash -c /home/pi/Developer/Eclipse2017/watchgps.sh" &
nohup lxterminal --title="Watch LUX Log" -e "bash -c /home/pi/Developer/Eclipse2017/watchlux.sh" &
nohup lxterminal --title="Watch WX Log" -e "bash -c /home/pi/Developer/Eclipse2017/watchwx.sh" &
