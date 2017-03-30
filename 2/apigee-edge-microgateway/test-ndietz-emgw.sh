#!/bin/bash
EXISTS="$(docker ps -a|grep apigee-ndietz-emgw)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f apigee-ndietz-emgw
fi
# --cap-add SYS_ADMIN --security-opt seccomp:unconfined
#--privileged -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup
#docker run -d  -p 8080:8080 -p 50000:50000 --privileged -e "PLUGINS_TEXT_FILE_URL=https://github.com/fabriziotorelli-wipro/ansible-machines/raw/master/jenkins-ansible/plugins.txt" -e "PRIVATE_PUBLIC_KEY_TAR_URL=https://github.com/fabriziotorelli-wipro/ansible-machines/raw/master/jenkins-ansible/keys.tar" -e "container=docker" --cap-add SYS_ADMIN --security-opt seccomp:unconfined -v /sys/fs/cgroup:/sys/fs/cgroup -it --name jenkins-ansible buildit/jenkins-ansible:2.32.3
EDGEMICRO_ORG="buildittech"
EDGEMICRO_ENV="test"
EDGEMICRO_USER="fabrizio.torelli@wipro.com"
EDGEMICRO_PASS="@!BiXiUs1975!@"
EDGEMICRO_KEY="XmjrALpsHTGAJXlOojhTCzQWgluoktwZ"
EDGEMICRO_SECRET="GmUFTzaA3GTBAg4I"
docker run -d  -p 8000:8000 -e "EDGEMICRO_ORG=$EDGEMICRO_ORG" -e "EDGEMICRO_ENV=$EDGEMICRO_ENV" \
          -e "EDGEMICRO_KEY=$EDGEMICRO_KEY" \
          -e "EDGEMICRO_SECRET=$EDGEMICRO_SECRET" -e "container=docker" \
          -it --name apigee-ndietz-emgw ndietz/emgw
docker logs -f apigee-ndietz-emgw
