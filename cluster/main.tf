terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.7"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}
data "aws_caller_identity" "current" {}

data "aws_ami" "consul_server" {
  owners = [data.aws_caller_identity.current.account_id]
  filter {
    name   = "name"
    values = ["consul-server-*"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "consul_cluster" {
  source = "github.com/hashicorp/terraform-aws-consul//modules/consul-cluster"

  cluster_name = "snowplow-consul-servers"
  # TODO - 5, parameterize
  cluster_size  = 3
  instance_type = "t2.micro"
  # TODO - redundant?
  cluster_tag_key = var.cluster_tag_key
  cluster_tag_value = var.cluster_tag_value

  ami_id = data.aws_ami.consul_server.image_id
  user_data = templatefile("../${path.module}/scripts/server_launch.sh", {
    cluster_tag_key   = var.cluster_tag_key
    cluster_tag_value = var.cluster_tag_value
  })

  vpc_id             = data.aws_vpc.default.id
  availability_zones = data.aws_availability_zones.available.names
  allowed_ssh_cidr_blocks = var.allowed_ssh
  # TODO - lock down
  allowed_inbound_cidr_blocks = ["0.0.0.0/0"]
  ssh_key_name                = var.ssh_key_name
}