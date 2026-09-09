# SSH Documentation

## Overview

SSH (Secure Shell) is a protocol that lets you securely connect to and control a remote machine through the terminal. All communication is encrypted.

In this project, SSH runs over **Tailscale** — a private VPN that connects both machines using a stable IP (`100.x.x.x`). This means the server never needs to expose any ports to the internet.

---

## Network Setup

```
[ Client ] ──── Tailscale VPN ──── [ Ubuntu Server ]
                  100.x.x.x
```

Tailscale gives each device a fixed private IP in the `100.x.x.x` range. SSH connects using this IP — no public IP, no router config needed.

---

## Tailscale

### What it does
Tailscale creates a private encrypted network between your devices. Once both machines are connected to Tailscale, they can reach each other from anywhere.

### Why use it instead of port forwarding?

| Port Forwarding | Tailscale |
|---|---|
| Exposes port 22 to the internet | No public ports exposed |
| Vulnerable to bots and brute-force | Only your devices can connect |
| Needs router configuration | Zero config |

### Useful Commands

```bash
tailscale ip -4       # get this device's Tailscale IP
tailscale status      # see all connected devices
sudo tailscale up     # connect to Tailscale
sudo tailscale down   # disconnect
```

---

## SSH Basics

### Connect to the server

```bash
ssh username@100.x.x.x
```

### Disconnect

```bash
exit
```

### Connect on a different port

```bash
ssh -p 2222 username@100.x.x.x
```

---

## SSH Config File

Instead of typing the full command every time, set up a shortcut in `~/.ssh/config`:

```
Host myserver
    HostName 100.64.0.5
    User guruman
    Port 22
```

Now just type:
```bash
ssh myserver
```

---

## SCP — File Transfer

SCP copies files securely over SSH.

```bash
# Upload to server
scp file.txt user@100.x.x.x:/remote/path/

# Download from server
scp user@100.x.x.x:/remote/file.txt ./local/path/

# Upload a folder
scp -r ./folder/ user@100.x.x.x:/remote/path/
```

---

## Common Errors

| Error | Cause | Fix |
|---|---|---|
| `Connection refused` | SSH not running | `sudo systemctl start ssh` |
| `Permission denied` | Wrong password or user | Double-check credentials |
| `No route to host` | Tailscale not connected | `tailscale status` on both machines |
| `Host key verification failed` | Server fingerprint changed | Delete the old entry in `~/.ssh/known_hosts` |

### Debug mode

```bash
ssh -v user@100.x.x.x
```

---

## References

- [OpenSSH Docs](https://www.openssh.com/manual.html)
- [Tailscale Docs](https://tailscale.com/kb)

