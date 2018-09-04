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

variable "environment" {
  description = "Environment"
  default = "dev"
}

variable "owner" {
  description = "DevOps Owner"
  default = "devops"
}

## --------------------------------
## Variables - RDS
## --------------------------------

variable "rds_instance_type" {
  description = "RDS Instance Type"
  default = "db.t2.micro"
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

## --------------------------------
## Variables - EB
## --------------------------------

variable "ws_instance_type" {
  description = "WebServer Instance Type"
  default = "t2.micro"
}

variable "minsize" {
  description = "MinSize"
  default = "2"
}

variable "maxsize" {
  description = "maxsize"
  default = "3"
}

variable "service_role" {
  description = "ServiceRole"
  default = "AWSServiceRoleForElasticBeanstalk"
}

variable "iam_instance_prof" {
  description = "IamInstanceProfile"
  default = "aws-elasticbeanstalk-ec2-role"
}

variable "document_root" {
  description = "Document Root"
  default = ""
}

variable "max_batch_size" {
  description = "MaxBatchSize"
  default = "1"
}
