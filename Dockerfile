FROM debian:stretch-slim

## Not Used anymore, grabbing latest stable
ARG DEIS_WORKFLOW_CLI_VERSION=v2.18.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    bash \
    curl \ 
    git \
    jq \ 
    openssh-client \
    sudo \
    openssl \
    wget \
    python-pip \
    python-setuptools \
    && pip install awscli --upgrade \
    && curl -o deis https://storage.googleapis.com/workflow-cli-release/deis-stable-linux-amd64 \
    && chmod +x deis \
    && mv deis /usr/bin/ \
    && INSTALLED_VERSION="`deis version`" \
    && set -x \
    && VER="17.03.0-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && mv /tmp/docker/* /usr/bin \
    && wget https://cli-assets.heroku.com/branches/stable/heroku-linux-amd64.tar.gz \
    && sudo mkdir -p /usr/local/lib /usr/local/bin \
    && sudo mkdir -p /usr/local/lib /usr/local/bin \
    && sudo tar -xvzf heroku-linux-amd64.tar.gz -C /usr/local/lib \
    && sudo ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku \
    && sudo rm heroku-linux-amd64.tar.gz \
    && rm -rf /var/lib/apt/lists/*

CMD ["deis"]
