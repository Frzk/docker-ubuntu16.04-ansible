# Build Ubuntu 16.04 (Xenial) image.

FROM ubuntu:16.04
LABEL maintainer="François KUBLER"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libssl-dev \
    python3-pip \
    systemd \
    tzdata \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip \
 && python3 -m pip install --upgrade setuptools \
 && python3 -m pip install wheel ansible molecule[docker,lint]

RUN mkdir -p /etc/ansible
ADD hosts /etc/ansible/

ENV ANSIBLE_FORCE_COLOR 1

ENTRYPOINT ["/lib/systemd/systemd"]
