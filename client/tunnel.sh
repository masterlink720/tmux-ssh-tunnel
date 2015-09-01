#!/bin/bash

. ${HOME}/ssh_tunnel/config

while true; do
    ssh -t -R ${remove_port}:{local_forward} -p ${remote_port} ${remote_server} \
        > >(tee -a ${log}) \
        2> >(tee -a ${err_log}) \

    echo -e "\n\t - Lost connection, connecting again in 5 seconds...\n" | tee ${err_log}

    sleep 5
done
