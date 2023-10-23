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

# s6 - copy scripts
# COPY --chown=jovyan:users s6/ /etc
# COPY --chmod=755 etc/s6-overlay /etc/s6-overlay

USER $NB_UID

EXPOSE 8888

# ENTRYPOINT ["/init"]

CMD [ "/usr/bin/code-server", "--bind-addr", "0.0.0.0:8888", "--disable-telemetry", "--auth", "none" ]
