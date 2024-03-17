# Bastion Host Setup
resource "aws_instance" "bastion" {
  ami                    = "ami-02cad064a29d4550c"
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name
  key_name               = "eks-bastion-dev"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "EKS-Bastion"
  }
}

# Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "eks-bastion-sg"
  description = "Security group for EKS bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}