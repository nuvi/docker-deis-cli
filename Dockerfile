FROM alpine:3.4

ARG DEIS_WORKFLOW_CLI_VERSION=v2.18.0
RUN apk add --no-cache bash curl git jq openssh-client sudo aws-cli \
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
 && mv /tmp/docker/* /usr/bin

CMD ["deis"]
