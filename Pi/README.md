First order of business, was to connect to my WiFi, which had to be done via the KVM Interface. <br />
Next we update/upgrade the OS to the latest version, as well as the RaspberryPi Firmware.  <br />

```
sudo apt-get update
sudo rpi-update
```

At this point, your system may have actually performed a firmware update.  And a brave man may continue on and reboot later.  I am not that brave. `sudo shutdown -r now` if you are so inclined.


```
sudo apt-get upgrade
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

Next Create a *Developer* directory, and clone this repository from there.  The *Developer* directory is standard practice for modern developers. Some use lowercase for the name, but since on the RaspberryPi, and my Mac, all the other preloaded directories are capitalized, (i.e. Documents, Pictures, etc...) I'll follow form. <br />

```
mkdir ~/Developer
cd ~/Developer
git clone git@github.com:DonBower/Eclipse2017.git
```

If you need updates from github, use git pull:

```
cd ~/Developer/Eclipse2017
git pull origin master
```

In addition to the RaspberryPi, we need a storage device for all the data we will collect.
I'm not really sure at this time what size we need, so I'll go big, and use the [Samsung 32GB USB 3.0 Flash Drive Fit](https://www.amazon.com/Samsung-Flash-Drive-MUF-32BB-AM/dp/B013CCTOC2) from amazon.
First, find any unintentional mounts from plugging in the flash drive.

  ```
  df -h
  ```

look for devices mounted to /dev/usbsda*, and unmount them.  For example if you see a directory mounted on /dev/usbsda1, then run this command to unmount it.

  ```
  sudo umount /dev/usbsda1
  ```

Next, *and this is destructive*, remove any partitions, and create a new, fresh one.

  ```
  fdisk /dev/usbsda
  p # This will print all the partitions
  d # take the defaults to delete the last partition. Repeat as required to delete all partitions
  n # This will create a new partition.  Take all the defaults.
  w # Rewrite the new partition table.
  sudo mkfs.ext4 /dev/usbsda1
  ```

Now, format the new partition for ext4 file system.

  ```
  sudo mkfs.ext4 -L Eclipse2017 /dev/usbsda1
  ```

The follow steps will allow the USB drive to be persistently mounted.

```
sudo mkdir /mnt/usbstick
sudo chmod 777 /mnt/usbstick
sudo cat >> /etc/fstab <<EOF
LABEL=Eclipse2017  /mnt/usbstick ext4 defaults 0 1
EOF
sudo mount -a
```

You should now be able to `df -h` and see the usbstick mounted on /mnt/usbstick.

# I2C Interface
To setup the [I2C (Inter-Integrated Circuit)](https://en.wikipedia.org/wiki/I%C2%B2C)
Interface, execute the following:

```
sudo apt-get install -y python-smbus
sudo apt-get install -y i2c-tools
```
Then use raspi-config to enable the Interface.
