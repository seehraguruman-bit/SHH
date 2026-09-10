# SSH Tutorial --- Remote Access with Tailscale

## 1. What is SSH?

SSH stands for **Secure Shell**. It is a protocol used to securely
access and operate another computer through a command-line interface.

In this project:

-   The Ubuntu machine is the **SSH server**.
-   The computer initiating the connection is the **SSH client**.
-   OpenSSH provides the SSH server functionality.

## 2. Install SSH on Ubuntu

Update the package list:

``` bash
sudo apt update
```

Install OpenSSH Server:

``` bash
sudo apt install -y openssh-server
```

Enable SSH at startup and start it:

``` bash
sudo systemctl enable --now ssh
```

Check the service:

``` bash
sudo systemctl status ssh
```

## 3. Understanding Authentication

SSH can authenticate users using methods such as passwords or SSH key
pairs.

With key-based authentication:

``` text
Client                         Server
Private key  ---> authentication
Public key   ----------------> authorized_keys
```

The private key should remain on the client.

## 4. Tailscale

Tailscale creates a private overlay network between authenticated
devices.

The physical networks can be different:

``` text
Client Wi-Fi
     |
     v
  Internet
     |
     v
Tailscale overlay
     |
     v
Ubuntu Server
```

Tailscale does not replace SSH. It provides private connectivity through
which SSH can operate.

## 5. Find the Tailscale Address

On Ubuntu:

``` bash
tailscale ip -4
```

You can also view connected devices:

``` bash
tailscale status
```

## 6. Connect Using SSH

From the client:

``` bash
ssh username@100.x.x.x
```

Replace the username and address with the values from your setup.

On the first connection, SSH may ask you to verify the server's host
key.

## 7. Test the Remote Session

After connecting, run:

``` bash
whoami
hostname
pwd
```

These commands confirm that commands are being executed on the remote
machine.

## 8. Copy Files with SCP

SCP can transfer files over SSH:

``` bash
scp example.txt username@100.x.x.x:/home/username/
```

To copy a file from the server to the client:

``` bash
scp username@100.x.x.x:/home/username/example.txt .
```

## 9. Testing Across Different Networks

A useful test is:

1.  Connect the Ubuntu server to one network.
2.  Connect the client to a different network.
3.  Make sure both devices are authenticated in Tailscale.
4.  Check the server's Tailscale IP.
5.  Connect using SSH.
6.  Run remote commands.

## 10. Troubleshooting

### SSH service is not running

``` bash
sudo systemctl status ssh
```

Start it with:

``` bash
sudo systemctl start ssh
```

### Check whether SSH is listening

``` bash
sudo ss -tlnp | grep :22
```

### Tailscale is not connected

``` bash
tailscale status
```

### Check the Tailscale IP

``` bash
tailscale ip -4
```

### Test basic connectivity

From the client:

``` bash
ping 100.x.x.x
```

If ICMP is blocked, that does not necessarily mean SSH is unavailable;
test SSH directly.

## 11. Useful Commands

``` bash
sudo systemctl status ssh
sudo systemctl restart ssh
tailscale status
tailscale ip -4
ssh username@TAILSCALE_IP
```

## 12. Checklist

-   [ ] Ubuntu Server installed
-   [ ] OpenSSH Server installed
-   [ ] SSH service running
-   [ ] Tailscale installed
-   [ ] Devices authenticated
-   [ ] Tailscale IP obtained
-   [ ] SSH connection tested
-   [ ] Remote commands tested
-   [ ] Cross-network test completed
-   [ ] Screenshots captured
