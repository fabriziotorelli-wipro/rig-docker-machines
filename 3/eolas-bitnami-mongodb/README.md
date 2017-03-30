# Eolas Test Data provided Bitnami MongoDb

## Scope

Define a ready and data provided docker image for EOLAS/Synapse integration test.

## Definition

This docker image is based on the original bitnami/mongodb, and it's used in the Buildit rancher catalog Kubernetes Pipiline template.

## Build

You can pull the image from builditftorelli/eolas-mongodb or build it with command :

`docker build --tag `builditftorelli/eolas-mongodb:XXX .` for the default 3.4.2-r1 release or the 3 release (refer to the folder for [release 3](/3/eolas-bitnami-mongodb/3))

## Run

docker run -d  -p 27017:27017 -it --name my-mongodb -v /my/volume/path:/bitnami/mongodb builditftorelli/eolas-mongodb:3.4.2-r1

or

docker run -d  -p 27017:27017 -it --name my-mongodb -v /my/volume/path:/bitnami/mongodb builditftorelli/eolas-mongodb:3

## Issues

Please open any issue on the [Issue Tracker](https://github.com/fabriziotorelli-wipro/rig-docker-machines/issues) with the subject prefix `EOLAS-MONGODB:`

##LICENSE

[MIT](/LICENSE)
