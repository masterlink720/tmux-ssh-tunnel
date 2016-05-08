#!/bin/bash
#
# Removes all users etc setup for this application
#
# #

if [ ! -s ../.config.sh ]; then
    echo -e "\e[1m\e[93mMissing .config.sh, please copy it from config.sh\e[0m\n"
    exit 1
fi

if [ ${UID} -ne 0 ]; then
    echo -e "\n\e[1m\e[93m[ERROR] Run the script as root\0m\n"
    exit 1
fi

. ../.config.sh

# Kill all procs
pkill -U ${tunnel_user} &> /dev/null1

crontab -u ${tunnel_user} -r &> /dev/null
userdel ${tunnel_user} &> /dev/null
# rm /home/${tunnel_user} -rf &> /dev/null
