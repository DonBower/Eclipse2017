# Eclipse2017
Measure the effects of the North America Eclipse of August 21, 2017 with a [Raspberry Pi](https://www.adafruit.com/product/3055)

Julian will be enrolled once again in his school's science fair, so this is a once in a lifetime opportunity for him, even though the science fair is not until later in the calendar year.

## Objectives:
Measure the effects of the following during the Eclipse
[NASA](https://eclipse2017.nasa.gov/citizen-science) wants the citizens to get involved, and have asked for simple temperature change to be recorded and reported back via the app that is available on their website.

However, so that we can participate in both the Citizen Science Project, and the Science Fair, we will be collecting the following information:


1. Location. Precise location is always imperative. So we will use [Adafruit's GPS Hat](https://www.adafruit.com/product/2324). The Setup for this device is described in the [GPS Folder](https://github.com/DonBower/Eclipse2017/GPSHat)
2. Temperature and Humidity. We will be collecting this information with the [DHT22 Sensor](https://www.adafruit.com/product/385). Because Humidity has an effect on the rate of temperature change, it's important to collect the Relative Humidity. Setup will be found in the [DHT22 Folder](https://github.com/DonBower/Eclipse2017/DHT22)
3. Temperature and Barometric Pressure. Barometric Pressure also has an effect on Temperature, so we will use the [BMP280 Sensor](https://www.adafruit.com/product/2651) to collect this data.  Setup will be found in the [BMP280 Folder](https://github.com/DonBower/Eclipse2017/BMP280)

All the stuff we need to launch the balloon
So while trying to re-configure the Raspberry Pi to use the on-board UART
to use with the Ultimate GPS module from Adafruit  (https://www.adafruit.com/products/746)
I had this partially working before, by enabling UART1, but there was a problem.
After enabling, the GPS sentences would have extra lines coming out of serial0 and the gpsc -s command would not work. <br />
What I would like to see is using the onboard UART, which would allow for us to use
the GPS Hat from Adafruit, which would include (https://www.adafruit.com/products/2324)

<p>

So at this point the OS has been completely reset.
Fortunately, I have a full backup of what I did here on GitHub!

First order of business, was to connect to my WiFi, which had to be done via the KVM Interface. <br />
Next we update/upgrade the OS to the latest version.  <br />
```
sudo apt-get update
sudo apt-get dist-upgrade
sudo rpi-update
sudo shutdown -r now
```
Next order of business is get a ssh key. (Take all defaults)
```
ssh-keygen
```
Copy the public SSH key to GitHub per the instructions documented in https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/<br>
Then it's time to get git, and configure the git Global Variables <br />
```
sudo apt-get install git
git config --global user.name "Don Bower"
git config --global user.email "Don.Bower@outlook.com"
```
Next clone this repository  <br />
```
git clone git@github.com:DonBower/balloon.git
```
If you need updates from github, use git pull:
```
git pull origin master
```
