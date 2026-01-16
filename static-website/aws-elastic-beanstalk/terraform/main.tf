resource "aws_elastic_beanstalk_application" "nginx" {
  name        = "nginx-app"
  description = "Static website hosted on Elastic Beanstalk"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket        = "falltrades-nginx-bucket"
  force_destroy = true
}

resource "aws_s3_object" "app_zip" {
  bucket = aws_s3_bucket.app_bucket.id
  key    = "Dockerrun.aws.json"
  source = "${path.module}/files/Dockerrun.zip"
}

resource "aws_elastic_beanstalk_application_version" "app_version" {
  name        = "v1"
  application = aws_elastic_beanstalk_application.nginx.name
  bucket      = aws_s3_bucket.app_bucket.id
  key         = aws_s3_object.app_zip.key
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                = "nginx-env"
  application         = aws_elastic_beanstalk_application.nginx.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.9.1 running Docker"
  version_label       = aws_elastic_beanstalk_application_version.app_version.name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_instance_profile.name
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "1"
  }
}
