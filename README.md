# RIG Docker Images

## Goals

Define a set of docker images for Buildit Pipelines RIG around Rancher Orchestration.

## Definition

This repo concerns any docker images avaialbe in [Docker Hub](https://hub.docker.com/u/builditftorelli/) according to Buildit RIG standards.

## Build

You can pull the image from docker hub at `builditftorelli/<image>` or build it with command :

`docker build --tag builditftorelli/<image>:<version> .`

or running the `build.sh` script in the image folder.

## Run

`docker run -d  -p <public-port>:<container-port> -it --name my-image -v /my/volume/path:/guest/volume/path builditftorelli/<image>:<version>`

## RIG technology

RIG is a Buildit concept around the deployment of architectures in the cloud, with a resilient and dynamic approach. RIG is designed to live in any cloud provider. Buildit continuously improve the experience with innovations and sophisticated architectural solutions. In the RIG Rancher Orchestration experience it will available the deployment of multiple cloud providers and multi-purpose platform architectures.

[Buildit](https://buildit.digital/) is a World-Wide Digital Business Transformation company of [Wipro Digital](http://wiprodigital.com/) group.

Take a look at [Buildit](https://buildit.digital/) or [Wipro Digital](http://wiprodigital.com/) web sites for more information.

## Issues

Please open any issue on the [Issue Tracker](https://github.com/fabriziotorelli-wipro/rig-docker-machines/issues) with the subject prefix `<RIG-VERSION>[-<SECTION-NAME>]-<IMAGE-NAME>:`

## LICENSE

[MIT](/LICENSE)
