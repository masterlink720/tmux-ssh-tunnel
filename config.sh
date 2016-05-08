# This is an example, you must copy this file to .config.sh to implement
export tunnel_user='tunnel_user'
export session_name='ssh_tunnel'
export tunnel_port=2222
export local_port=22
export remote_port=22
export local_forward="127.0.0.1:${local_port}"
export remote_server='127.0.0.1'
export tunnel_dir="/home/${tunnel_user}/ssh_tunnel"
export log="${tunnel_dir}/tunnel.log"
export err_log="/${tunnel_dir}/tunnel.err"
