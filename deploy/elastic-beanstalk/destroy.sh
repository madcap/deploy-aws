#!/bin/bash

NEWLINE=$'\n'

echo "$NEWLINE### destroying deploy-aws-elastic-beanstalk environment and applications$NEWLINE"
sleep 1
terraform destroy -auto-approve

echo "$NEWLINE### verify applications were deleted$NEWLINE"
sleep 1
aws elasticbeanstalk describe-applications

echo "$NEWLINE### application removed"
sleep 1