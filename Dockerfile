# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    kubernetes-deploy
# name:     minddocdev/kubernetes-deploy
# repo:     https://github.com/mind-doc/kubernetes-deploy
# Requires: docker:latest
# authors:  development@minddoc.com
# ------------------------------------------------------

FROM docker:latest
LABEL maintainer="development@minddoc.com"

ENV KUBE_VERSION="v1.11.3"
ENV HELM_VERSION="v2.11.0"

# Dependencies and handy packages for CI pipeline
RUN apk add --no-cache ca-certificates bash git curl

# Binary downloads
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

# Binary Permissions
RUN chmod +x /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/helm

# Install sentry client
RUN curl -sL https://sentry.io/get-cli/ | bash

# Install slack-message script
COPY slack-message.sh /usr/local/bin/slack-message

WORKDIR /config

CMD ["bash"]
