## --------------------------------
## EB Application
## --------------------------------

resource "aws_elastic_beanstalk_application" "sb-web-app" {
  name = "sb-web-app"
}

## --------------------------------
## EB Environment
## --------------------------------

resource "aws_elastic_beanstalk_environment" "sb-web-app-env" {
  name = "sb-web-app-env"
  application = "sb-web-app"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.8.1 running PHP 7.2 "
  cname_prefix = "sb-webapp"
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = "${module.vpc.vpc_id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "true"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = "${join(",", module.vpc.private_subnets)}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${join(",", module.vpc.public_subnets)}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "external"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 3"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "2"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "5"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value   = "AWSServiceRoleForElasticBeanstalk"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "environment"
    value = "${var.environment}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "LOGGING_APPENDER"
    value = "GRAYLOG"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MinInstancesInService"
    value = "2"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MaxBatchSize"
    value = "1"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Fixed"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "1"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "DeploymentPolicy"
    value = "Rolling"
  }
  setting {
    namespace = "aws:elb:policies"
    name = "ConnectionDrainingEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.SecurityGroupWideOpen.id}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:php:phpini"
    name      = "document_root"
    value     = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_USERNAME"
    value = "${lookup(var.rds_vars, "master_username")}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_PASSWORD"
    value = "${lookup(var.rds_vars, "master_password")}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_DB_NAME"
    value = "sbdb"
    value = "${lookup(var.rds_vars, "db_name")}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_HOSTNAME"
    value = "${aws_db_instance.SBRDS.address}"
}
  tags {
    Team = "SB"
    Environment = "Dev"
  }
}
