#!/bin/bash

# need

: ${AWS_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
# : ${AZ:=us-west-2a}
# : ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_REGION AWS_PROFILE

# get the security group id
test -e ./settings && . ./settings
echo -e "              \tDescription\tGroupId\tGroupName\tOwnerId\tVpcId"
aws ec2 describe-security-groups --group-ids $securityGroupId --output text

