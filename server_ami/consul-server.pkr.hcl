variable "region" {
  type    = string
  default = "us-east-2"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "ubuntu" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/hvm-ssd/*ubuntu-bionic-18.04-amd64-server-*"
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true
}

source "amazon-ebs" "consul-server-base" {
  region        = var.region
  source_ami    = data.amazon-ami.ubuntu.id
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "consul-server-ubuntu-{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.consul-server-base"]
  provisioner "shell" {
    inline = [
      "git clone --branch v0.11.0 https://github.com/hashicorp/terraform-aws-consul.git",
      "terraform-aws-consul/modules/install-consul/install-consul --version 1.11.3"
    ]
  }
}