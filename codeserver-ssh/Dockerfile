# Use the respective Makefile to pass the appropriate BASE_IMG and build the image correctly
ARG BASE_IMG=<base>
FROM $BASE_IMG

USER root

# args - software versions
# renovate: datasource=github-tags depName=cdr/code-server versioning=semver
ARG CODESERVER_VERSION=v4.18.0
ARG CODESERVER_ARCH=amd64

# install - code-server
RUN curl -sL "https://github.com/cdr/code-server/releases/download/${CODESERVER_VERSION}/code-server_${CODESERVER_VERSION/v/}_${CODESERVER_ARCH}.deb" -o /tmp/code-server.deb \
    && dpkg -i /tmp/code-server.deb \
    && rm -f /tmp/code-server.deb

# configure ssh
#password for user login
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


USER $NB_UID

EXPOSE 22
EXPOSE 8888

# ["/usr/sbin/sshd", "-D"]
# sudo /etc/init.d/ssh start
CMD [ "/bin/bash", "-C",  "/usr/bin/code-server --bind-addr 0.0.0.0:8888 --disable-telemetry --auth none"]