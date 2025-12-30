# FRPS Server for Koyeb

Fast Reverse Proxy Server (frps) configured for Pocketbase, SSH, and Git access.

## Features

- [x] HTTP/HTTPS reverse proxy
- [x] SSH tunneling (port 2222)
- [x] Pocketbase support
- [x] Git server support
- [x] Web dashboard
- [x] Wildcard subdomain support

## Deployment on Koyeb

1. Fork this repository
2. Go to [Koyeb](https://koyeb.com) and create an account
3. Create new app → Choose GitHub
4. Select this repository
5. Configure environment variables (see below)
6. Deploy!

## Environment Variables

Set these in Koyeb dashboard:

| Variable | Description | Example |
|----------|-------------|---------|
| `SUBDOMAIN_HOST` | Your DuckDNS domain | `myfrp.duckdns.org` |
| `FRPS_TOKEN` | Auth token for clients | `your-secret-token-here` |
| `DASHBOARD_USER` | Dashboard username | `admin` |
| `DASHBOARD_PWD` | Dashboard password | `secure-password` |

## Port Configuration

- **7000**: FRP control port
- **7500**: Web dashboard
- **8000**: HTTP proxy
- **8443**: HTTPS proxy
- **2222**: SSH tunnel

## Client Configuration Examples

### 1. Pocketbase (HTTP)

`frpc.toml`:
```toml
serverAddr = "myfrp.duckdns.org"
serverPort = 7000

auth.method = "token"
auth.token = "your-secret-token-here"

[[proxies]]
name = "pocketbase"
type = "http"
localIP = "127.0.0.1"
localPort = 8090
subdomain = "pb"
# Access at: http://pb.myfrp.duckdns.org:8000
```

### 2. SSH Server

`frpc.toml`:
```toml
serverAddr = "myfrp.duckdns.org"
serverPort = 7000

auth.method = "token"
auth.token = "your-secret-token-here"

[[proxies]]
name = "ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 22
remotePort = 2222

# Access with: ssh user@myfrp.duckdns.org -p 2222
```

### 3. Git Server (HTTP)

`frpc.toml`:
```toml
serverAddr = "myfrp.duckdns.org"
serverPort = 7000

auth.method = "token"
auth.token = "your-secret-token-here"

[[proxies]]
name = "git"
type = "http"
localIP = "127.0.0.1"
localPort = 3000
subdomain = "git"
# Access at: http://git.myfrp.duckdns.org:8000
```

### 4. Combined Configuration (All Services)

`frpc.toml`:
```toml
serverAddr = "myfrp.duckdns.org"
serverPort = 7000

auth.method = "token"
auth.token = "your-secret-token-here"

# Pocketbase
[[proxies]]
name = "pocketbase"
type = "http"
localIP = "127.0.0.1"
localPort = 8090
subdomain = "pb"

# SSH
[[proxies]]
name = "ssh"
type = "tcp"
localIP = "127.0.0.1"
localPort = 22
remotePort = 2222

# Git Server (like Gitea)
[[proxies]]
name = "git"
type = "http"
localIP = "127.0.0.1"
localPort = 3000
subdomain = "git"
```

## DuckDNS Setup

1. Go to [duckdns.org](https://www.duckdns.org)
2. Create subdomain (e.g., `myfrp`)
3. Point to your Koyeb app IP
4. Wildcard DNS is automatic with DuckDNS

## Accessing Services

After deployment:

- **Dashboard**: `http://your-koyeb-url:7500`
- **Pocketbase**: `http://pb.myfrp.duckdns.org:8000`
- **Git Server**: `http://git.myfrp.duckdns.org:8000`
- **SSH**: `ssh user@myfrp.duckdns.org -p 2222`

## Security Notes

**Important**: 
- Use strong tokens and passwords
- Consider using HTTPS (requires SSL certificate)
- Limit port ranges if not needed
- Monitor dashboard for unauthorized access

## Troubleshooting

### Can't connect to services
- Check if Koyeb app is running
- Verify DuckDNS is pointing to correct IP
- Check client `frpc.toml` configuration
- Look at Koyeb logs for errors

### Dashboard not accessible
- Ensure port 7500 is exposed in Koyeb
- Check `DASHBOARD_USER` and `DASHBOARD_PWD` env vars
