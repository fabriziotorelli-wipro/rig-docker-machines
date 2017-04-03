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

Copyright (c) 2016-2017 [BuildIt, Inc.](http://buildit.digital)

Licensed under the [MIT](/LICENSE) License (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[https://opensource.org/licenses/MIT](https://opensource.org/licenses/MIT)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
