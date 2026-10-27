resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("%s.0.0/19", var.cidr_block)
  availability_zone = format("%sa", var.aws_region)

  tags = {
    "Name"                                                  = format("%s-private-1a", var.vpc_name)
    "kubernetes.io/cluster/${var.cluster_name}"             = "shared"
    "kubernetes.io/role/internal-elb"                       = "1"
    "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("%s.32.0/19", var.cidr_block)
  availability_zone = format("%sb", var.aws_region)

  tags = {
    "Name"                                                  = format("%s-private-1b", var.vpc_name)
    "kubernetes.io/cluster/${var.cluster_name}"             = "shared"
    "kubernetes.io/role/internal-elb"                       = "1"
    "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = format("%s.64.0/19", var.cidr_block)
  availability_zone = format("%sc", var.aws_region)

  tags = {
    "Name"                                                  = format("%s-private-1c", var.vpc_name)
    "kubernetes.io/cluster/${var.cluster_name}"             = "shared"
    "kubernetes.io/role/internal-elb"                       = "1"
    "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = format("%s.96.0/19", var.cidr_block)
  availability_zone       = format("%sa", var.aws_region)
  map_public_ip_on_launch = true
  tags = {
    "Name"                                      = format("%s-public-1a", var.vpc_name)
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = format("%s.128.0/19", var.cidr_block)
  availability_zone       = format("%sb", var.aws_region)
  map_public_ip_on_launch = true
  tags = {
    "Name"                                      = format("%s-public-1b", var.vpc_name)
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = format("%s.160.0/19", var.cidr_block)
  availability_zone       = format("%sc", var.aws_region)
  map_public_ip_on_launch = true
  tags = {
    "Name"                                      = format("%s-public-1c", var.vpc_name)
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}