#!/usr/bin/env python3
import tsl2591
import Adafruit_ADS1x15
import time

BASEDIR = "/mnt/usbstick/data"
TimeStampStr = time.strftime("%Y-%m-%d_%H-%M-%S")
DATAFILE = '{0:s}/luxdata_{1:s}.txt'.format(BASEDIR,TimeStampStr)

F1 = open(DATAFILE, "w", 1) # Open File, write to disk every line.

VISIBLE = 2  # channel 0 - channel 1
INFRARED = 1  # channel 1
FULLSPECTRUM = 0  # channel 0

GAIN_LOW = 0x00  # low gain (1x)
GAIN_MED = 0x10  # medium gain (25x)
GAIN_HIGH = 0x20  # medium gain (428x)
GAIN_MAX = 0x30  # max gain (9876x)

tsl = tsl2591.Tsl2591()  # initialize
adc = Adafruit_ADS1x15.ADS1115()
ADSGAIN = 1

thisGain = tsl.get_gain()
#print('This Gain is {}'.format(thisGain))
tsl.set_gain(GAIN_MED)
thisGain = tsl.get_gain()
#print('New Gain is {}'.format(thisGain))

def setup():
    print("Setting up, please wait...")
    print("Open File {} for append".format(DATAFILE))
    print("{0:>10} {1:>10} {2:>10} {3:>10}".format('Time', 'IR', 'Visiable', 'UV'))


def loop():
    while True:

        newfull = tsl.get_luminosity(FULLSPECTRUM)
        newlux = tsl.get_luminosity(VISIBLE)
        newir = tsl.get_luminosity(INFRARED)
        newuv = adc.read_adc(0, gain=ADSGAIN, data_rate=128)
        TimeStampStr = time.strftime("%Y-%m-%d %H:%M:%S")
        TimeStr = time.strftime("%H:%M:%S")

        print("{0:10} {1:10} ir {2:10} rgb {3:10} uv".format(TimeStr,newir, newlux, newuv))
        F1.write('{0:20} {1:10} ir {2:10} rgb {3:10} uv\n'.format(TimeStampStr, newir, newlux, newuv))
        time.sleep(5)

def destroy():
    F1.close()

if __name__ == "__main__":
    setup()
    try:
        loop()
    except KeyboardInterrupt:
        destroy()
