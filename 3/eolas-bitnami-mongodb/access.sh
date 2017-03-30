#!/bin/bash
EXISTS="$(docker ps -a|grep eolas-mongodb)"
if ! [[ -z "$EXISTS" ]]; then
  docker exec -it eolas-mongodb mongod
else
  echo "Container eolas-mongodb not found ..."
fi
