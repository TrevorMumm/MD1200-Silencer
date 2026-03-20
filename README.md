# Pre-requisites
Must have a serial connection to the Dell MD1200 to your server/computer that you are running the service off of


# Installation (Debian Linux used for all of this, will work on any linux)
1. Copy or create/paste md1200-fan-control.sh to desired location on your linux OS. I used /usr/local/bin
   ```
   # Change line 13 in this script to reference your drive locations within the MD1200 array
   DRIVES=(/dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi /dev/sdj /dev/sdk /dev/sdl /dev/sdm /dev/sdn /dev/sdo /dev/sdp)
   ```
2. Copy or create/paste md1200-fan-control.service to your service file locations, usually /etc/systemd/system
3. Reload systemctl daemon
      - sudo systemctl daemon-reload
4. Enable md1200-fan-control.service
      - sudo systemctl enable md1200-fan-control.service
5. Start md1200-fan-control service
      - sudo systemctl start md1200-fan-control.service

## Monitoring/logging
- sudo systemctl status md1200-fan-control.service
- journalctl -fu md1200-fan-control.service
