#!/bin/bash
IFS=":"
BASEDIR="/mnt/usbstick/data"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOGFILE=$BASEDIR/gpslog.txt
RAWFILE=$BASEDIR/rawdata/gpsraw-$DATE.txt
DATAFILE=$BASEDIR/gpsdata-$DATE.txt
ts=$(date +"%Y/%m/%d %H:%M:%S.%N")
echo $ts "Start GPS Process" >> $LOGFILE

function extract_dms()
{
  degrees_mf=`echo $gpgga_pos | cut -d '.' -f 1`
  if [[ ${#degrees_mf} -eq 3 ]]; then
    degrees=${1:0:3}
    minutes=${1:3:2}
  else
    degrees=${1:0:2}
    minutes=${1:2:2}
  fi
  seconds=`echo $gpgga_pos | cut -d '.' -f 2`
  printf "%i:%i:%i\n" $degrees $minutes $seconds
}

function dms_to_dd() {
  dd=`echo $1 $2 $3 | awk '{printf ("%.4f\n",$1+$2/60+$3/3600)}'`
  printf "%3.6f\n" $dd
}

while [ 1 ]
  do
      read this_line

      # if cr/lf bothers you, make it lf only
      # (os-specfic concern)
      #
      this_line=$( echo $this_line | sed s/$'\r'//g )

      # get a precise time stamp
      # %N = nanoseconds
      #
      ts=$(date +"%Y/%m/%d %H:%M:%S.%N")

      echo $ts $this_line >> $RAWFILE

      # let us filter the current position
      #
  	if [[ $this_line == \$GPGGA* ]]
    	then
    		gps_time=$(echo $this_line | cut -d, -f 2)
    		gps_latdeg=$(echo $this_line | cut -d, -f 3)
    		gps_latdir=$(echo $this_line | cut -d, -f 4)
    		gps_londeg=$(echo $this_line | cut -d, -f 5)
    		gps_londir=$(echo $this_line | cut -d, -f 6)
    		gps_fix=$(echo $this_line | cut -d, -f 7)
    		gps_sats=$(echo $this_line | cut -d, -f 8)
    		gps_hdop=$(echo $this_line | cut -d, -f 9)
    		gps_elev=$(echo $this_line | cut -d, -f 10)
  #  		echo $this_line >> $DATAFILE
#    		sleep 5s
        extract_dms($gps_latdeg) | read lat_d lat_m lat_s
        extract_dms($gps_londeg) | read lon_d lon_m lon_s
        dms_to_dd($lat_d, $lat_m, $lat_s) | read lat_dd
        dms_to_dd($lon_d, $lon_m, $lon_s) | read lon_dd
        printf "%22s %3.6f %3.6f" $ts $lat_dd $lon_dd
        printf "%22s %3.6f %3.6f" $ts $lat_dd $lon_dd >> %DATAFILE
  	fi

  	if [[ $this_line == \$GPRMC* ]]
  	then
          # ok, it looks like a GPS reading (may be void)
          # if field 3 is V, the reading is void (or maybe
          # only untrusted?), if it is A, then the position
          # is Active (and therefore given with confidence?)
          #
  		if [[ $(echo $this_line | cut -d, -f 4-6) != ",,," ]]
  		then
  		# get latitude and longitude
  			gps_fix=$(echo $this_line | cut -d, -f 3)
  			gps_pos=($(echo $this_line | cut -d, -f 3-7 | tr , ' ' | sed 's/\(^0*\)\|\(\b0*\)//g'))
              # show
  			if [[ "$gps_fix" != "V" ]]
  			then
#  				echo -e "$ts ${gps_pos[@]}" >> $DATAFILE
  				sleep 5s
  			fi
  		fi
  	fi

done < /dev/ttyAMA0
