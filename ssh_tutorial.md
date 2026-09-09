# SSH Tutorial — Remote Access with Tailscale

## What is SSH?

SSH (Secure Shell) lets you remotely control another computer through a terminal. You type commands on your machine and they run on the remote server.

We use **Tailscale** to connect both machines on a private network, so SSH works securely without opening any ports.

---

## Our Setup

```
[ Your Laptop ] ──── Tailscale ──── [ Ubuntu Server ]
                     100.x.x.x
```

---

## Part 1 — Installing SSH

Some Linux distributions don't come with SSH installed by default. Here's how to install it on the most common ones.

> 📸 **Screenshot here:** terminal showing the install command running

### Ubuntu / Debian
```bash
sudo apt update
sudo apt install openssh-server openssh-client
```

### Fedora / RHEL / CentOS
```bash
sudo dnf install openssh-server openssh-clients
```

### Arch Linux
```bash
sudo pacman -S openssh
```

### After installing — start and enable SSH

```bash
# Start the SSH service
sudo systemctl start ssh

# Enable it so it starts automatically on boot
sudo systemctl enable ssh

# Check it's running
sudo systemctl status ssh
```

> 📸 **Screenshot here:** `systemctl status ssh` output showing "active (running)" in green

---

## Part 2 — Setting Up Tailscale

### On the Ubuntu Server

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

> 📸 **Screenshot here:** terminal showing the Tailscale login URL after running `tailscale up`

A login link will appear — open it in a browser and sign in to your Tailscale account.

### On Your Client Machine

**Linux:**
```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

**macOS:**
```bash
brew install tailscale
sudo tailscale up
```

**Windows:**  
Download and install from [tailscale.com/download](https://tailscale.com/download), then sign in.

> 📸 **Screenshot here:** Tailscale admin panel at login.tailscale.com showing both devices listed as connected

### Get the Server's Tailscale IP

Run this on the server:
```bash
tailscale ip -4
```

> 📸 **Screenshot here:** terminal output of `tailscale ip -4` showing the 100.x.x.x IP

---

## Part 3 — Connecting via SSH

Once both machines are on Tailscale, just run:

```bash
ssh username@100.x.x.x
```

Example:
```bash
ssh guruman@100.64.0.5
```

Enter your server user's password and you're in.

> 📸 **Screenshot here:** terminal showing a successful SSH login — the server's welcome message / prompt

---

## Part 4 — Copying Files with SCP

SCP lets you move files between your machine and the server over SSH.

```bash
# Send a file to the server
scp file.txt guruman@100.64.0.5:/home/guruman/

# Download a file from the server
scp guruman@100.64.0.5:/home/guruman/file.txt ./

# Send a whole folder
scp -r ./myfolder/ guruman@100.64.0.5:/home/guruman/
```

> 📸 **Screenshot here:** terminal showing a successful SCP transfer

---

## Part 5 — Quick Commands

| Command | What it does |
|---|---|
| `tailscale ip -4` | Get your Tailscale IP |
| `tailscale status` | See all connected devices |
| `ssh user@100.x.x.x` | Connect to server |
| `scp file user@100.x.x.x:/path` | Copy file to server |
| `exit` | Close SSH session |

---

## Part 6 — Troubleshooting

| Problem | Fix |
|---|---|
| `Connection refused` | Check SSH is running: `sudo systemctl status ssh` |
| `Permission denied` | Wrong username or password |
| Can't reach the server | Run `tailscale status` — make sure both machines show as connected |
| Wrong IP | Re-run `tailscale ip -4` on the server |

edf