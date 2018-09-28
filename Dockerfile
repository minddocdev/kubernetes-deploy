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

# Dependencies
RUN apk add --no-cache ca-certificates bash git

# Binary downloads
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

# Binary Permissions
RUN chmod +x /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/helm

WORKDIR /config

CMD bash
