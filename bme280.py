#!/usr/bin/env python3
'''
  runbme.py
  Collect Temperature, Humidity & Barometric Pressure and Temperature from BME280 sensor
  and record them into a log file
  2017-08-04 - Donald Bower
'''
from Adafruit_BME280 import *
import time

BASEDIR = "/mnt/usbstick/data"
DATESTR = time.strftime("%Y-%m-%d_%H:%M:%S")
DATAFILE='{:s}/wxdata_{:s}.txt'.format(BASEDIR,DATESTR)

F1 = open(DATAFILE, "w", 1) # Open File, write to disk every line.
global readcount
readcount = 0

def setup():
    print('Setting up BME280 Sensor, please wait...')
    print('Open File {:s} for append'.format(DATAFILE))

def loop():
    global readcount
    sensor = BME280(t_mode=BME280_OSAMPLE_8, p_mode=BME280_OSAMPLE_8, h_mode=BME280_OSAMPLE_8)

    while True:
        degrees = sensor.read_temperature()
        pascals = sensor.read_pressure()
        humidity = sensor.read_humidity()
        readcount = readcount + 1
        if degrees is not None and pascals is not None and humidity is not None:
            hectopascals = pascals / 100
            TimeStampStr = time.strftime("%Y-%m-%d %H:%M:%S")
            if readcount > 6:
                print('{0:18} {1:0.3f}C {2:0.2f}hPa {3:0.2f}%'.format(TimeStampStr,degrees, hectopascals, humidity))
                readcount = 0
            F1.write('{0:18} {1:0.3f}C {2:0.2f}hPa {3:0.2f}%\n'.format(TimeStampStr,degrees, hectopascals, humidity))
        else:
            print ("Failed to get WX readings, will retry in 5 seconds")
        time.sleep(5)

def destroy():
    F1.close()

if __name__ == "__main__":
    setup()
    try:
        loop()
    except KeyboardInterrupt:
        destroy()
