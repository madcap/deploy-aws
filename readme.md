
## Deploying to AWS

This project provides a simple java web application and examples of several mechanisms for automating deployment to AWS.

### Setup

#### Prerequisites

The following prerequisites are outside of the scope of this example but are required:

* have an AWS account
* have a shell environment
* installed the AWS cli
* have a working java/groovy environment
* can run the gradle build
* installed terraform cli
* ability to make .sh files executable

#### S3 Bucket

You'll need to be able to upload your jar file to an S3 bucket. Since bucket names are globally unique it will just be referred to as BUCKET.

Create an S3 bucket that you'll use. Copy the name of the bucket for later, use it anywhere you see BUCKET.

#### IAM User/Group

On the AWS Console navigate to IAM and create a new group `Terraform-example` with the following policy types:
* `AWSElasticBeanstalkFullAccess`
* `AmazonS3FullAccess`

On the AWS Console navigate to IAM and create a new user `Terraform-example`.
* enable programmatic access
* add user to group `Terraform-example`
* retrieve access key and secret key after creating the user
* run `aws configure` entering the new access key and secret key

### Host in Elastic Beanstalk

TODO

