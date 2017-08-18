driverlist=~/Developer/Eclipse2017/DriverList.txt
while read driver
  do
    cd ~/Developer
    driver=Adafruit_Python_ADS1x15

    if [ -d $driver ]
      then
        cd $driver
        git pull
        cd ~/Developer
      else
        git clone git@github.com:adafruit/$driver.git
    fi

    cd $driver
    sudo python setup.py install
    sudo python3 setup.py install
done < $driverlist
