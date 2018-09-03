## --------------------------------
## Variables - VPC
## --------------------------------


variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "azs" {
  type = "list"
  description = "SB Stack Availability zone list"
  default = ["a", "b", "c"]
}

variable "cidr" {
  description = "SB Stack cidr"
  default = "10.51"
}

variable "SubnetConfig" {
  type = "map"
  description = "Subnet Config (CIDR)"
  default = {
    NetworkVPC =  ".0.0/16"
    SubnetPublicNet1 = ".11.0/24"
    SubnetPublicNet2 = ".12.0/24"
    SubnetPublicNet3 = ".13.0/24"
    SubnetPublicNet4 = ".14.0/24"
    SubnetWorkerNet1 = ".31.0/24"
    SubnetWorkerNet2 = ".32.0/24"
    SubnetWorkerNet3 = ".33.0/24"
    SubnetWorkerNet4 = ".34.0/24"
    SubnetDatabaseNet1 = ".41.0/24"
    SubnetDatabaseNet2 = ".42.0/24"
    SubnetDatabaseNet3 = ".43.0/24"
    SubnetDatabaseNet4 = ".44.0/24"
  }
}

variable "name" {
  description = "Stack"
  default = "SB-Stack"
}

variable "stack_name" {
  description = "SB Stack Name"
  default = "WebApp-01"
}

variable "owner" {
  description = "DevOps Owner"
  default = "devops"
}

## --------------------------------
## Variables - RDS
## --------------------------------

variable "instance_types" {
  type = "map"
  description = "Instance Type"
  default = {
    RDS = "db.t2.micro"
  }
}

variable "rds_vars" {
  type = "map"
  description = "RDS related vars"

  default = {
    name = "SB-RDS"
    engine = "mysql"
    engine_version = "5.5.57"
    allocated_storage = "20"
    db_name = "sbappdb"
    master_username = "admin"
    master_password = "dummy"
    multi_az = true
    backup_retention_period = 7
    storage_type = "gp2"
    publicly_accessible = false
  }
}

