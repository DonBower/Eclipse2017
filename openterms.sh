#!/bin/bash -x
#nohup lxterminal --title="Watch GPS Log" -e "bash -c /home/pi/Developer/Eclipse2017/watchgps.sh" &
#nohup lxterminal --title="Watch LUX Log" -e "bash -c /home/pi/Developer/Eclipse2017/watchlux.sh" &
#nohup lxterminal --title="Watch WX Log" -e "bash -c /home/pi/Developer/Eclipse2017/watchwx.sh" &

lxterminal --title="Watch GPS Log" --geometry=80x20 --command "/home/pi/Developer/Eclipse2017/watchgps.sh"
lxterminal --title="Watch LUX Log" --geometry=80x20 --command "/home/pi/Developer/Eclipse2017/watchlux.sh"
lxterminal --title="Watch WX Log" --geometry=80x20 --command "/home/pi/Developer/Eclipse2017/watchwx.sh"
