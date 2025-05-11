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

# Debug: Log all configuration values
bashio::log.info "Debug: Configuration values:"
bashio::log.info "serverAddr: $(bashio::config 'serverAddr')"
bashio::log.info "serverPort: $(bashio::config 'serverPort')"
bashio::log.info "webProxyName: $(bashio::config 'webProxyName')"
bashio::log.info "customDomain: $(bashio::config 'customDomain')"
bashio::log.info "httpUser: $(bashio::config 'httpUser')"
bashio::log.info "httpPassword: $(bashio::config 'httpPassword')"
bashio::log.info "authToken: $(bashio::config 'authToken')"

# Server configuration
bashio::log.info "Applying server configuration"
sed -i "s/serverAddr = \"your_server_addr\"/serverAddr = \"$(bashio::config 'serverAddr')\"/" $CONFIG_PATH
sed -i "s/serverPort = 7000/serverPort = $(bashio::config 'serverPort')/" $CONFIG_PATH

# Home Assistant proxy configuration
bashio::log.info "Applying Home Assistant proxy configuration"
sed -i "s/name = \"your_home_assistant_proxy_name\"/name = \"$(bashio::config 'webProxyName')\"/" $CONFIG_PATH
sed -i "s/customDomains = \[\"example.com\"\]/customDomains = [\"$(bashio::config 'customDomain')\"]/" $CONFIG_PATH
sed -i "s/httpUser = \"http_user\"/httpUser = \"$(bashio::config 'httpUser')\"/" $CONFIG_PATH
sed -i "s/httpPassword = \"http_password\"/httpPassword = \"$(bashio::config 'httpPassword')\"/" $CONFIG_PATH
sed -i "s/auth.token = \"123456789\"/auth.token = \"$(bashio::config 'authToken')\"/" $CONFIG_PATH

bashio::log.info "Starting frp client"

cat $CONFIG_PATH

cd /usr/src

# Ensure log directory exists and create empty log file if it doesn't exist
bashio::log.info "Ensuring log file exists"
mkdir -p /share
touch /share/frpc.log
bashio::log.info "Starting frpc client"
./frpc -c $CONFIG_PATH & WAIT_PIDS+=($!)

# Give frpc a moment to initialize before tailing the log
sleep 2
bashio::log.info "Tailing log file"
tail -f /share/frpc.log &

trap "stop_frpc" SIGTERM SIGHUP
wait "${WAIT_PIDS[@]}"
