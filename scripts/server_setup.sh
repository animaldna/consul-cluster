#!/bin/bash
set -e
git clone --branch v0.11.0 https://github.com/hashicorp/terraform-aws-consul.git
terraform-aws-consul/modules/install-consul/install-consul --version 1.11.3