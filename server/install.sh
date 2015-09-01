#!/bin/bash
#
# Client-side installation
#
# This should be run on the public server that will be *RECEIVING* the connections
#
# This should be run FIRST, before the client is setup!!
#
# #

# Must be run as root
if [ ${UID} -ne 0 ]; then
	echo -e "\n\t [ERROR] Please run this script as root"
	exit 1
fi

# Fiugre out where the sshd config file is
if [ -e /etc/ssh/sshd_config ]; then
    ssh_conf='/etc/ssh/sshd_config'
else
    echo -e "\n [ERROR] unable to find sshd_config file, cannot continue\n"
    exit 1
fi

. ./config

# Make the tunnel if he does not yet exist
if ! grep -q ${tunnel_user} /etc/passwd; then
	echo -e "\n\t - Creating the tunnel_user user..."
	
	useradd --home-dir "/home/${tunnel_user}/" \
		-m --system \
		--shell $(which sh) \
		${tunnel_user} 

    tunnel_password="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 8)"
    usermod --password "${tunnel_password}" ${tunnel_user}

    echo -e "\n\n ** The password for ${tunnel_user} is '${tunnel_password}' **\n\n"
fi

# Make sure the rule hasn't already been applied
if ! grep -q "Match user ${tunnel_user}" ${ssh_conf}; then

    echo -e "\n\n" \
        "\n# Confine the ${tunnel_user} to his home directory" \
        "\nMatch user tunnel_user" \
        "\n\tChrootDirectory /home/${tunnel_user}" \
        "\n" >> ${ssh_conf}
fi
