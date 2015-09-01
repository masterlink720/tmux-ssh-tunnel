#!/bin/bash
#
# Client-side installation
#
# This should be run on the server that will be establishing the SSH connections
#
# This should be run ATER running it on the server!!
#
# #

# Must be run as root
if [ ${UID} -ne 0 ]; then
	echo -e "\n\t [ERROR] Please run this script as root"
	exit 1
fi

. ../config

# If the remote_server hasn't been set yet, complain
if [ -z "${remote_server}" ] || [ -z "${tunnel_user}" ] ; then
	echo -e "\n\t [ERROR] the 'remote_server' or 'tunnel_user' value is missing from client/config, please set it before continuing"
	exit 1
fi


# First make the tunnel_user if he doesn't yet exist
tunnel_dir="/home/${tunnel_user}/ssh_tunnel"
#if ! grep -q ${tunnel_user} /etc/passwd; then
if ! id ${tunnel_user} /etc/passwd &> /dev/null; then
	echo -e "\n\t - Creating the user '${tunnel_user}'..."
	
	useradd --home-dir "/home/${tunnel_user}/" \
		-m --system \
		--shell $(which sh) \
		${tunnel_user} 

	mkdir -p ${tunnel_dir} && \
		cp ./*sh ${tunnel_dir}/ && \
		cp ../config ${tunnel_dir}/ &&
		chown -R ${tunnel_user}:${tunnel_user} ${tunnel_dir}
fi

# Log in as the tunnel user
sudo su --preserve-environment - ${tunnel_user} -c 'bash -s' < ./.tunneler_install.sh
# sudo -n -E -u ${tunnel_user} bash -s < ./.tunneler_install.sh


# Creating an ssh key to allow automated connections
# sudo -n -E -u ${tunnel_user} sh -c "ssh-keygen -q -t rsa -N '' -f /home/${tunnel_user}/.ssh/id_rsa"

# Install the crontab
#sudo -n -E -u ${tunnel_user} sh -c "crontab -l /tmp/${tunnel_user}.cron"

#echo -e "\n\n\n#Start the ssh tunnel on each system boot" \
#	"\n@reboot tmux-session -d -s ssh_tunnel \"${tunnel_dir}/tunnel.sh\"" \
#	"\n" > /tmp/${tunnel_user}.cron

#sudo -n -E -u ${tunnel_user} sh -c "crontab /tmp/${tunnel_user}.cron"

#rm /tmp/${tunnel_user}.cron
