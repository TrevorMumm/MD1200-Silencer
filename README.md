# Pre-requisites
Must have a serial connection to the Dell MD1200 to your server/computer that you are running the service off of. This usually includes Dells proprietary password reset cable plus an serial to USB adapter.
---

# Installation (Debian Linux used for all of this, will work on any linux)
1. Copy or create/paste md1200-fan-control.sh to desired location on your linux OS. I used /usr/local/bin
   ```bash
   # Change line 13 in this script to reference your drive locations within the MD1200 array
   DRIVES=(/dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi /dev/sdj /dev/sdk /dev/sdl /dev/sdm /dev/sdn /dev/sdo /dev/sdp)
   ```
2. Copy or create/paste md1200-fan-control.service to your service file locations, usually /etc/systemd/system
3. Reload systemctl daemon
   ```bash
   sudo systemctl daemon-reload
   ```
4. Enable md1200-fan-control.service
   ```bash
   sudo systemctl enable md1200-fan-control.service
   ```
5. Start md1200-fan-control service
   ```bash
   sudo systemctl start md1200-fan-control.service
   ```
---

## Monitoring/logging
```
sudo systemctl status md1200-fan-control.service
journalctl -fu md1200-fan-control.service
```
---

## Debugging
```
# Set baud and other parameters of usb connect
stty -F /dev/ttyUSB0 38400 cs8 -cstopb -parenb -crtscts raw -echo

# Manually send command through serial to the MD1200
echo -en "set_speed 50\r" > /dev/ttyUSB0

# Connect directly to the MD1200 serial console command line interface
minicom -D /dev/ttyUSB0 -b 38400
```
