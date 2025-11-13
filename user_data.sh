#!/bin/bash
# Simple bootstrap for dev instances (Ubuntu/Debian / Amazon Linux may vary)
# Update & install nginx, docker, etc.
if command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y nginx
  systemctl enable nginx
  cat > /var/www/html/index.html <<'EOF'
<html><body><h1>Dev Instance</h1><p>Provisioned by Terraform</p></body></html>
EOF
  systemctl restart nginx
else
  # Amazon Linux yum
  yum update -y
  yum install -y nginx
  systemctl enable nginx
  cat > /usr/share/nginx/html/index.html <<'EOF'
<html><body><h1>Dev Instance</h1><p>Provisioned by Terraform</p></body></html>
EOF
  systemctl restart nginx
fi
