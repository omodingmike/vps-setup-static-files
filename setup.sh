#!/bin/bash
set -e

# --- Check domain argument ---
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1
WEBROOT="/var/www/${DOMAIN}"

echo ">>> Setting up Nginx + SSL for domain: $DOMAIN"

echo "Updating system packages..."
apt update -y && apt upgrade -y

echo "Installing Nginx and Certbot..."
apt install -y nginx certbot python3-certbot-nginx

echo "Creating web root directory..."
mkdir -p $WEBROOT
chown -R www-data:www-data $WEBROOT
chmod -R 755 $WEBROOT

# Create a sample index.html if not exists
if [ ! -f "$WEBROOT/index.html" ]; then
    cat <<EOF > $WEBROOT/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to $DOMAIN</title>
</head>
<body>
    <h1>Success! Nginx is serving static files for $DOMAIN</h1>
</body>
</html>
EOF
fi

echo "Creating temporary Nginx server block for HTTP..."
cat <<EOF > /etc/nginx/sites-available/$DOMAIN
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    root $WEBROOT;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx

echo "Obtaining SSL certificate from Let's Encrypt..."
certbot --nginx -d $DOMAIN -d www.$DOMAIN --non-interactive --agree-tos -m admin@$DOMAIN

echo "Enabling auto-renewal..."
systemctl enable certbot.timer
systemctl start certbot.timer

echo ">>> Setup complete! 🎉"
echo "Your static site is served from: $WEBROOT"
echo "SSL certs are managed automatically by Let's Encrypt."
