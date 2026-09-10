# Remote SSH Access with Tailscale

A practical project demonstrating remote access to an Ubuntu server
using OpenSSH and Tailscale.

## Overview

This project shows how an Ubuntu server can be accessed remotely from
another device, even when the devices are connected to different
physical networks.

The project uses:

-   **OpenSSH** for remote terminal access
-   **Tailscale** for private network connectivity between devices
-   **Ubuntu Server** as the remote server
-   **Bash scripts** for basic setup and diagnostics

## Architecture

``` text
Client Device
     |
     | SSH connection
     v
Tailscale Network
     |
     v
Ubuntu Server
(OpenSSH Server)
```

SSH provides the remote login service, while Tailscale provides private
connectivity between the devices.

## Requirements

-   Ubuntu Server
-   A client computer with an SSH client
-   Internet connectivity
-   Tailscale installed on the devices
-   Administrative access to the Ubuntu server

## Quick Start

### 1. Install OpenSSH Server

On the Ubuntu server:

``` bash
sudo apt update
sudo apt install -y openssh-server
```

Enable and start the SSH service:

``` bash
sudo systemctl enable --now ssh
```

Check its status:

``` bash
sudo systemctl status ssh
```

### 2. Install and connect Tailscale

Install Tailscale using the official instructions, then authenticate the
server to your Tailscale network.

Check the connection:

``` bash
tailscale status
```

Find the server's Tailscale IP:

``` bash
tailscale ip -4
```

### 3. Connect remotely

From the client device:

``` bash
ssh username@TAILSCALE_IP
```

Replace `username` with the Ubuntu username and `TAILSCALE_IP` with the
server's Tailscale IPv4 address.

## Automation

The `scripts/` directory contains small Bash scripts for repetitive
tasks.

### Setup script

``` bash
bash scripts/setup_ssh.sh
```

### Diagnostic script

``` bash
bash scripts/check_ssh.sh
```

## Testing

The connection can be tested by:

1.  Connecting both devices to the same Tailscale network.
2.  Checking that the server appears in `tailscale status`.
![alt text](images\ss2.png)
3.  Getting the server's Tailscale IP.
![alt text](images\ss4.png)
4.  Connecting using SSH.
![alt text](images\ss1.png)
5.  Running commands on the remote Ubuntu server.
![alt text](images\ss3.png)
6.  Testing the connection from a different physical network.

## Project Structure

``` text
remote-ssh-tailscale/
├── README.md
├── docs/
│   ├── ssh-tutorial.md
│   └── ssh-documentation.md
├── scripts/
│   ├── setup_ssh.sh
│   └── check_ssh.sh
├── images/
└── LICENSE
```

## Security Notes

-   Keep the SSH server updated.
-   Use strong authentication.
-   Never share private SSH keys.
-   Only add trusted devices to the Tailscale network.
-   Avoid exposing SSH directly to the public internet when private
    connectivity is sufficient.

## References

-   OpenSSH documentation: https://www.openssh.com/
-   Tailscale documentation: https://tailscale.com/docs/
-   Ubuntu documentation: https://documentation.ubuntu.com/

## Status

This project is intended as a practical demonstration and learning
resource.
