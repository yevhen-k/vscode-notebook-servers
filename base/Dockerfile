# Use the respective Makefile to build the image.
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# common environemnt variables
ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_PREFIX /
ENV HOME /home/$NB_USER
ENV SHELL /bin/bash

# args - software versions
ARG KUBECTL_ARCH="amd64"
ARG KUBECTL_VERSION=v1.21.0
# renovate: datasource=github-tags depName=just-containers/s6-overlay versioning=loose
# https://github.com/just-containers/s6-overlay/releases
# ARG S6_ARCH=x86_64
# ARG S6_VERSION=v3.1.5.0

# set shell to bash
SHELL ["/bin/bash", "-c"]

# install - usefull linux packages
RUN export DEBIAN_FRONTEND=noninteractive \
   && apt-get -yq update \
   && apt-get -yq install --no-install-recommends \
   apt-transport-https \
   bash \
   bzip2 \
   ca-certificates \
   curl \
   git \
   gnupg \
   gnupg2 \
   htop \
   locales \
   lsb-release \
   nano \
   ncdu \
   nvtop \
   python3-venv \
   python3-pip \
   software-properties-common \
   sudo \
   tzdata \
   unzip \
   vim \
   wget \
   xz-utils \
   zip \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

# install - s6 overlay
# Add S6 supervisor (for graceful stop)
# RUN curl -sL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz" -o "/tmp/s6-overlay-noarch.tar.xz"
# RUN curl -sL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz" -o "/tmp/s6-overlay-${S6_ARCH}.tar.xz"
# RUN curl -sL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz.sha256" -o "/tmp/s6-overlay-noarch.tar.xz.sha256"
# RUN curl -sL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz.sha256" -o "/tmp/s6-overlay-${S6_ARCH}.tar.xz.sha256"

# RUN cd /tmp && sha256sum -c s6-overlay-noarch.tar.xz.sha256
# RUN cd /tmp && sha256sum -c s6-overlay-${S6_ARCH}.tar.xz.sha256

# RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
#    && tar -C / -Jxpf /tmp/s6-overlay-${S6_ARCH}.tar.xz \
#    && rm -rf /tmp/*

# install - kubectl
RUN curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl" -o /usr/local/bin/kubectl \
   && curl -sL "https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl.sha256" -o /tmp/kubectl.sha256 \
   && echo "$(cat /tmp/kubectl.sha256) /usr/local/bin/kubectl" | sha256sum --check \
   && rm /tmp/kubectl.sha256 \
   && chmod +x /usr/local/bin/kubectl

# create user and set required ownership
RUN useradd -M -s /bin/bash -N -u ${NB_UID} ${NB_USER} \
   && echo ${NB_USER}:${NB_USER} | chpasswd \
   && adduser ${NB_USER} sudo \
   && mkdir -p ${HOME} \
   && chown -R ${NB_USER}:users ${HOME} \
   && chown -R ${NB_USER}:users /usr/local/bin
# && chown -R ${NB_USER}:users /etc/s6-overlay

# set locale configs
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
   && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER $NB_UID

