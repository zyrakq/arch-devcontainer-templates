FROM archlinux/archlinux:base

ARG USERNAME=vscode
ARG PUID=1000
ARG PGID=1000
ARG HOME=/home/$USERNAME

RUN pacman -Syu --noconfirm

RUN pacman -Sy \
    base-devel \
    git \
    bash \
    sudo \
    openssh \
    --noconfirm

# Create the user
RUN groupadd --gid $PGID $USERNAME \
    && useradd --uid $PUID --gid $PGID -G wheel -s /bin/bash -m -d $HOME -p $USERNAME $USERNAME \
    && echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel \
    && chmod 0440 /etc/sudoers.d/wheel

USER $USERNAME

WORKDIR $HOME

ENTRYPOINT [ "sleep", "infinity" ]
