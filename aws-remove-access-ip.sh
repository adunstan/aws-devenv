#!/bin/bash

# need

: ${AWS_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
# : ${AZ:=us-west-2a}
# : ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_REGION AWS_PROFILE

# use arg if given, stripped of CIDR suffix, otherwise use our public address.

MYIP=`echo $1 | sed -e 's,/32,,'`


# publiC IP in case you're behind a firewall
test -z "$MYIP" && MYIP=`dig +short myip.opendns.com @resolver1.opendns.com`

# get the security group id
test -e ./settings && . ./settings

aws ec2 revoke-security-group-ingress --group-id $securityGroupId --protocol tcp --port 22 --cidr $MYIP/32           # SSH
aws ec2 revoke-security-group-ingress --group-id $securityGroupId --protocol tcp --port 3389 --cidr $MYIP/32         # WinRDP
aws ec2 revoke-security-group-ingress --group-id $securityGroupId --protocol tcp --port 5985-5986 --cidr $MYIP/32    # WinRM
aws ec2 revoke-security-group-ingress --group-id $securityGroupId --protocol tcp --port 5432 --cidr $MYIP/32         # PostgreSQL

