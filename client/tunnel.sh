#!/bin/bash

. ${HOME}/config.sh

# already running?
if [[ -s ${tunnel_dir}/.tunnel.pid ]]; then

    # already running
    if kill -0 $(cat ${tunnel_dir}/.tunnel.pid) &> /dev/null; then
        exit 0

    # not running - nuke the pid file
    else
        rm ${tunnel_dir}/.tunnel.pid
    fi
fi

# Create a lock /pi dfile
echo $$ > ${tunnel_dir}/.tunnel.pid

while true; do
    ssh -tN -R ${tunnel_port}:${local_forward} -p ${remote_port} ${tunnel_user}@${remote_server} \
        > >(tee -a ${log}) \
        2> >(tee -a ${err_log}) \

    echo -e "\n\t - Lost connection, connecting again in 5 seconds...\n" | tee ${err_log}

    sleep 10
done
