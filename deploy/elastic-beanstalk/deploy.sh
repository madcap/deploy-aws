#!/bin/bash

NEWLINE=$'\n'
VERSION=$1
BUCKET=$2

if [[ -z ${VERSION} ]] || [[ -z ${BUCKET} ]]; then
    echo "Usage: ./deploy.sh VERSION BUCKET"
    exit 1
fi

# TODO - need to figure out how to set environment variables

# TODO - some aws commands produce paginated output when the output is too long

echo "$NEWLINE### deploying version $VERSION using bucket $BUCKET$NEWLINE"
sleep 1

echo "$NEWLINE### performing gradle build$NEWLINE"
sleep 1
../../gradlew build -p ../../

echo "$NEWLINE### uploading jar file to bucket$NEWLINE"
sleep 1
aws s3 mv ../../build/libs/deploy-aws-0.0.1-SNAPSHOT.jar s3://${BUCKET}

echo "$NEWLINE### creating elastic beanstalk environment$NEWLINE"
sleep 1
terraform apply -auto-approve

echo "$NEWLINE### creating application version$NEWLINE"
sleep 1
aws elasticbeanstalk create-application-version --application-name="deploy-aws-elastic-beanstalk" --version-label="${VERSION}" --source-bundle="S3Bucket=${BUCKET},S3Key=deploy-aws-0.0.1-SNAPSHOT.jar"

echo "$NEWLINE### placing application into environment$NEWLINE"
sleep 1
aws elasticbeanstalk update-environment --application-name="deploy-aws-elastic-beanstalk" --environment-name="deploy-aws-elastic-beanstalk-environment" --version-label="${VERSION}"

echo "$NEWLINE### deleting jar file from bucket$NEWLINE"
sleep 1
aws s3 rm s3://${BUCKET}/deploy-aws-0.0.1-SNAPSHOT.jar

echo "$NEWLINE### fetching url of deployed application"
sleep 1
url=$(aws elasticbeanstalk describe-environments --environment-names="deploy-aws-elastic-beanstalk-environment" --query="Environments[0].EndpointURL")

echo "$NEWLINE### deployment completed, waiting for application to become available (may take some time)"
# TODO - actually test if the app is available
sleep 10

echo "$NEWLINE### application available at: ${url//\"}"
sleep 1
