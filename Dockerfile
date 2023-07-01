# Use Fedora base image from Quay.io
FROM quay.io/fedora/fedora-sericea:39

# Add necessary files to the /tmp directory
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/nwg-displays-0.3.3-1.fc38.noarch.rpm /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/sddm-chili.tar /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/wallhaven-7286p3_3840x2160.png /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/swaylock-effects-1.6.4-1.fc36.x86_64.rpm /tmp/

# Create fonts folder in /usr/local/share
WORKDIR /usr/localshare
RUN mkdir fonts

# Add fonts to /usr/local/share/fonts
ADD https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf /usr/local/share/fonts/
ADD https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf /usr/local/share/fonts/
ADD https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf /usr/local/share/fonts/
ADD https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf /usr/local/share/fonts/

# Change font perms
RUN chmod 777 /usr/local/share/fonts/MesloLGS\ NF\ *

# Run commands
# 1. Update the automatic update policy
# 2. Update sddm configuration
# 3. Modify permissions for the image file
# 4. Enable rpm-ostreed-automatic timer
# 5. Create the chili themes directory and setup theme
# 6. Install necessary packages and tools
# 7. Remove unnecessary packages
# 8. Clean up and commit the container
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
    rpm-ostree install awscli qt5-qtquickcontrols qt5-qtgraphicaleffects docker vim zsh NetworkManager-tui ansible flatseal distrobox alacritty wob libfido2 gh swappy /tmp/nwg-displays-0.3.3-1.fc38.noarch.rpm /tmp/swaylock-effects-1.6.4-1.fc36.x86_64.rpm && \
    rpm-ostree override remove foot firefox firefox-langpacks kanshi && \
    rpm-ostree cleanup -m && \
    ostree container commit
