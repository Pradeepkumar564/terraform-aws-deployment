
#!/bin/bash
dnf update -y
dnf install -y nginx
systemctl enable nginx
systemctl start nginx

cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>GUVI Terraform Project</title>
  <style>
    body {
      background: #101827;
      color: white;
      font-family: Arial, sans-serif;
      text-align: center;
      padding-top: 100px;
    }
    h1 { color: #38bdf8; }
  </style>
</head>
<body>
  <h1>GUVI Project-03</h1>
  <h2>AWS Infrastructure Automation</h2>
  <p>Deployed using Terraform and GitHub Actions.</p>
  <p>EC2 + Nginx + AWS</p>
</body>
</html>
EOF
