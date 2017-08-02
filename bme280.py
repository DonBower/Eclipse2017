from Adafruit_BME280 import *
import time

sensor = BME280(t_mode=BME280_OSAMPLE_8, p_mode=BME280_OSAMPLE_8, h_mode=BME280_OSAMPLE_8)

while True:

    degrees = sensor.read_temperature()
    pascals = sensor.read_pressure()
    hectopascals = pascals / 100
    humidity = sensor.read_humidity()
    print '{0:0.3f} deg C {0:0.2f} hPa {0:0.2f} %'.format(degrees, hectopascals, humidity)
    time.sleep(5)

#    print 'Temp      = {0:0.3f} deg C'.format(degrees)
#    print 'Pressure  = {0:0.2f} hPa'.format(hectopascals)
#    print 'Humidity  = {0:0.2f} %'.format(humidity)
