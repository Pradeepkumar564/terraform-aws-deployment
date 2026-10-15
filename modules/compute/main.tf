
#checkov:skip=CKV_AWS_260:Public HTTP is intentional for the demo website.
#checkov:skip=CKV_AWS_382:Unrestricted outbound access is retained for package installation in this lab.
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP and optional SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.allowed_ssh_cidr == "" ? [] : [var.allowed_ssh_cidr]

    content {
      description = "SSH from approved IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    description = "Allow outbound traffic for package installation and web server operation"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-web-sg"
  }
}

resource "aws_iam_role" "ec2" {
  name = "${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.environment}-ec2-profile"
  role = aws_iam_role.ec2.name
}


#checkov:skip=CKV_AWS_88:Public IP is intentional for direct HTTP access in this lab.
#checkov:skip=CKV_AWS_126:Detailed monitoring is omitted to avoid additional charges.
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  ebs_optimized = true

  root_block_device {
    encrypted = true
  }

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.web.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  associate_public_ip_address = true
  user_data                   = file("${path.module}/userdata.sh")
  user_data_replace_on_change = true

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "${var.environment}-web-server"
  }
}

resource "aws_eip" "web" {
  domain   = "vpc"
  instance = aws_instance.web.id

  tags = {
    Name = "${var.environment}-web-eip"
  }
}
variable "vpc_id" {
  type = string
}