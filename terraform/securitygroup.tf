## --------------------------------
## Security Groups - RDS
## --------------------------------

resource "aws_security_group" "SecurityGroupWideOpen" {
  name = "SecurityGroupWideOpen"
  description = "An open SG acessible within the VPC"
  vpc_id = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port     = 0
    to_port         = 0
    protocol      = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name            = "SGRDS"
    EnvironmentName = "${var.stack_name}"
    Owner           = "${var.owner}"
  }
}
