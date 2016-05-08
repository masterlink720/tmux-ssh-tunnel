#!/bin/bash

if [ -s "${HOME}/config.sh" ]; then
    source ${HOME}/config.sh

    if [ "${USER}" != "${tunnel_user}"]  && [ ${UID} -ne 0]; then
        echo -e "\t ** Must run as root, or as '${tunnel_user}' ** \n"
        exit 1
    fi
elif [ -s ../.config.sh ]; then
    if [ ${UID} -ne 0 ]; then
        echo -e "\t ** Run as root **\n"
        exit 1
    fi

    source ../.config.sh
else
    echo -e "\n\t -- Missing either '${HOME}/config.sh' or ../.config.sh'' --\n"
    exit 1
fi

tmux_cmd='tmux'
[ ${UID} -eq 0 ] && tmux_cmd="sudo -E -u ${tunnel_user} tmux"

if ! ${tmux_cmd} ls | grep -q ${session_name}; then
    echo -e "\t -- no tmux session found --\n"
    exit 1
fi

echo -e "\n\t -- Attaching to the tmux session in a moment --\n * Press ctrl-b + d to dettach *\n"

sleep 2
${tmux_cmd} a -t ${session_name}
