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

RUN git clone https://aur.archlinux.org/yay.git

RUN cd yay && makepkg -si --noconfirm

# Install additional packages from AUR if needed
# RUN yay -Sy dotnet-host-bin dotnet-sdk-bin aspnet-runtime-bin --noconfirm

COPY scripts/ .

RUN sudo chmod +x setup_container.sh clone-repo.sh

ENTRYPOINT [ "sleep", "infinity" ]
