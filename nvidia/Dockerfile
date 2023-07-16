# Use Fedora base image from Quay.io
FROM ghcr.io/lukejcollins/fedora-sericea-docker-build/sericea-custom-build:non-nvidia

RUN sed -i 's/exec systemd-cat -- \/usr\/bin\/sway $_SWAY_EXTRA_ARGS "$@"/exec systemd-cat -- \/usr\/bin\/sway $_SWAY_EXTRA_ARGS --unsupported-gpu "$@"/' /usr/bin/start-sway && \
    rpm-ostree install akmod-nvidia && \
    rpm-ostree cleanup -m && \
    ostree container commit
