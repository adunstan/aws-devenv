#!/bin/bash

set -e -x

source myenv
source settings

DB=testpgl-amd
PW=blurfl964
REPLPW=splog1fy.x
SGS=$securityGroupId
export AWS_REGION=$REGION
export AWS_PROFILE

command -v psql > /dev/null
if [ $? = 0 ]
then
   echo psql not found in PATH
   exit 1
fi

aws rds create-db-parameter-group --db-parameter-group-name $DB \
    --db-parameter-group-family postgres15 \
    --description "parameter group for $DB"

aws rds modify-db-parameter-group --db-parameter-group-name $DB \
    --parameters "ParameterName=rds.logical_replication,ParameterValue=1,ApplyMethod=pending-reboot" \
    'ParameterName=shared_preload_libraries,ParameterValue="pg_stat_statements,pglogical",ApplyMethod=pending-reboot'
    
aws rds create-db-instance \
    --engine postgres \
    --engine-version 15 \
    --master-username testmaster \
    --master-user-password $PW \
    --publicly-accessible \
    --allocated-storage 5 \
    --db-parameter-group-name $DB \
	--db-subnet-group-name default-$vpcId \
    --vpc-security-group-ids $SGS \
    --db-instance-class  db.t3.micro \
    --db-instance-identifier $DB

aws rds wait db-instance-available --db-instance-identifier $DB

ADDR=`aws rds describe-db-instances --db-instance-id $DB \
    --query DBInstances[*].Endpoint.Address --output text`

CSTR="host=$ADDR dbname=postgres password=$PW user=testmaster port=5432"

psql -d "$CSTR" -c "create database repltest"

psql -d "$CSTR" -c "create extension pglogical"

psql -d "$CSTR" -c "create user postgres"

psql -d "$CSTR" -c "grant rds_superuser to postgres"

rm -rf /tmp/pagila
git clone https://github.com/devrimgunduz/pagila.git /tmp/pagila

CSTR="host=$ADDR dbname=repltest password=$PW user=testmaster port=5432"

psql -d "$CSTR" -q -f /tmp/pagila/pagila-schema.sql

for f in 1 2 3 4 5 6 ; do
    psql -q -d "$CSTR" \
	 -c "alter table payment_p2017_0$f add primary key(payment_id)"
done

psql -d "$CSTR" -c "create user repluser"

psql -d "$CSTR" -c "grant rds_replication to repluser"

psql -d "$CSTR" -c "alter user repluser password \$\$$REPLPW\$\$"

psql -d "$CSTR"
     -c "select pglogical.create_node( 
          node_name => 'subscriber-1',
	  dsn => 'host=$ADDR dbname=repltest user=repluser password=$REPLPW')"

psql -d "$CSTR" \
     -c "select pglogical.create_subscription( 
          subscription_name := 'subscription_1',
	  provider_dsn := 'host=$instanceUrl dbname=repltest user=repluser password=$REPLPW')"

# to delete do something like
# aws rds delete-db-instance --db-instance-identifier testpgl-amd \
    # --skip-final-snapshot
# aws rds delete-db-parameter-group --db-parameter-group-name testpgl-amd


