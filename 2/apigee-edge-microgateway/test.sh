#!/bin/bash
EXISTS="$(docker ps -a|grep apigee-edge-micro)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f apigee-edge-micro
fi
# --cap-add SYS_ADMIN --security-opt seccomp:unconfined
#--privileged -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup
#docker run -d  -p 8080:8080 -p 50000:50000 --privileged -e "PLUGINS_TEXT_FILE_URL=https://github.com/fabriziotorelli-wipro/ansible-machines/raw/master/jenkins-ansible/plugins.txt" -e "PRIVATE_PUBLIC_KEY_TAR_URL=https://github.com/fabriziotorelli-wipro/ansible-machines/raw/master/jenkins-ansible/keys.tar" -e "container=docker" --cap-add SYS_ADMIN --security-opt seccomp:unconfined -v /sys/fs/cgroup:/sys/fs/cgroup -it --name jenkins-ansible buildit/jenkins-ansible:2.32.3
EDGEMICRO_ORG="buildittech"
EDGEMICRO_ENV="prod"
EDGEMICRO_USER="fabrizio.torelli@wipro.com"
EDGEMICRO_PASS="@!BiXiUs1975!@"
# EDGEMICRO_KEY="c2aqN1cdxo4LjfePGQNy5zZ0sZfAiWyK"
# EDGEMICRO_SECRET="q8reufQ4ugz8pAZA"
EDGEMICRO_CONSUMER_CREDENTIALS="yLNKurL0Desq865nMXvEDh5NXI76o5mB:BEGWzrw4qj2ep0nR"
EDGEMICRO_PRIVATE_CLOUD="no"
EDGEMICRO_ROUTER="http://buildittech-prod.apigee.net"
EDGEMICRO_API_MNGMT="http://buildittech-prod.apigee.net"
docker run -d  -p 8000:8000 -e "EDGEMICRO_ORG=$EDGEMICRO_ORG" -e "EDGEMICRO_ENV=$EDGEMICRO_ENV" \
          -e "EDGEMICRO_USER=$EDGEMICRO_USER" -e "EDGEMICRO_PASS=$EDGEMICRO_PASS" -e "container=docker" \
          -e "EDGEMICRO_CONSUMER_CREDENTIALS=$EDGEMICRO_CONSUMER_CREDENTIALS" -e "EDGEMICRO_PRIVATE_CLOUD=$EDGEMICRO_PRIVATE_CLOUD" \
          -e "EDGEMICRO_ROUTER=$EDGEMICRO_ROUTER" -e "EDGEMICRO_API_MNGMT=$EDGEMICRO_API_MNGMT" \
          -it --name apigee-edge-micro builditftorelli/apigee-edge-micro:2.3.5
docker logs -f apigee-edge-micro
# -e "EDGEMICRO_KEY=$EDGEMICRO_KEY"  -e "EDGEMICRO_SECRET=$EDGEMICRO_SECRET" \
