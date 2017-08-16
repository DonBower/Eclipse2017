#!/usr/bin/env python3
'''
  runwx.py
  Collect Temperature, Humidity & Barometric Pressure and Temperature from BME280 sensor
  and record them into a log file
  2017-08-04 - Donald Bower
'''
from Adafruit_BME280 import *
import Adafruit_MCP9808.MCP9808 as MCP9808

import time

BASEDIR = "/mnt/usbstick/data"
DATESTR = time.strftime("%Y-%m-%d_%H:%M:%S")
DATAFILE='{:s}/wxdata_{:s}.txt'.format(BASEDIR,DATESTR)

F1 = open(DATAFILE, "w", 1) # Open File, write to disk every line.

def setup():
    print('Setting up MCP9808 and BME280 Sensors, please wait...')
    print('Open File {:s} for append'.format(DATAFILE))

def c_to_f(c):
	return c * 9.0 / 5.0 + 32.0

def loop():
    readcount = 0
    bme = BME280(t_mode=BME280_OSAMPLE_8, p_mode=BME280_OSAMPLE_8, h_mode=BME280_OSAMPLE_8)
    mcp = MCP9808.MCP9808()
    while True:
        tempC = mcp.readTempC()
        temperatureC = bme.read_temperature()
        pascals = bme.read_pressure()
        humidity = bme.read_humidity()
        readcount = readcount + 1
        if tempC is not None and pascals is not None and humidity is not None:
            tempF = c_to_f(tempC)
            temperatureF = c_to_f(temperatureC)
            hectopascals = pascals / 100
            TimeStampStr = time.strftime("%Y-%m-%d %H:%M:%S")
            if readcount > 6:
                print('{0:18} {1:0.3f}C {2:0.3f}F {3:0.3f}C {4:0.3f}F {5:0.2f}hPa {6:0.2f}%'.format(TimeStampStr, tempC, tempF, temperatureC, temperatureF, hectopascals, humidity))
                readcount = 1
            F1.write('{0:18} {1:0.3f}C {2:0.3f}F {3:0.2f}hPa {4:0.2f}%\n'.format(TimeStampStr, tempC, tempF, hectopascals, humidity))
        else:
            print ("Failed to get WX readings, will retry in ~5 seconds")
        time.sleep(1)
        timeseconds = int(time.strftime("%S"))
        while timeseconds%5 > 0:
            time.sleep(.2)
            timeseconds = int(time.strftime("%S"))

def destroy():
    F1.close()

if __name__ == "__main__":
    setup()
    try:
        loop()
    except KeyboardInterrupt:
        destroy()
