# Apigee Edge Microgateway for Docker

* Run your Apigee Edge Microgateway instances in Docker containers.

## Build the image

This step is optional.  You can pull this image directly from Docker Hub.

```
docker build -t buildit/apigee-edge-micro:2.3.5 .
```

## Configure edgemicro

### Step 1: Set environment variables related to your deployment

Set `EDGEMICRO_USER` and `EDGEMICRO_PASS` equal to your Apigee user and password.
If this variable isn't set, you'll fail the start-up ...

```
export EDGEMICRO_ORG=ws-poc1
export EDGEMICRO_ENV=test
export EDGEMICRO_USER=myapigeeemai@google.com
export EDGEMICRO_PASS=mysecret
```

## Step 2: Running edgemicro


This step will generate config files in the config directory and output additional variables and run the apigee context to the specified configuration [an optional variable execute the private cloud as administrator only : EDGEMICRO_PRIVATE_CLOUD="yes"].


```
$ docker run -d -p 8080:8000 \
  -v $EDGEMICRO_DIR:/root/.edgemicro \
  -e "EDGEMICRO_ORG=$EDGEMICRO_ORG" \
  -e "EDGEMICRO_ENV=$EDGEMICRO_ENV" \
  -e "EDGEMICRO_USER=$EDGEMICRO_USER" \
  -e "EDGEMICRO_PASS=$EDGEMICRO_PASS" \
  buildit/apigee-edge-micro:2.3.5
```

## Testing it out

```
  curl http://localhost:8080/basepath
```

## License

[Apache License, Version 2.0](/LICENSE.md)
