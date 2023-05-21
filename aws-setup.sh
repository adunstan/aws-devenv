
# need

: ${AWS_DEFAULT_REGION:=us-west-2}
: ${AWS_PROFILE:=devenv}
: ${AZ:=us-west-2a}
: ${KEY:=ad-devenv}

test -e ./myenv && . ./myenv

export AWS_DEFAULT_REGION AWS_PROFILE AZ KEY

# publiC IP in case you're behind a firewall
MYIP=`dig +short myip.opendns.com @resolver1.opendns.com`

vpcId=`aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text`

echo vpcId=\"$vpcId\" | tee settings

aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-hostnames "{\"Value\":true}"

internetGatewayId=`aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text`
aws ec2 attach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId

echo internetGatewayId=\"$internetGatewayId\" | tee -a settings

subnetId=`aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.0.0/24 --availability-zone $AZ --query 'Subnet.SubnetId' --output text`
subnetId2=`aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.10.0/24 --availability-zone $AZ2 --query 'Subnet.SubnetId' --output text`

echo subnetId=\"$subnetId\" | tee -a settings
echo subnetId2=\"$subnetId2\" | tee -a settings

routeTableId=`aws ec2 create-route-table --vpc-id $vpcId --query 'RouteTable.RouteTableId' --output text`
echo routeTableId=\"$routeTableId\" | tee -a settings

associationId=`aws ec2 associate-route-table --route-table-id $routeTableId --subnet-id $subnetId --query 'AssociationId' --output text`
associationId2=`aws ec2 associate-route-table --route-table-id $routeTableId --subnet-id $subnetId2 --query 'AssociationId' --output text`
echo associationId=\"$associationId\" | tee -a settings
echo associationId2=\"$associationId2\" | tee -a settings

aws ec2 create-route --route-table-id $routeTableId --destination-cidr-block 0.0.0.0/0 --gateway-id $internetGatewayId > /dev/null

securityGroupId=`aws ec2 create-security-group --group-name my-security-group --description "my-security-group" --vpc-id $vpcId --query 'GroupId' --output text`
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 22        --cidr $MYIP/32    # SSH
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 3389      --cidr $MYIP/32    # WinRDP
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 5985-5986 --cidr $MYIP/32    # WinRM
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol tcp --port 5432      --cidr $MYIP/32    # PostgreSQL
aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol -1                   --cidr 10.0.0.0/16 # local network connections

echo securityGroupId=\"$securityGroupId\" | tee -a settings

if [ ! -e ~/.ssh/$KEY.pem ]
then
   aws ec2 create-key-pair --key-name $KEY --query 'KeyMaterial' --output text > ~/.ssh/$KEY.pem
   chmod 400 ~/.ssh/$KEY.pem
fi
