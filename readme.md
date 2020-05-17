
## Deploying to AWS

This project provides a simple java web application and examples of several mechanisms for automating deployment to AWS.

### About the Java App

The java application in this project is a simple Spring Boot application with 3 endpoints:
* GET /
* POST /echo
* GET /echo

One of the goals of the java app is to demonstrate that environment variables are set correctly as part of the deployment process so each response includes environment variables: 
* environment
* version

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
* installed AWS eksctl cli
* installed kubectl

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

#### Deploy

Deploy the java app to AWS Elastic Beanstalk. 
* VERSION is a user specified version of the application. 
* BUCKET is your S3 bucket name.

From the proejct root:
```
$ cd deploy/elastic-beanstalk
$ ./deploy.sh VERSION BUCKET

(wait aproximately 3 min for deployment to complete) 

### application available at: awseb-e-2-AWSEBLoa-8X3APKDJETSI-713510636.us-east-1.elb.amazonaws.com
$
```

Validate that the application was deployed by visiting the public url found at the output

#### Destroy
From the proejct root:
```
$ cd deploy/elastic-beanstalk
$ ./destroy.sh

(wait aproximately 3 min for destruction to complete) 
$
```

### Host in Elastic Kubernetes Service

Pending