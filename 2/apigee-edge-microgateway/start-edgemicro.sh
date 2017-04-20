#!/bin/bash
echo "Checking  APIGEE Edge Microgateway ... "
if  [ -z "$EDGEMICRO_ORG" ] ||  [ -z "$EDGEMICRO_ENV" ] ; then
  echo "No Organization and/or Environment provided in environment variables ..."
  exit 1
fi

if  [ -z "$EDGEMICRO_USER" ] ||  [ -z "$EDGEMICRO_PASS" ]; then
  echo "No User, Password, Auth Key, and/or Auth Secret provided in environment variables ..."
  exit 1
fi

if ! [ -e /root/.edgemicro/.config_out ]; then

  echo "Init APIGEE Edge Microgateway ... "
  edgemicro init

  echo "APIGEE Edge Microgateway - ORG: $EDGEMICRO_ORG"
  echo "APIGEE Edge Microgateway - ENV: $EDGEMICRO_ENV"
  echo "APIGEE Edge Microgateway - USER: $EDGEMICRO_USER"
  echo "APIGEE Edge Microgateway - PASSWORD: (Password...)"


  # echo "Using key  : $EDGEMICRO_KEY"
  # echo "Using secret  : $EDGEMICRO_SECRET"
  echo ""
  echo ""
  if [[ "yes" == "$EDGEMICRO_PRIVATE_CLOUD" ]] && ! [[ -z "$EDGEMICRO_API_MNGMT" ]] && ! [[ -z "$EDGEMICRO_ROUTER" ]]; then
    echo "Configuring Private APIGEE Edge Microgateway ..."
    edgemicro private configure -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -u $EDGEMICRO_USER -p $EDGEMICRO_PASS -r $EDGEMICRO_ROUTER -m $EDGEMICRO_API_MNGMT > /root/.edgemicro/.config_out
    chmod 777 /root/.edgemicro/.config_out
    cat /root/.edgemicro/.config_out
    if [[ -z "$(cat /root/.edgemicro/.config_out| grep '  secret: ')" ]] || [[ -z "$(cat /root/.edgemicro/.config_out| grep '  key: ')" ]]; then
      echo "Replay, probably it should donwload products from revisions ...."
      edgemicro private configure -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -u $EDGEMICRO_USER -p $EDGEMICRO_PASS -r $EDGEMICRO_ROUTER -m $EDGEMICRO_API_MNGMT > /root/.edgemicro/.config_out
    fi
  else
    echo "Configuring APIGEE Edge Microgateway ... "
    edgemicro configure -d -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -u $EDGEMICRO_USER -p $EDGEMICRO_PASS > /root/.edgemicro/.config_out
    chmod 777 /root/.edgemicro/.config_out
    cat /root/.edgemicro/.config_out
    if [[ -z "$(cat /root/.edgemicro/.config_out| grep '  secret: ')" ]] || [[ -z "$(cat /root/.edgemicro/.config_out| grep '  key: ')" ]]; then
      echo "Replay, probably it should donwload products from revisions ...."
      edgemicro configure -d -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -u $EDGEMICRO_USER -p $EDGEMICRO_PASS > /root/.edgemicro/.config_out
    fi
  fi
  echo ""
  echo ""
  echo "Assigning APIGEE extra variables ..."
  echo ""
  echo ""
  EDGEMICRO_KEY="$(tail -n 4 /root/.edgemicro/.config_out | grep '  key: '|sed 's/  key: //g')"
  EDGEMICRO_SECRET="$(tail -n 4 /root/.edgemicro/.config_out | grep '  secret: '|sed 's/  secret: //g')"
  echo "Defining server certificate ...."
  mkdir -p /root/.ssh
  chmod 666 /root/.ssh
  cat /root/.edgemicro/.config_out | sed 's/.*-----BEGIN CERTIFICATE-----/-----BEGIN CERTIFICATE-----/g'|awk '/-----BEGIN CERTIFICATE-----/{i++}i'|awk '/-----END CERTIFICATE----/{exit}1' > /root/.ssh/cert.pem && \
  echo '-----END CERTIFICATE-----' >> /root/.ssh/cert.pem && \
  echo "key: $EDGEMICRO_KEY" > /root/.edgemicro/edge-keys && \
  echo "secret: $EDGEMICRO_SECRET" >> /root/.edgemicro/edge-keys
else
  echo ""
  echo ""
  echo "APIGEE Edge Microgateway already initialized, now proceeding with start-up ..."
  EDGEMICRO_KEY="$(tail -n 4 /root/.edgemicro/.config_out | grep '  key: '|sed 's/  key: //g')"
  EDGEMICRO_SECRET="$(tail -n 4 /root/.edgemicro/.config_out | grep '  secret: '|sed 's/  secret: //g')"
