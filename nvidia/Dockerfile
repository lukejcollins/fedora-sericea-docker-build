# Use Fedora base image from Quay.io
FROM quay.io/fedora-ostree-desktops/sericea:38

# Add necessary files to the /tmp directory
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/nwg-displays-0.3.3-1.fc38.noarch.rpm /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/sddm-chili.tar /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/wallhaven-7286p3_3840x2160.png /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/swaylock-effects-1.6.4-1.fc36.x86_64.rpm /tmp/

# Run commands
# 1. Update the automatic update policy
# 2. Update sddm configuration
# 3. Modify permissions for the image file
# 4. Enable rpm-ostreed-automatic timer
# 5. Create the chili themes directory and setup theme
# 6. Add --unsupported-gpu to Sway execution for Nvidia
# 7. Install necessary packages and tools
# 8. Remove unnecessary packages
# 9. Clean up and commit the container
RUN sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    sed -i 's/#Current=01-breeze-fedora/Current=chili/' /etc/sddm.conf && \
    sed -i 's|^#ThemeDir=|ThemeDir=|' /etc/sddm.conf && \
    chmod a+r /tmp/wallhaven-7286p3_3840x2160.png && \
    systemctl enable rpm-ostreed-automatic.timer && \
    mkdir -p /usr/share/sddm/themes/chili && \
    tar -xvf /tmp/sddm-chili.tar -C /tmp 2>/dev/null && \
    mv /tmp/chili/* /usr/share/sddm/themes/chili && \
    mv /tmp/wallhaven-7286p3_3840x2160.png /usr/share/sddm/themes/chili/assets/ && \
    sed -i 's/background.jpg/wallhaven-7286p3_3840x2160.png/' /usr/share/sddm/themes/chili/theme.conf && \
    sed -i 's/exec systemd-cat -- \/usr\/bin\/sway $_SWAY_EXTRA_ARGS "$@"/exec systemd-cat -- \/usr\/bin\/sway $_SWAY_EXTRA_ARGS --unsupported-gpu "$@"/' /usr/bin/start-sway && \
    rpm-ostree install qt5-qtquickcontrols qt5-qtgraphicaleffects docker neovim zsh NetworkManager-tui ansible distrobox alacritty lxpolkit wob libfido2 gh swappy /tmp/nwg-displays-0.3.3-1.fc38.noarch.rpm /tmp/swaylock-effects-1.6.4-1.fc36.x86_64.rpm https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    rpm-ostree override remove foot firefox firefox-langpacks kanshi && \
    rpm-ostree cleanup -m && \
    ostree container commit
