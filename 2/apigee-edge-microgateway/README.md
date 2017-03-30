# Apigee Edge Microgateway for Docker

## Goals

Run your Apigee Edge Microgateway Apps and Proxies in a Docker container, easily and in a full automated process. No manual steps are needed, no token recovery. Provide your organization, environment, credential, and the public or provate network flag and the container will make all you need to access your Apigee edge environment.

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

## RIG technology

RIG is a Buildit concept around the deployment of architectures in the cloud, with a resilient and dynamic approach. RIG is designed to live in any cloud provider. Buildit continuously improve the experience with innovations and sophisticated architectural solutions. In the RIG Rancher Orchestration experience it will available the deployment of multiple cloud providers and multi-purpose platform architectures.

[Buildit](https://buildit.digital/) is a World-Wide Digital Business Transformation company of [Wipro Digital](http://wiprodigital.com/) group. 

Take a look at [Buildit](https://buildit.digital/) or [Wipro Digital](http://wiprodigital.com/) web sites for more information.

## Issues

Please report any issue on the [Issue Tracker](https://github.com/fabriziotorelli-wipro/rig-docker-machines/issues) with prefix `2-EDGEMICRO:`

## License

[Apache License, Version 2.0](/2/apigee-edge-microgateway/LICENSE)
