
#!/bin/bash
set -Eeuo pipefail

exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting GUVI Project-03 web server setup"

dnf install -y nginx
systemctl enable nginx

cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>GUVI Terraform Project</title>
  <style>
    body {
      background: #101827;
      color: white;
      font-family: Arial, sans-serif;
      text-align: center;
      padding: 100px 20px;
    }
    h1 { color: #38bdf8; }
  </style>
</head>
<body>
  <h1>GUVI Project-03</h1>
  <h2>AWS Infrastructure Automation</h2>
  <p>Provisioned using Terraform and GitHub Actions.</p>
  <p>EC2 + Nginx + AWS</p>
</body>
</html>
EOF

nginx -t
systemctl start nginx
systemctl is-active --quiet nginx

echo "GUVI Project-03 web server setup completed"
