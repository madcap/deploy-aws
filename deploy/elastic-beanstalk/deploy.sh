#!/bin/bash

NEWLINE=$'\n'
VERSION=$1
BUCKET=$2

export AWS_PAGER="cat"

if [[ -z ${VERSION} ]] || [[ -z ${BUCKET} ]]; then
    echo "Usage: ./deploy.sh VERSION BUCKET"
    exit 1
fi

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
cat > options.json <<- EOM
[
  {
    "Namespace": "aws:elasticbeanstalk:application:environment",
    "OptionName": "version",
    "Value": "${VERSION}"
  },
  {
    "Namespace": "aws:elasticbeanstalk:application:environment",
    "OptionName": "environment",
    "Value": "elastic-beanstalk"
  }
]
EOM
aws elasticbeanstalk update-environment --application-name="deploy-aws-elastic-beanstalk" \
  --environment-name="deploy-aws-elastic-beanstalk-environment" --version-label="${VERSION}" \
  --option-settings file://options.json
rm options.json

echo "$NEWLINE### deleting jar file from bucket$NEWLINE"
sleep 1
aws s3 rm s3://${BUCKET}/deploy-aws-0.0.1-SNAPSHOT.jar

echo "$NEWLINE### fetching url of deployed application"
sleep 1
fqdn=$(aws elasticbeanstalk describe-environments --environment-names="deploy-aws-elastic-beanstalk-environment" \
  --query="Environments[0].EndpointURL")
url="http://${fqdn//\"}/"

echo "$NEWLINE### deployment completed, attempting to validate (may take some time)"
for i in 1 2 3 4 5 7 8 9 10
do
  sleep 6
  result=$(curl -s $url)
  if [[ $result == *"\"version\":\"$VERSION\""* ]]; then
    echo "$NEWLINE### application available at: $url"
    exit 0
  fi
done
echo "$NEWLINE### application not responding at: $url"
exit 1
