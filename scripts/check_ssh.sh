
echo "=== Remote Access Diagnostics ==="
echo

echo "[1] SSH service:"
if systemctl is-active --quiet ssh; then
    echo "SSH service: RUNNING"
else
    echo "SSH service: NOT RUNNING"
fi

echo
echo "[2] SSH listening socket:"
sudo ss -tlnp | grep ':22' || echo "No SSH listener found on port 22."

echo
echo "[3] Tailscale status:"
if command -v tailscale >/dev/null 2>&1; then
    tailscale status
else
    echo "Tailscale is not installed or is not in PATH."
fi

echo
echo "[4] Tailscale IPv4 address:"
if command -v tailscale >/dev/null 2>&1; then
    tailscale ip -4 || true
fi

echo
echo "=== Diagnostics complete ==="
