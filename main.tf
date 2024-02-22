data "aws_security_group" "default" {
  name = "default"
  id = var.sg
}

data "aws_subnet" "default" {
  id = var.subnet
}

data "aws_ami" "hc-security-base" {
  most_recent = true

    filter {
    name   = "name"
    values = ["hc-security-base-ubuntu-2204*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  owners      = ["888995627335"]
}

resource "aws_instance" "basic" {
  ami                    = data.aws_ami.hc-security-base.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.default.id]
  subnet_id              = data.aws_subnet.default.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
    hc-owner-dl = "test@test.com"
    hc-config-as-code = "terraform"
  }
}
