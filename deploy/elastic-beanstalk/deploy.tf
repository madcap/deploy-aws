
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_elastic_beanstalk_application" "deploy-aws-elastic-beanstalk" {
  name        = "deploy-aws-elastic-beanstalk"
  description = "example deploying app to elastic beanstalk"
}

resource "aws_elastic_beanstalk_environment" "deploy-aws-elastic-beanstalk-environment" {
  name                = "deploy-aws-elastic-beanstalk-environment"
  application         = aws_elastic_beanstalk_application.deploy-aws-elastic-beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2 v3.0.1 running Corretto 11"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "version"
    value     = "none"
  }

    setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "environment"
      value     = "none"
    }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }
}