#!/usr/bin/env bashio
WAIT_PIDS=()
CONFIG_PATH='/share/frpc.toml'
DEFAULT_CONFIG_PATH='/frpc.toml'

function stop_frpc() {
    bashio::log.info "Shutdown frpc client"
    kill -15 "${WAIT_PIDS[@]}"
}

bashio::log.info "Copying configuration."
cp $DEFAULT_CONFIG_PATH $CONFIG_PATH
sed -i "s/serverAddr = \"your_server_addr\"/serverAddr = \"$(bashio::config 'serverAddr')\"/" $CONFIG_PATH
sed -i "s/serverPort = 7000/serverPort = $(bashio::config 'serverPort')/" $CONFIG_PATH

# SSH proxy configuration
sed -i "s/name = \"your_ssh_proxy_name\"/name = \"$(bashio::config 'sshProxyName')\"/" $CONFIG_PATH
sed -i "s/customDomains = \[\"ssh_device_name\"\]/customDomains = [\"$(bashio::config 'sshDeviceName')\"]/" $CONFIG_PATH

# Home Assistant proxy configuration
sed -i "s/name = \"your_home_assistant_proxy_name\"/name = \"$(bashio::config 'webProxyName')\"/" $CONFIG_PATH
sed -i "s/customDomains = \[\"example.com\"\]/customDomains = [\"$(bashio::config 'customDomain')\"]/" $CONFIG_PATH
sed -i "s|locations = \[\"/location\"\]|locations = [\"$(bashio::config 'locationPath')\"]|" $CONFIG_PATH
sed -i "s/httpUser = \"http_user\"/httpUser = \"$(bashio::config 'httpUser')\"/" $CONFIG_PATH
sed -i "s/httpPassword = \"http_password\"/httpPassword = \"$(bashio::config 'httpPassword')\"/" $CONFIG_PATH


bashio::log.info "Starting frp client"

cat $CONFIG_PATH

cd /usr/src
./frpc -c $CONFIG_PATH & WAIT_PIDS+=($!)

tail -f /share/frpc.log &

trap "stop_frpc" SIGTERM SIGHUP
wait "${WAIT_PIDS[@]}"
