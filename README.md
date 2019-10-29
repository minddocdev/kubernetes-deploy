# Kubernetes deploy docker image

[![Build Status](https://travis-ci.org/minddocdev/kubernetes-deploy.svg?branch=master)](https://travis-ci.org/mind-doc/kubernetes-deploy)

Docker image with docker, helm, helm-gcs, kubectl, gcloud, sentry client and slack webhook script.

This image is useful for deploying Kubernetes applications with `helm` and `kubectl`. Optiona tools like `gcloud`, `sentry-client` and a `slack` push notification are provided. In addition, you can 

The `helm` and `kubectl` command installation is inspired on [dtzar/helm-kubectl](https://github.com/dtzar/helm-kubectl/blob/master/Dockerfile). To reduce image size, the base is `docker`, which is an `alpine` image itself.

Sentry client uses the [automatic installation](https://docs.sentry.io/cli/installation/#automatic-installation). One example use case is [associate commits with a release](https://docs.sentry.io/workflow/releases/#associate-commits-with-a-release).

The Slack message shell script allows you to [send Slack messages](https://api.slack.com/messaging/sending) via [incoming webhooks](https://api.slack.com/incoming-webhooks). You can easily format the payload in [Slack's Block Kit Builder](https://api.slack.com/tools/block-kit-builder).

```
slack-message https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX '{
  "text": "My message"
}'
```

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
