# SSH Documentation

## Overview

This project combines two technologies with different roles:

**OpenSSH** provides secure remote login.

**Tailscale** provides private network connectivity between
authenticated devices.

Together they allow an SSH client to reach an Ubuntu server through its
Tailscale address.

## Client-Server Model

``` text
SSH Client
    |
    | SSH
    v
Tailscale Network
    |
    v
SSH Server
Ubuntu
```

The client initiates the connection. The server accepts the connection
and authenticates the user.

## OpenSSH Server

OpenSSH Server can be installed on Ubuntu with:

``` bash
sudo apt update
sudo apt install -y openssh-server
```

The service can be enabled and started with:

``` bash
sudo systemctl enable --now ssh
```

## SSH Port

SSH commonly listens on TCP port 22.

Check listening sockets:

``` bash
sudo ss -tlnp | grep :22
```

## Authentication

SSH supports multiple authentication mechanisms.

Password authentication is simple for initial learning and testing.

SSH key authentication uses:

-   Public key --- placed on the server
-   Private key --- retained by the client

The private key should never be shared.

## Tailscale

Tailscale creates a private overlay network over existing network
infrastructure.

Devices authenticate to the same tailnet and can communicate using
Tailscale addresses.

Useful commands:

``` bash
tailscale status
tailscale ip -4
```

## Important Distinction

Tailscale and SSH are not the same technology.

``` text
Tailscale → provides private connectivity
SSH       → provides remote login
```

The SSH session still uses SSH authentication and encryption. Tailscale
provides the network path between the devices.

## SSH Configuration

The SSH server configuration is commonly located at:

``` text
/etc/ssh/sshd_config
```

After changing SSH configuration, validate it before restarting:

``` bash
sudo sshd -t
```

Then restart SSH if required:

``` bash
sudo systemctl restart ssh
```

## SCP

SCP can transfer files over SSH.

Client to server:

``` bash
scp file.txt username@TAILSCALE_IP:/home/username/
```

Server to client:

``` bash
scp username@TAILSCALE_IP:/home/username/file.txt .
```

## Diagnostics

Check SSH:

``` bash
sudo systemctl status ssh
```

Check Tailscale:

``` bash
tailscale status
```

Check the Tailscale IP:

``` bash
tailscale ip -4
```

Check SSH listening port:

``` bash
sudo ss -tlnp | grep :22
```

## Security Considerations

-   Keep Ubuntu and OpenSSH updated.
-   Protect private SSH keys.
-   Use strong authentication.
-   Only authenticate trusted devices to the Tailscale network.
-   Avoid unnecessary public exposure of port 22.
-   Validate SSH configuration before applying changes.

Do not use fabricated screenshots; capture evidence from the actual
implementation.

## Proof of Concept

The proof of concept demonstrates the complete remote-access workflow.

### Demonstration Video

[▶️ Watch the complete demonstration](../videos/proof.mp4)

## Learning Outcomes

After completing this project, a learner should understand:

-   SSH client/server architecture
-   Basic OpenSSH setup
-   SSH authentication concepts
-   Tailscale overlay networking
-   Remote terminal access
-   SCP file transfer
-   Basic Linux service management
-   Basic Bash automation
-   Troubleshooting remote connections
