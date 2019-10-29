# Kubernetes deploy docker image

[![Build Status](https://travis-ci.org/minddocdev/kubernetes-deploy.svg?branch=master)](https://travis-ci.org/mind-doc/kubernetes-deploy)

Docker image with docker, helm, helm-gcs, kubectl, gcloud, sentry client and slack webhook script.

This image is useful for deploying Kubernetes applications with `helm` and `kubectl`. Optiona tools like `gcloud`, `sentry-client` and a `slack` push notification are provided. In addition, you can 

Sentry client uses the [automatic installation](https://docs.sentry.io/cli/installation/#automatic-installation). One example use case is [associate commits with a release](https://docs.sentry.io/workflow/releases/#associate-commits-with-a-release).

The Slack message shell script allows you to [send Slack messages](https://api.slack.com/messaging/sending) via [incoming webhooks](https://api.slack.com/incoming-webhooks). You can easily format the payload in [Slack's Block Kit Builder](https://api.slack.com/tools/block-kit-builder).

```
slack-message https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX '{
  "text": "My message"
}'
```

## Version specification

See [full tags list](https://cloud.docker.com/u/minddocdev/repository/docker/minddocdev/kubernetes-deploy/tags).

Each docker image tag points to a specific Helm version.

| Git Tag                                                                        | Helm version                                                 | Docker Tags        |
| :----------------------------------------------------------------------------: |:----------------------------------------------------:        | :-----------------:|
| [2.15.1](hhttps://github.com/minddocdev/kubernetes-deploy/releases/tag/2.15.1) | [v2.15.1](https://github.com/helm/helm/releases/tag/v2.15.1) | `2.15.1`, `latest` |
| [2.11.0](https://github.com/minddocdev/kubernetes-deploy/releases/tag/2.11.0)  | [v2.11.0](https://github.com/helm/helm/releases/tag/v2.11.0) | `2.11.0`           |


## Build

```
$ docker build -t minddocdev/kubernetes-deploy .
```

## Run

```
$ docker run -d minddocdev/kubernetes-deploy
```

## Links

* [Docker Hub `minddocdev/kubernetes-deploy`](https://hub.docker.com/r/minddocdev/kubernetes-deploy)
* [GitHub `minddocdev/kubernetes-deploy`](https://github.com/minddocdev/kubernetes-deploy)
