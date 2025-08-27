# Server Setup Script

This repository contains a simple shell script to set up an **Ubuntu VPS** with:

- **Nginx** (to serve static files)
- **Let’s Encrypt SSL** (via Certbot, with auto-renewal)
- A basic site directory under `/var/www/<domain>`

---

## 🚀 Usage

### 1. Download the script
```bash
curl -o ~/setup.sh https://raw.githubusercontent.com/omodingmike/vps-setup-static-files/main/setup.sh
chmod +x ~/setup.sh
```

### 2. Download the script
./setup.sh example.com
