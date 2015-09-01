#!/bin/bash
#
# Wrapper for tunnel.sh
# Keeps the sript running in a background tmux session

tmux new-session -d -s ssh_tunnel "${HOME}/ssh_tunnel/tunnel.sh"