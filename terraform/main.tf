## --------------------------------
## Provider - AWS
## --------------------------------

provider "aws" {
  region = "${var.region}"
  version = "1.13.0"
}

provider "template" {
  version = "1.0.0"
}

provider "null" {
  version = "1.0.0"
}

# Declare the data source
# data "aws_caller_identity" "current" {}


## --------------------------------
## Locals variable
## --------------------------------

locals {
  azs = "${format("%s%s", var.region, var.azs[0])},${format("%s%s", var.region, var.azs[1])},${format("%s%s", var.region, var.azs[2])}"
  public_subnets = "${var.cidr}${lookup(var.SubnetConfig, "SubnetPublicNet1")},${var.cidr}${lookup(var.SubnetConfig, "SubnetPublicNet2")},${var.cidr}${lookup(var.SubnetConfig, "SubnetPublicNet3")}"
  private_subnets = "${var.cidr}${lookup(var.SubnetConfig, "SubnetWorkerNet1")},${var.cidr}${lookup(var.SubnetConfig, "SubnetWorkerNet2")},${var.cidr}${lookup(var.SubnetConfig, "SubnetWorkerNet3")}"
  database_subnets = "${var.cidr}${lookup(var.SubnetConfig, "SubnetDatabaseNet1")},${var.cidr}${lookup(var.SubnetConfig, "SubnetDatabaseNet2")},${var.cidr}${lookup(var.SubnetConfig, "SubnetDatabaseNet3")}"
}


## --------------------------------
## VPC
## --------------------------------

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  version                      = "1.26.0"
  name                         = "${var.name}"
  cidr                         = "${format("%s%s", var.cidr, lookup(var.SubnetConfig, "NetworkVPC"))}"
  azs                          = "${split(",", local.azs )}"
  public_subnets               = "${split(",", local.public_subnets )}"
  private_subnets              = "${split(",", local.private_subnets )}"
  database_subnets             = "${split(",", local.database_subnets )}"
  enable_dns_support           = true
  enable_dns_hostnames         = true
  create_database_subnet_group = false
  enable_nat_gateway           = true
  enable_vpn_gateway           = false
  enable_s3_endpoint           = true

  tags = {
    # buildnumber     = "${var.build_num}"
    Name            = "${var.name}"
    EnvironmentName = "${var.stack_name}"
    Owner           = "${var.owner}"
  }
}

## --------------------------------
## Network ACL
## --------------------------------

resource "aws_network_acl" "network_acl" {
  vpc_id = "${module.vpc.vpc_id}"
  subnet_ids = ["${module.vpc.database_subnets}"]
}

resource "aws_network_acl_rule" "inbound_network_acl" {
  network_acl_id = "${aws_network_acl.network_acl.id}"
  rule_number    = 102
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1
  to_port        = 65535
}

resource "aws_network_acl_rule" "outbound_network_acl" {
  network_acl_id = "${aws_network_acl.network_acl.id}"
  rule_number    = 102
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1
  to_port        = 65535
}
