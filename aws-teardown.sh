
# need

: ${AWS_DEFAULT_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
: ${AZ:=us-west-2a}
: ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_DEFAULT_REGION AWS_PROFILE AZ KEY

test -e ./settings && . ./settings


# TODO: check the object exist before we try to delete them
# For now, just ignore an error for a missing object

if [ X$securityGroupId != X ]
then
	aws ec2 delete-security-group --group-id $securityGroupId || true
fi

if [ X$associationId != X ]
then
	aws ec2 disassociate-route-table --association-id $associationId || true
fi 

if [ X$routeTableId != X ]
then
	aws ec2 delete-route-table --route-table-id $routeTableId || true
fi

if [ X$subnetId != X ]
then
	aws ec2 delete-subnet --subnet-id $subnetId || true
fi

if [ X$internetGatewayId != X ]
then
	# assume vpcId exists
	aws ec2 detach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId || true
	aws ec2 delete-internet-gateway --internet-gateway-id $internetGatewayId || true
fi

if [ X$vpcId != X ]
then
	aws ec2 delete-vpc --vpc-id $vpcId || true
fi