fi

# echo ""
# echo ""
# echo "Generating APIGEE Edge Microgateway Internal Use keys ..."
# edgemicro genkeys -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -u $EDGEMICRO_USER -p $EDGEMICRO_PASS
if ! [ -e /root/.edgemicro/$EDGEMICRO_ORG-$EDGEMICRO_ENV-env.list ]; then
  echo ""
  echo ""
  echo "Verifying APIGEE Edge Microgateway connectivity ..."
  edgemicro verify -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -k $EDGEMICRO_KEY -s $EDGEMICRO_SECRET
  echo ""
  echo ""
  echo "Starting APIGEE Edge Microgateway ..."
  cat /root/template/env.list | sed "s/<org>/$EDGEMICRO_ORG/g" | sed "s/<env>/$EDGEMICRO_ENV/g"  | \
      sed "s/<key>/$EDGEMICRO_KEY/g" | sed "s/<secret>/$EDGEMICRO_SECRET/g" > /root/.edgemicro/$EDGEMICRO_ORG-$EDGEMICRO_ENV-env.list
else
  echo ""
  echo ""
  echo "Starting APIGEE Edge Microgateway ..."
fi

edgemicro start -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -k $EDGEMICRO_KEY -s $EDGEMICRO_SECRET > /root/.watchfile 2>&1 &

if ! [ -e /root/.edgemicro/.app_tokens ]; then
  mkdir -p /root/.edgemicro/.app_tokens
  chmod 644 /root/.edgemicro/.app_tokens
  if ! [[ -z "$EDGEMICRO_CONSUMER_CREDENTIALS" ]]; then
    echo "Getting authorization tokens ..."
    IFS=',' ; for i in $EDGEMICRO_CONSUMER_CREDENTIALS ; do
    CONSUMER_KEY=""
    CONSUMER_SECRET=""
      IFS=':'; for j in $i; do
        if [[ -z "$CONSUMER_KEY" ]]; then
          CONSUMER_KEY=$j;
        else
         CONSUMER_SECRET=$j;
        fi
      done;
      if ! [[ -z "$CONSUMER_KEY" ]] && ! [[ -z "$CONSUMER_SECRET" ]]; then
        echo "Getting authorization token for credentials : key=$CONSUMER_KEY, secret=$CONSUMER_SECRET"
        edgemicro token get -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -i $CONSUMER_KEY -s $CONSUMER_SECRET > /root/.edgemicro/.app_tokens/$CONSUMER_KEY-$CONSUMER_SECRET.json 2>&1
        #cat /root/.edgemicro/.app_tokens/$CONSUMER_KEY-$CONSUMER_SECRET.json | grep 'token:' > /root/.edgemicro/.app_tokens/$CONSUMER_KEY-$CONSUMER_SECRET.json
        cat /root/.edgemicro/.app_tokens/$CONSUMER_KEY-$CONSUMER_SECRET.json
      else
        echo "Invalid credentials : key=$CONSUMER_KEY, secret=$CONSUMER_SECRET"
      fi
    done
  fi
else
  echo "Showing authorization tokens ..."
  ls -l /root/.edgemicro/.app_tokens/ | grep 'json' | awk 'BEGIN {FS=OFS=" "}{print $9}'| xargs cat /root/.edgemicro/.app_tokens/
fi

echo "Creating development tar you can download ..."
cd /root
if [ -e /root/dev-pack.tgz ]; then
  rm -f /root/dev-pack.tgz
fi
tar -cvzf dev-pack.tgz .ssh/cert.pem .edgemicro/.app_tokens .edgemicro/edge-keys .edgemicro/$EDGEMICRO_ORG-$EDGEMICRO_ENV-env.list .edgemicro/.config_out > /dev/null 2>&1
echo "Get development pack wuth docker copy command : docker cp <CONTAINER>:/root/dev-pack.tgz <MY-LOCAL-FOLDER>/myfilename.tgz"

echo ""
echo "Done!!"
echo "Access services to activate logs ..."
touch /root/.watchfile
chmod 777 /root/.watchfile
while [[ -z "$(cat /root/.watchfile|grep 'logging to ')" ]]; do
  sleep 20;
  if [[ -z "$(cat /root/.watchfile|grep 'PROCESS PID : ')" ]]; then
    echo "Unable to detect the APIGEE Edge Microgateway start-up ... exiting"
    exit 1
  fi
done
cat /root/.watchfile
tail -f "$(cat /root/.watchfile|grep 'logging to '|sed 's/logging to //g')"
