First order of business, was to connect to my WiFi, which had to be done via the KVM Interface. <br />
Next we update/upgrade the OS to the latest version, as well as the RaspberryPi Firmware.  <br />
```
sudo apt-get update
sudo rpi-update
sudo apt-get dist-upgrade
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
git clone git@github.com:DonBower/Eclipse2017.git
```
If you need updates from github, use git pull:
```
git pull origin master
```

In addition to the RaspberryPi, we need a storage device for all the data we will collect.
I'm not really sure at this time what size we need, so I'll go big, ang use the [Samsung 128GB USB 3.0 Flash Drive Fit](https://www.amazon.com/Samsung-128GB-Flash-MUF-128BB-AM/dp/B017DH3O5A) from amazon.
