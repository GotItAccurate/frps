#!/bin/sh

cat > /etc/frp/frps.toml <<EOF
# FRP Server Configuration
bindPort = 7000

# HTTP/HTTPS ports
vhostHTTPPort = 8000
vhostHTTPSPort = 8443

# Your domain for subdomains
subdomain_host = "${SUBDOMAIN_HOST}"

# Dashboard configuration
webServer.addr = "0.0.0.0"
webServer.port = 7500
webServer.user = "${DASHBOARD_USER:-admin}"
webServer.password = "${DASHBOARD_PWD}"

# Authentication
auth.method = "token"
auth.token = "${FRPS_TOKEN}"

# Allow custom domains
allowPorts = [
  { single = 2222 },
  { start = 6000, end = 6100 }
]

# TCP/UDP support
tcpmuxHTTPConnectPort = 7001
EOF

echo "==================================="
echo "FRPS Server Starting..."
echo "==================================="
echo "Dashboard: http://your-domain:7500"
echo "HTTP Port: 8000"
echo "HTTPS Port: 8443"
echo "SSH Port: 2222"
echo "==================================="
cat /etc/frp/frps.toml
echo "==================================="

exec /usr/bin/frps -c /etc/frp/frps.toml
