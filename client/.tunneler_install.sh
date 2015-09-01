#!/bin/bash

su - ${tunnel_user}

# Setup ssh dir
mkdir ~/.ssh && \
	chmod 600 ~/.ssh

# Generate an ssh key
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

# Setup cron
echo -e "\n\n\n#Start the ssh tunnel on each system boot" \
	"\n@reboot tmux-session -d -s ssh_tunnel \"${tunnel_dir}/tunnel.sh\"" \
	"\n" > ~/.cron

crontab ~/.cron && \
	rm ~/.cron

# Deploy the key
echo -e "\n\n\t - We're not going to deploy the SSH key to th eserver, hopefully you've run the server installation first" \
	"\n\tIf not, do so now and keep note of the password it gives you\n\n"

ssh-copy-id ${remote_server} -p ${remote_port}