################################################################################
# Bastion Host Module - Jump Box for Private Resource Access
################################################################################

################################################################################
# Latest Amazon Linux 2023 AMI
################################################################################

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

################################################################################
# SSH Key Pair
################################################################################

resource "aws_key_pair" "bastion" {
  key_name   = "${var.environment}-bastion-key"
  public_key = var.ssh_public_key

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion-key"
  })
}

################################################################################
# Bastion Security Group
################################################################################

resource "aws_security_group" "bastion" {
  name        = "${var.environment}-bastion-sg"
  description = "Security group for bastion host - SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access from allowed IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion-sg"
  })
}

################################################################################
# Bastion EC2 Instance
################################################################################

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-bastion"
  })
}
