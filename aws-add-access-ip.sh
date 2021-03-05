#!/bin/sh

# need

: ${AWS_DEFAULT_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
# : ${AZ:=us-west-2a}
# : ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_DEFAULT_REGION AWS_PROFILE

# use arg if given, otherwise use out public address.

MYIP=$1

# publiC IP in case you're behind a firewall
test -z "$MYIP" && MYIP=`dig +short myip.opendns.com @resolver1.opendns.com`

# get the security group id
test -e ./settings && . ./settings

aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 22 --cidr $MYIP/32           # SSH
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 3389 --cidr $MYIP/32         # WinRDP
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 5985-5986 --cidr $MYIP/32    # WinRM
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 5432 --cidr $MYIP/32         # PostgreSQL

