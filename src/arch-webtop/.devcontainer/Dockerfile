ARG BASE_IMAGE="lscr.io/linuxserver/webtop:arch-kde"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.title="Arch Linux Desktop (WebTop)"
LABEL org.opencontainers.image.source="https://github.com/zyrakq/arch-devcontainer-templates"
LABEL org.opencontainers.image.description="Arch Linux with desktop environment using LinuxServer.io images"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.authors="Zyrakq <serg.shehov@tutanota.com>"

# Adjust directory permissions
RUN chmod 555 /srv/ftp && \
    chmod 755 /usr/share/polkit-1/rules.d/

# Initialize pacman keyring and upgrade system
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Sy --needed --noconfirm --disable-download-timeout archlinux-keyring && \
    pacman -Su --noconfirm --disable-download-timeout