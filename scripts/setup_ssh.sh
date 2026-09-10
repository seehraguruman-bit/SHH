
set -e

echo "=== SSH Server Setup ==="

echo "[1/4] Updating package lists..."
sudo apt update

echo "[2/4] Installing OpenSSH Server..."
sudo apt install -y openssh-server

echo "[3/4] Enabling and starting SSH..."
sudo systemctl enable --now ssh

echo "[4/4] Checking SSH service..."
systemctl --no-pager --full status ssh

echo
echo "SSH setup completed."
echo "SSH normally listens on TCP port 22."
