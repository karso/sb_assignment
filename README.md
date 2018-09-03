# SafeBoda Assignment

Design and provision a highly available and scalable architecture that hosts a PHP application using AWS.


### Prerequisites

Terraform v0.11.3 or above


```
https://www.terraform.io/intro/getting-started/install.html
```

## Deployment

* Clone the repo
* Get into terraform directory
* Run (type 'yes' when prompted)
	`terraform init`
	`terraform plan -var-file=terraform.values -out=terraform.plan`
	`terraform apply -var-file=terraform.values -state=terraform.state`
* Once the execution completes, lof into AWS console and browse to ElasticBeanstalk
* Upload and deploy the application zip file found in 'appdir'

## Author
Soumitra Kar

## Acknowledgments
AWS resources
