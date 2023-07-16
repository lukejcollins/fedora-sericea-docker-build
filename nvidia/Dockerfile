# Use non-nvidia custom Fedora Sericea base image from this repository
FROM ghcr.io/lukejcollins/fedora-sericea-docker-build/sericea-custom-build:non-nvidia 

# Install rpm-fusion repositories and add --unsupported-gpu parameter to 'exec sway' for Nvidia
RUN sed -i 's/exec systemd-cat -- \/usr\/bin\/sway $_SWAY_EXTRA_ARGS "$@"/exec systemd-cat -- \/usr\/bin\/sway $_SWAY_EXTRA_ARGS --unsupported-gpu "$@"/' /usr/bin/start-sway && \
    rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    rpm-ostree cleanup -m && \
    ostree container commit
