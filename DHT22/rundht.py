#!/usr/bin/env python
#-------------------------------------------------
# balloon.py
# Collect Humidity, Temperature from DHT and Barometric Pressure and Temperature from BMP085 sensors
# and record them into a log file
# 2016-17-25 - Donald Bower
#------------------------------------------------
import Adafruit_DHT as DHT
import RPi.GPIO as GPIO
import time

DHTSensor = 22
DHTGPIOPin = 21
TimeStampStr = time.strftime("%Y-%m-%d_%H-%M-%S")
logfile='/mnt/usbstick/dhtdata_{:s}.txt'.format(TimeStampStr)

F1 = open(logfile, "w", 1) # Open File, write to disk every line.
F1.write("test\n")
def setup():
	print ("Setting up, please wait...")
	print "Open File ", logfile, " for append"

def loop():

	while True:
		DHThumidity, DHTtemp = DHT.read_retry(DHTSensor, DHTGPIOPin)

		if DHThumidity is not None and DHTtemp is not None:
			TimeStampStr = time.strftime("%Y-%m-%d %H:%M:%S")
			DHTTempStr = '|DHT-Temp|{0:=+010.5f} C'.format(DHTtemp)
			DHTHumidityStr = '|DHT-Humidity|{0:=+010.5f}%'.format(DHThumidity)
			print ("{:s}{:s}{:s}{:s}{:s}".format(TimeStampStr,DHTTempStr,DHTHumidityStr))
			F1.write('{:s}{:s}{:s}{:s}{:s}\n'.format(TimeStampStr,DHTTempStr,DHTHumidityStr))
		else:
			print ("'Failed to get reading. Try again!'")
		time.sleep(5)

def destroy():
	GPIO.cleanup()
	F1.close()

if __name__ == "__main__":
	setup()
	try:
		loop()
	except KeyboardInterrupt:
		destroy()
