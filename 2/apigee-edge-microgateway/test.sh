#!/bin/bash
EXISTS="$(docker ps -a|grep apigee-edge-micro)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f apigee-edge-micro
fi
EDGEMICRO_ORG="buildittech"
EDGEMICRO_ENV="prod"
EDGEMICRO_USER="fabrizio.torelli@wipro.com"
EDGEMICRO_PASS="@!BiXiUs1975!@"
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
