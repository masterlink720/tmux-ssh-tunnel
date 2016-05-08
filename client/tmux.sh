#!/bin/bash
#
# Wrapper for tunnel.sh
# Keeps the sript running in a background tmux session

echo -e "\ntmux.sh...\n\tuser: ${USER}\n\tHOME: ${HOME}\n"

. ${HOME}/config.sh
tmux new-session -d -s ${session_name} ${tunnel_dir}/tunnel.sh
