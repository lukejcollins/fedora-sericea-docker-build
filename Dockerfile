FROM quay.io/fedora/fedora-sericea:39

COPY nwg-displays-0.3.3-1.fc38.noarch.rpm /tmp/
ADD https://github-fedora-sericea-config-files-2023.s3.eu-west-2.amazonaws.com/sddm-chili.tar /tmp/

RUN sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    sed -i 's/#Current=01-breeze-fedora/Current=chili/' /etc/sddm.conf && \
    sed -i 's|^#ThemeDir=|ThemeDir=|' /etc/sddm.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    mkdir -p /usr/share/sddm/themes/chili && \
    tar -xvf /tmp/sddm-chili.tar -C /tmp 2>/dev/null && \
    mv /tmp/chili/* /usr/share/sddm/themes/chili && \
    rpm-ostree install awscli && \
    rpm-ostree install qt5-qtquickcontrols && \
    rpm-ostree install qt5-qtgraphicaleffects && \
    rpm-ostree override remove foot && \
    rpm-ostree override remove firefox firefox-langpacks && \
    rpm-ostree override remove kanshi && \
    rpm-ostree install docker && \
    rpm-ostree install vim && \
    rpm-ostree install zsh && \
    rpm-ostree install NetworkManager-tui && \
    rpm-ostree install ansible && \
    rpm-ostree install flatseal && \
    rpm-ostree install distrobox && \
    rpm-ostree install alacritty && \
    rpm-ostree install /tmp/nwg-displays-0.3.3-1.fc38.noarch.rpm && \
    rpm-ostree install wob && \
    rpm-ostree install libu2f-host && \
    rpm-ostree install gh && \
    rpm-ostree install swappy && \
    rpm-ostree cleanup -m && \
    ostree container commit
