# Pre-requisites
Must have a serial connection to the Dell MD1200 to your server/computer that you are running the service off of


# Installation (Debian Linux used for all of this, will work on any linux)
1. Copy or create/paste md1200-fan-control.sh to desired location on your linux OS. I used /usr/local/bin
2. Copy or create/paste md1200-fan-control.service to your service file locations, usually /etc/systemd/system
3. sudo systemctl daemon-reload
5. sudo systemctl enable md1200-fan-control.service
6. sudo systemctl start md1200-fan-control.service

## Monitoring/logging
sudo systemctl status md1200-fan-control.service
journalctl -fu md1200-fan-control.service
