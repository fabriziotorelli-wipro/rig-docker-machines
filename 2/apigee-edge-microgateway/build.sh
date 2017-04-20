#!/bin/bash
EXISTS="$(docker ps -a|grep apigee-edge-micro)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f apigee-edge-micro
fi
EXISTS="$(docker images|grep 'buildit/apigee-edge-micro')"
if ! [[ -z "$EXISTS" ]]; then
  docker rmi -f builditftorelli/apigee-edge-micro:2.3.5
  docker rmi -f buildit/apigee-edge-micro:2.3.5
fi
if ! [[ -z "$(docker images|grep -v 'IMAGE'|grep -i '<none>')" ]]; then
  docker images|grep -v 'IMAGE'|grep -i '<none>'|awk 'BEGIN {FS=OFS=" "}{print $3}'|xargs docker rmi -f
fi
#rm -f playbook.tgz
#tar -cvzf playbook.tgz playbook
docker build --compress --no-cache --rm --force-rm --tag buildit/apigee-edge-micro:2.3.5 ./
EXISTS="$(docker images|grep 'buildit/apigee-edge-micro')"
if ! [[ -z "$EXISTS"  ]]; then
  docker tag buildit/apigee-edge-micro:2.3.5 builditftorelli/apigee-edge-micro:2.3.5
  # docker push builditftorelli/apigee-edge-micro:2.3.5
fi
