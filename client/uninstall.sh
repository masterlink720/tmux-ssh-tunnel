#!/bin/bash
#
# Removes all users etc setup for this application
#
# #

. ../config
sudo crontab -u ${tunnel_user} -r
sudo userdel ${tunnel_user}
sudo rm /home/${tunnel_user} -rf

rm /tmp/*.cron -rf