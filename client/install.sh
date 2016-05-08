#!/bin/bash
#
# Client-side installation
#
# This should be run on the server that will be establishing the SSH connections
#
# This should be run ATER running it on the server!!
#
# #


# tmux must be installled
if [ -z "$(type tmux 2> /dev/null)" ]; then
    echo -e "\e[1m\e[93mPlease install tmux before continuing\e[0m\n"
    exit 1
fi

if [ ! -s ../.config.sh ]; then
    echo -e "\e[1m\e[93mYou must copy config.sh to .config.sh and fill in the values\e[0m\n"
    exit 1;
fi

# Must be run as root
if [ ${UID} -ne 0 ]; then
	echo -e "\n\t [ERROR] Please run this script as root"
	exit 1
fi

. ../.config.sh

# If the remote_server hasn't been set yet, complain
if [ -z "${remote_server}" ] || [ -z "${tunnel_user}" ] ; then
	echo -e "\n\t [ERROR] the 'remote_server' or 'tunnel_user' value is missing from client/config, please set it before continuing"
	exit 1
fi

# First make the tunnel_user if he doesn't yet exist
if ! id ${tunnel_user} &> /dev/null; then
	echo -e "\n\t - Creating the user '${tunnel_user}'..."
	
	useradd --home-dir "/home/${tunnel_user}/" \
		-m --system \
		--shell $(which bash) \
		${tunnel_user} 

	mkdir -p ${tunnel_dir} && \
		cp ./*sh ${tunnel_dir}/ && \
		cp ../.config.sh /home/${tunnel_user}/config.sh &&
        ln -sf /home/${tunnel_user}/config.sh ${tunnel_dir}/config.sh &&
		chown -R ${tunnel_user}:${tunnel_user} /home/${tunnel_user}
fi

# Log in as the tunnel user and setup cron etc
sudo -H -u ${tunnel_user} bash -c ./.tunneler_install.sh
