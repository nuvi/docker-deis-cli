FROM debian:stretch-slim

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
    awscli \
    && curl -fsSLO https://raw.githubusercontent.com/deis/deis.io/gh-pages/deis-cli/install-v2.sh \
    && bash install-v2.sh $DEIS_WORKFLOW_CLI_VERSION \
    && mv deis /usr/bin/ \
    && rm install-v2.sh \
    && INSTALLED_VERSION="`deis version`" \
    && test "$DEIS_WORKFLOW_CLI_VERSION" = stable \
         -o "$DEIS_WORKFLOW_CLI_VERSION" = "$INSTALLED_VERSION" \
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
