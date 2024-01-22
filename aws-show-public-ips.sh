#!/bin/bash

# need

: ${AWS_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
# : ${AZ:=us-west-2a}
# : ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_REGION AWS_PROFILE

for f in .vagrant/machines/* ; do
	machine=`basename $f`
	test -e "$f/aws/id" || continue
	id=`cat $f/aws/id`
	echo "$machine: $id"
	aws ec2 describe-instances --instance-ids $id | grep Public | head -n 2
done
