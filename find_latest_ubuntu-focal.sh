

: ${AWS_DEFAULT_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
: ${AZ:=us-west-2a}
: ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_DEFAULT_REGION AWS_PROFILE # AZ KEY


aws ec2 describe-images \
	--owners 099720109477 \
	--filters \
	    Name=name,Values='ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64*' \
	    Name=architecture,Values=x86_64 \
		Name=root-device-type,Values=ebs \
	--query 'sort_by(Images, &Name)[-1].ImageId' \
	--output text
