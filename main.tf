# 1. Fetch the official Canonical Ubuntu 24.04 LTS AMI
data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["099720109477"] # Official Canonical Owner ID for Ubuntu

  filter {
    name   = "name"
    # This grabs the latest x86_64 Ubuntu 24.04 Noble LTS image with GP3 storage
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Provision the Free-Tier Eligible EC2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type # 750 free hours/month on the standard AWS Free Tier

  tags = {
    Name = "HelloWorld"
  }
}