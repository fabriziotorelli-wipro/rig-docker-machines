# Eolas/Synapse Test Data provided Bitnami MongoDb

## Goals

Define a ready and data provided docker image for EOLAS/Synapse integration tests.

## Definition

This docker image is based on the original bitnami/mongodb, and it's used in the Buildit rancher catalog Kubernetes Pipeline template.

## Build

You can pull the image from builditftorelli/eolas-mongodb or build it with command :

`docker build --tag `builditftorelli/eolas-mongodb:XXX .` for the default 3.4.2-r1 release or the 3.0 release (refer to the folder for [release 3](/3/eolas-bitnami-mongodb/3))

## Run

Use the following docker commands to run a container for the Docker image :

`docker run -d  -p 27017:27017 -it --name my-mongodb -v /my/volume/path:/bitnami/mongodb builditftorelli/eolas-mongodb:3.4.2-r1`

or

`docker run -d  -p 27017:27017 -it --name my-mongodb -v /my/volume/path:/bitnami/mongodb builditftorelli/eolas-mongodb:3.0`

## Docker Compose

```
version: '2'

services:
  mongodb:
    image: 'builditftorelli/eolas-mongodb:latest'
    ports:
      - "27017:27017"
    volumes:
      - /root/mongo-db/local:/bitnami/mongodb
```

Docker compose file samples:

* [Version 3.4.2-r1](/3/eolas-bitnami-mongodb/docker-compose.yaml)
* [Version 3.0](/3/eolas-bitnami-mongodb/3/docker-compose.yaml)

## RIG technology

RIG is a Buildit concept around the deployment of architectures in the cloud, with a resilient and dynamic approach. RIG is designed to live in any cloud provider. Buildit continuously improve the experience with innovations and sophisticated architectural solutions. In the RIG Rancher Orchestration experience it will available the deployment of multiple cloud providers and multi-purpose platform architectures.

[Buildit](https://buildit.digital/) is a World-Wide Digital Business Transformation company of [Wipro Digital](http://wiprodigital.com/) group.

Take a look at [Buildit](https://buildit.digital/) or [Wipro Digital](http://wiprodigital.com/) web sites for more information.

## What are Eolas and Synapse ?

Eolas and Synapse are respectively Backend and Front-End applications for a project-driven Pipeline Dashboards, collection metrics and providing statistics and graphs on the Development/Release processes, and much more ...

Ask more details to [Paul Karsten - Buildit@WiproDigital](mailto:paul.karsten@wipro.com) - USA

There are other Pipeline Dashboards and Digital Processes available  :

Ask more details to [Glyn Darkin - Buildit@WiproDigital](mailto:glyn.darkin@wipro.com) - Ireland/UK

Buildit Digital consultancy is driven to ensure digital processes for companies. Our exellence centres provide guidelines and methodologies, in order to ensure efficient and proficient Agile / Agile SAFe processes, across multiple disciplines and the entire life-cycle (End-to-End Solutions).

## Issues

Please open any issue on the [Issue Tracker](https://github.com/fabriziotorelli-wipro/rig-docker-machines/issues) with the subject prefix `3-EOLAS-MONGODB:`

## LICENSE

[MIT](/LICENSE)
