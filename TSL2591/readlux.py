import tsl2591
VISIBLE = 2  # channel 0 - channel 1
INFRARED = 1  # channel 1
FULLSPECTRUM = 0  # channel 0

GAIN_LOW = 0x00  # low gain (1x)
GAIN_MED = 0x10  # medium gain (25x)
GAIN_HIGH = 0x20  # medium gain (428x)
GAIN_MAX = 0x30  # max gain (9876x)

tsl = tsl2591.Tsl2591()  # initialize

thisGain = tsl.get_gain()
print('This Gain is {}'.format(thisGain))

tsl.set_gain(GAIN_MED)

thisGain = tsl.get_gain()
print('New Gain is {}'.format(thisGain))


full, ir = tsl.get_full_luminosity()  # read raw values (full spectrum and ir spectrum)
#print full, ir
lux = tsl.calculate_lux(full, ir)  # convert raw values to lux
#print full, lux, ir
newfull = tsl.get_luminosity(FULLSPECTRUM)
newlux = tsl.get_luminosity(VISIBLE)
newir = tsl.get_luminosity(INFRARED)
print('{10}{10}{10}'.format('Full Lux', 'Visiable', 'Infrared')
print('{10}{10}{10}'.format(newfull, newlux, newir)
