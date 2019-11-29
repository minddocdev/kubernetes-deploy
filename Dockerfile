# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    kubernetes-deploy
# name:     minddocdev/kubernetes-deploy
# repo:     https://github.com/minddocdev/kubernetes-deploy
# Requires: docker:19.03
# authors:  development@minddoc.com
# ------------------------------------------------------

FROM docker:19.03
LABEL maintainer="development@minddoc.com"

ENV HELM_VERSION="v3.0.0"

# Dependencies and handy packages for CI pipeline
RUN apk add --no-cache bash ca-certificates curl git gnupg jq python tar wget

# Install gcloud and kubectl
RUN wget \
  -q https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip \
  && unzip google-cloud-sdk.zip \
  && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh \
  --usage-reporting=true \
  --path-update=true \
  --bash-completion=true \
  --rc-path=/.bashrc \
  --additional-components app kubectl alpha beta
RUN google-cloud-sdk/bin/gcloud config set \
  --installation component_manager/disable_update_check true
RUN ln -s /google-cloud-sdk/bin/gcloud /usr/bin/gcloud
RUN ln -s /google-cloud-sdk/bin/kubectl /usr/bin/kubectl

# Install helm
RUN wget https://keybase.io/bacongobbler/pgp_keys.asc -O - | gpg --import
RUN wget -q https://github.com/helm/helm/releases/download/${HELM_VERSION}/helm-${HELM_VERSION}-linux-amd64.tar.gz.asc
RUN wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
RUN gpg --verify helm-${HELM_VERSION}-linux-amd64.tar.gz.asc helm-${HELM_VERSION}-linux-amd64.tar.gz &&\
  rm helm-${HELM_VERSION}-linux-amd64.tar.gz.asc
RUN tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz &&\
  rm helm-${HELM_VERSION}-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
RUN chmod +x /usr/local/bin/helm
RUN helm plugin install https://github.com/hayorov/helm-gcs

# Install sentry client
RUN curl -sL https://sentry.io/get-cli/ | bash

# Install slack-message script
COPY slack-message.sh /usr/local/bin/slack-message

WORKDIR /config

CMD ["bash"]
