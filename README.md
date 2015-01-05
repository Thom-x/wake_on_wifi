# Wake on Wifi
## Description :
Simple script to wake computer (WOL) when a devise is connected to a Wifi.
Wake up the computer When the devise is out of the wifi for more than 1h and is connecting to the wifi network.

![alt text](https://raw.githubusercontent.com/Thom-x/wake_on_wifi/master/screenshot.png "Screenshot")
## Usage :
```sh
box_ip='192.168.1.1'
pc_mac='54:04:A6:3D:3F:AF'
phone_ip='192.168.1.11'
pc_ip='192.168.1.12'
delay=3600
```

- box_ip='192.168.1.1' : Router IP
- pc_mac='54:04:A6:xx:xx:xx' : Sleeping computer MAC
- phone_ip='192.168.1.11' : Wake up trigger device
- pc_ip='192.168.1.12' : Sleeping computer IP
- delay=3600 : Minimum lost time
