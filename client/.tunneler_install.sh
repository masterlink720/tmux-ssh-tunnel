#!/bin/bash
#
# Post-install setup script that is run as the tunnel user
#
# #

if [ ! -s ${HOME}/config.sh ]; then
    echo -e "\e[1m\e[93mMissing '${HOME}/config.sh, please run install.sh first[0m\n"
    exit 1
fi
    
. ${HOME}/config.sh

# Generate an ssh key
if [ ! -s "${HOME}/.ssh/id_rsa.pub" ]; then
    ssh-keygen -q -t rsa -N '' -f /${HOME}/.ssh/id_rsa
fi

# Setup cron
echo -e "\n\n\n#Start the ssh tunnel on each system boot" \
	"\n@reboot ${tunnel_dir}/tmux.sh" \
    "\n# Re-run every 10 minutes just in case" \
    "\n*/10 * * * * ${tunnel_dir}/tmux.sh" \
	"\n" > ${HOME}/.cron

crontab ${HOME}/.cron

# Deploy the key
echo -e "\n\n\t - We're now going to deploy the SSH key to the server, hopefully you've run the server installation first" \
	"\n\tIf not, do so now and keep note of the password it gives you\n\n"

while ! ssh-copy-id ${remote_server} -p ${remote_port}; do
    echo -e "\n\t - key deployment failed, please ensure you've run 'server/install.sh' no the remote server first... Retrying in just a moment\n"

    sleep 3
done

echo -e "\nInstallation successful - firing off the tunnel now\n"
${tunnel_dir}/tmux.sh
