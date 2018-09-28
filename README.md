# Kubernetes deploy docker image

[![Build Status](https://travis-ci.org/mind-doc/kubernetes-deploy.svg?branch=master)](https://travis-ci.org/mind-doc/kubernetes-deploy)

Docker container with helm, kubectl and docker commands support.
Helm and kubectl are adapted from [dtzar/helm-kubectl](https://github.com/dtzar/helm-kubectl/blob/master/Dockerfile), over the `docker/latest` layer.

This image is useful for running `docker` commands to build and publish an image, while applying it to a Kubernetes cluster, in the same lightweight alpine docker container.

## Build

```
$ docker build -t minddocdev/kubernetes-deploy .
```

## Run

```
$ docker run -d minddocdev/kubernetes-deploy
```

## Configuration

You can define the following environment variables
