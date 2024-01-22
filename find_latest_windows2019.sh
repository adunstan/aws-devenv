
: ${AWS_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
: ${AZ:=us-west-2a}
: ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_REGION AWS_PROFILE # AZ KEY

aws ec2 describe-images \
	--owners 801119661308 \
	--filters \
	    Name=name,Values='Windows_Server-2019-English-Full-Base*' \
	    Name=architecture,Values=x86_64 \
	    Name=root-device-type,Values=ebs \
	--query 'sort_by(Images, &Name)[-1].ImageId' \
	--output text
