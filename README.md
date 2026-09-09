# SSH Remote Access with Tailscale

A guide for setting up secure SSH access to a remote Ubuntu server using Tailscale — no port forwarding, no public IP needed.

---

## 📁 What's in here

```
├── README.md
├── ssh_tutorial.md        ← How to set up and use SSH over Tailscale
└── ssh_documentation.md   ← Reference docs for SSH commands and config
```

---

## 🖥️ Setup

- **Server:** Ubuntu (remote access via SSH and RustDesk)
- **Networking:** Tailscale VPN
- **Connect with:** `ssh username@100.x.x.x`

---

## 🚀 Quick Start

```bash
# 1. Install Tailscale on both machines and sign in
# 2. Get the server's Tailscale IP
tailscale ip -4

# 3. SSH in
ssh username@100.x.x.x
```

---

## 📖 Docs

- New to this? → `ssh_tutorial.md`
- Looking for a command? → `ssh_documentation.md`

