FROM docker.io/bitnami/minideb:bullseye
ENV HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-11" \
    OS_NAME="linux"

LABEL org.opencontainers.image.authors="https://bitnami.com/contact" \
      org.opencontainers.image.description="Application packaged by Bitnami" \
      org.opencontainers.image.ref.name="1.24.0-debian-11-r32" \
      org.opencontainers.image.source="https://github.com/bitnami/containers/tree/main/bitnami/cluster-autoscaler" \
      org.opencontainers.image.title="cluster-autoscaler" \
      org.opencontainers.image.vendor="VMware, Inc." \
      org.opencontainers.image.version="1.24.0"

COPY prebuildfs /
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Install required system packages and dependencies
RUN install_packages ca-certificates curl gzip procps tar
RUN mkdir -p /tmp/bitnami/pkg/cache/ && cd /tmp/bitnami/pkg/cache/ && \
    if [ ! -f cluster-autoscaler-1.24.0-153-linux-amd64-debian-11.tar.gz ]; then \
      curl -SsLf https://downloads.bitnami.com/files/stacksmith/cluster-autoscaler-1.24.0-153-linux-amd64-debian-11.tar.gz -O ; \
    fi && \
    echo "3572431aa3a5e287ee968e8dadd92d0bd15a1936e174c787bd85ca8870d350ab  cluster-autoscaler-1.24.0-153-linux-amd64-debian-11.tar.gz" | sha256sum -c - && \
    tar -zxf cluster-autoscaler-1.24.0-153-linux-amd64-debian-11.tar.gz -C /opt/bitnami --strip-components=2 --no-same-owner --wildcards '*/files' && \
    rm -rf cluster-autoscaler-1.24.0-153-linux-amd64-debian-11.tar.gz
RUN apt-get update && apt-get upgrade -y && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami
RUN ln -sf /opt/bitnami/cluster-autoscaler/bin/cluster-autoscaler /opt/bitnami/cluster-autoscaler/cluster-autoscaler

COPY rootfs /
RUN chmod -R g+rwX /opt/bitnami/cluster-autoscaler/
ENV APP_VERSION="1.24.0" \
    BITNAMI_APP_NAME="cluster-autoscaler" \
    PATH="/opt/bitnami/cluster-autoscaler/bin:$PATH"

WORKDIR /opt/bitnami/cluster-autoscaler
USER 1001
CMD [ "/run.sh" ]
