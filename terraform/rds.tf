## --------------------------------
## DB Instance -> (SB) RDS
## --------------------------------

resource "aws_db_subnet_group" "RDSDBSubnetGroup" {
  description = "RDS DB Subnet Group"
  subnet_ids  = ["${module.vpc.database_subnets}"]

  tags {
    Name            = "${lookup(var.rds_vars, "name")}"
    EnvironmentName = "${var.environment}"
    Owner           = "${var.owner}"
  }
}

resource "aws_db_parameter_group" "SBRDSParamGroup" {
  family      = "mysql5.5"
  description = "Database Parameter Group"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }
}

resource "aws_db_instance" "SBRDS" {
  depends_on              = [
    "aws_db_subnet_group.RDSDBSubnetGroup",
    "aws_db_parameter_group.SBRDSParamGroup",]
  identifier              = "${lower(var.stack_name)}"
  allocated_storage       = "${lookup(var.rds_vars, "allocated_storage")}"
  engine                  = "${lookup(var.rds_vars, "engine")}"
  engine_version          = "${lookup(var.rds_vars, "engine_version")}"
  instance_class          = "${lookup(var.instance_types, "RDS")}"
  multi_az                = "${lookup(var.rds_vars, "multi_az")}"
  name                    = "${lookup(var.rds_vars, "db_name")}"
  username                = "${lookup(var.rds_vars, "master_username")}"
  password                = "${lookup(var.rds_vars, "master_password")}"
  vpc_security_group_ids  = ["${aws_security_group.SecurityGroupWideOpen.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.RDSDBSubnetGroup.id}"
  parameter_group_name    = "${aws_db_parameter_group.SBRDSParamGroup.id}"
  backup_retention_period = "${lookup(var.rds_vars, "backup_retention_period")}"
  storage_type            = "${lookup(var.rds_vars, "storage_type")}"
  publicly_accessible     = "${lookup(var.rds_vars, "publicly_accessible")}"
  skip_final_snapshot     = true

  tags {
    Name            = "${lookup(var.rds_vars, "name")}"
    EnvironmentName = "${var.environment}"
    Owner           = "${var.owner}"
  }
}

