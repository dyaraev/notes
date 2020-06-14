## Install Ubuntu Mate on Raspberry Pi 4

### Download Ubuntu Image.

Download Ubuntu Server for Raspberry Pi from the [official website](https://ubuntu.com/download/raspberry-pi). The following steps will describe installation and configuration of Ubuntu 20.04 LTS.

### Write Image to SD Card

There are at least two possibilities. The first one is using a cross-platform utility Etcher. It can be downloaded from the [official website](https://www.balena.io/etcher/).

Mac users can also use built-in console utilities:
* Insert your SD card into a card-reader and find it in the list of attached disks:

   `diskutil list`
* Unmount the SD card (replace diskN with the disk number that you discovered on the previous step):

   `diskutil unmountDisk /dev/diskN`
* Write the image to the SD card (replace diskN with your the proper disk number and be careful because wrong disk number can result in data loss):

   `sudo dd if=/path/to/ubuntu.img of=/dev/rdiskN bs=1m`

### Run Ubuntu

Insert your SD Card into the Raspberry and turn on the board. Log in to the system and create a new password. Default login and password are `ubuntu:ubuntu`. 

### Setup Wi-Fi

To configure wi-fi you will need to modify a couple of configuration files. Different systems may have different filenames. But the general idea is the same. First of all, it is recommended to create backups of the configuration files which are going to be changed.

```bash
sudo cp /etc/cloud/cloud.cfg.d/99-fake_cloud.cfg /etc/cloud/cloud.cfg.d/99-fake_cloud.cfg.old
sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.old
```

Add the following line to `/etc/cloud/cloud.cfg.d/99-fake_cloud.cfg`:

```yaml
network: {config: disabled}
```
   
Now let's write your wi-fi configuration to `/etc/netplan/50-cloud-init.yaml`:

```yaml
network:
  version: 2
  renderer: networkd
  wifis:
    wlan0:
      dhcp4: true
      dhcp6: true
      optional: true
      access-points: 
        "AccessPointName":
          password: "SecretPassword"
```

Replace `AccessPointName` and `SecretPassword` with the SSID and the password of your wi-fi connection.

Now enter the following command in the console:

```bash
sudo netplan generate
sudo netplan apply
reboot
```

The second command may fail with an error because of [the bug](https://bugs.launchpad.net/ubuntu/+source/netplan.io/+bug/1874377) but it should not be a problem.

### Install Mate Desktop

To install Mate desktop you will need either ethernet of wi-fi connection. Most likely, the former will be faster.

If you want you can update your Ubuntu first (it is not recommended though). Just type the following commands in the console:

```bash
sudo apt-get update
sudp apt-get upgrade
```

On this step some users experience problems. If you see error like `Release file for http://archive.raspberrypi.org/debian/dists/buster/InRelease is not valid yet`, check your system's date/time. If it is ok, you can also try the following command:

```bash
sudo apt-get update --alow-releaseinfo-change
```

To install Mate desktop use the following command:

```bash
sudo apt-get install ubuntu-mate-desktop
```

After some time (which mostly depends on your connection) all the necessary packages will be downloaded and installed. After reboot you can choose which desktop to use. The one which you select will be used as default.

### Configure Display

If your desktop doesn't fit the screen you can try adding the following line to `/boot/firmware/usercfg.txt`:

```ini
disable_overscan=1
```

In this file you can reconfigure display options. For example, you can specify GPU memory:

```ini
gpu_mem=128
```

More information on video option can be found [here](https://www.raspberrypi.org/documentation/configuration/config-txt/video.md).


If you have a monitor with resulution 2560x1440, it may be difficult to find a configuration for it. As an option, you can try to add the following lines to your `/boot/firmware/usercfg.txt`:

```ini
hdmi_group=2
hdmi_mode=87

hdmi_pixel_freq_limit=250000000
hdmi_cvt=2560 1440 56 5 0 0 1

max_framebuffer_width=2560
max_framebuffer_height=1440
```

### Useful Commands

Prints current temperature:

```bash
cat /sys/class/thermal/thermal_zone0/temp
```
