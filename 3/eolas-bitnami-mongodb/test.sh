#!/bin/bash
EXISTS="$(docker ps -a|grep eolas-mongodb)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f eolas-mongodb
fi
EXISTS="$(docker ps -a|grep eolas-mongodb-volumes)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f eolas-mongodb-volumes
fi
docker run -d  -it --name eolas-mongodb-volumes builditftorelli/eolas-mongodb:3.4.2-r1 echo "I am just a volume source!!"
docker run -d  -p 27017:27017 -it --name eolas-mongodb --volumes-from eolas-mongodb-volumes builditftorelli/eolas-mongodb:3.4.2-r1
docker logs -f eolas-mongodb
