# Sensu Base
#
# Monitor servers, services, application health, and business KPIs
# This is base image for all Sensu Docker Image

FROM ubuntu:xenial-20160923.1
MAINTAINER Jirayut Nimsaeng <jirayut [at] opsta.io>

# 1) Install Sensu
ARG APT_CACHER_NG
RUN [ -n "$APT_CACHER_NG" ] && \
      echo "Acquire::http::Proxy \"$APT_CACHER_NG\";" \
      > /etc/apt/apt.conf.d/11proxy || true; \
    apt-get update && \
    apt-get install -y wget && \
    wget -q http://repositories.sensuapp.org/apt/pubkey.gpg -O- | apt-key add - && \
    echo "deb http://repositories.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list && \
    apt-get update && \
    apt-get install -y sensu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/11proxy
