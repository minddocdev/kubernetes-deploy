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

ENV HELM_VERSION="v2.15.1"

# Dependencies and handy packages for CI pipeline
RUN apk add --no-cache bash ca-certificates curl git jq python tar wget

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
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# Install helm
RUN wget \
  -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
  -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm
RUN chmod +x /usr/local/bin/helm
RUN helm init --client-only
RUN helm plugin install https://github.com/hayorov/helm-gcs

# Install sentry client
RUN curl -sL https://sentry.io/get-cli/ | bash

# Install slack-message script
COPY slack-message.sh /usr/local/bin/slack-message

WORKDIR /config

CMD ["bash"]
