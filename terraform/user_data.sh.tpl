#!/bin/sh -ex
# Cloud config for to start an ELK Server

#### ELK Stack Version Configurations
AWS_ACCONT=${aws_account}
AWS_REGION=${aws_region}
AWS_REGION_SHORTNAME=${aws_region_shortname}
BRANCH=${elk_repository_branch}
CLUSTER_NAME=${cluster_name}
DISCOVERY_EC2_GROUPS=${discovery_ec2_groups}
DISCOVERY_ZEN_MINIMUM_MASTER_NODES=${discovery_zen_minimum_master_nodes}
ELK_REPOSITORY_URL="https://github.com/${elk_repository}/archive/$BRANCH.zip"
ENVIRONMENT_NAME=${environment_name}
NETWORK_HOST=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

sed "s/^127.0.0.1.*/127.0.0.1 $ENVIRONMENT_NAME-elk-$AWS_REGION_SHORTNAME01/" /etc/hosts


#### Download Docker ELK Repository
curl -LO "$ELK_REPOSITORY_URL"
unzip "$BRANCH.zip"

#### Configure Elasticsearch
CONFIG_FILE="elk-$BRANCH/elasticsearch/assets/elasticsearch.yml"
sed -i "s/%AWS_REGION%/$AWS_REGION/g" "$CONFIG_FILE"
sed -i "s/%CLUSTER_NAME%/$CLUSTER_NAME/g" "$CONFIG_FILE"
sed -i "s/%DISCOVERY_EC2_GROUPS%/$DISCOVERY_EC2_GROUPS/g" "$CONFIG_FILE"
sed -i "s/%DISCOVERY_ZEN_MINIMUM_MASTER_NODES%/$DISCOVERY_ZEN_MINIMUM_MASTER_NODES/g" "$CONFIG_FILE"
sed -i "s/%NETWORK_HOST%/$NETWORK_HOST/g" "$CONFIG_FILE"

#### Configure Kibana
CONFIG_FILE="elk-$BRANCH/kibana/assets/kibana.yml"
sed -i "s/%NETWORK_HOST%/$NETWORK_HOST/g" "$CONFIG_FILE"

#### Configure Logstash 
CONFIG_FILE="elk-$BRANCH/logstash/assets/logstash.conf"
sed -i "s/%AWS_ACCOUNT%/$AWS_ACCOUNT/g" "$CONFIG_FILE"
sed -i "s/%FLOW_LOG_CLOUDWATCH_LOG_GROUP_ARN%/$FLOW_LOG_CLOUDWATCH_LOG_GROUP_ARN/g" "$CONFIG_FILE"
sed -i "s/%NETWORK_HOST%/$NETWORK_HOST/g" "$CONFIG_FILE"


docker-compose -f elk-$BRANCH/docker-compose.yml pull
docker-compose -f elk-$BRANCH/docker-compose.yml up -d
