# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    kubernetes-deploy
# name:     minddocdev/kubernetes-deploy
# repo:     https://github.com/minddocdev/kubernetes-deploy
# Requires: alpine/helm:3.5.3
# authors:  development@minddoc.com
# ------------------------------------------------------

FROM alpine/helm:3.5.3
LABEL maintainer="development@minddoc.com"

# Dependencies and handy packages for CI pipeline
RUN apk add --update --no-cache bash ca-certificates curl git gnupg jq python3 tar wget

# Install gcloud
RUN wget \
  -q https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip \
  && unzip google-cloud-sdk.zip \
  && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh \
  --usage-reporting=true \
  --path-update=true \
  --bash-completion=true \
  --rc-path=/.bashrc \
  --additional-components app alpha beta
RUN google-cloud-sdk/bin/gcloud config set \
  --installation component_manager/disable_update_check true
RUN ln -s /google-cloud-sdk/bin/gcloud /usr/bin/gcloud

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \ 
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/bin/kubectl

# Install helm plugins
RUN helm plugin install https://github.com/hayorov/helm-gcs

# Install sentry client
RUN curl -sL https://sentry.io/get-cli/ | bash

# Install slack-message script
COPY slack-message.sh /usr/local/bin/slack-message

WORKDIR /config

CMD ["bash"]
