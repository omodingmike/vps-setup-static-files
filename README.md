# Server Setup Script

This repository contains a simple shell script to set up an **Ubuntu VPS** with:

- **Nginx** (to serve static files)
- **Let’s Encrypt SSL** (via Certbot, with auto-renewal)
- A basic site directory under `/var/www/<domain>`

---

## 🚀 Usage

### Option 1: Download and run
```bash
curl -o ~/setup.sh https://raw.githubusercontent.com/YOUR-USERNAME/server-setup/main/setup.sh
chmod +x ~/setup.sh
./setup.sh straightahead.ug
