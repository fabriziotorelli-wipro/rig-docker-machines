#!/bin/bash
EXISTS="$(docker ps -a|grep eolas-mongodb)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f eolas-mongodb
fi
EXISTS="$(docker ps -a|grep eolas-mongodb-volumes)"
if ! [[ -z "$EXISTS" ]]; then
  docker rm -f eolas-mongodb-volumes
fi
EXISTS="$(docker images -a|grep 'buildit/eolas-mongodb'| grep '3.0')"
if ! [[ -z "$EXISTS" ]]; then
  docker rmi -f builditftorelli/eolas-mongodb:3.0
  docker rmi -f buildit/eolas-mongodb:3.0
fi
if ! [[ -z "$(docker images|grep -v 'IMAGE'|grep -i '<none>')" ]]; then
  docker images|grep -v 'IMAGE'|grep -i '<none>'|awk 'BEGIN {FS=OFS=" "}{print $3}'|xargs docker rmi -f
fi
#rm -f playbook.tgz
#tar -cvzf playbook.tgz playbook
docker build --compress --no-cache --rm --force-rm --tag buildit/eolas-mongodb:3.0 ./
# Usage:	docker load [OPTIONS]
# Load an image from a tar archive or STDIN
# Options:
#       --help           Print usage
#   -i, --input string   Read from tar archive file, instead of STDIN
#   -q, --quiet          Suppress the load output
#
# Usage:	docker save [OPTIONS] IMAGE [IMAGE...]
# Save one or more images to a tar archive (streamed to STDOUT by default)
# Options:
#       --help            Print usage
#   -o, --output string   Write to a file, instead of STDOUT
docker tag buildit/eolas-mongodb:3.0 builditftorelli/eolas-mongodb:3.0
