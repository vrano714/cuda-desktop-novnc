FROM nvidia/cuda:11.7.0-devel-ubuntu20.04

#ENV LANG C.UTF-8
#ENV LC_ALL C.UTF-8

RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt upgrade -yq && \
    DEBIAN_FRONTEND=noninteractive apt install -yq apt-utils
# I DONT KNOW WHICH ONE IS ESSENTIAL
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -yq --allow-unauthenticated \
    wget curl git build-essential vim sudo zenity xz-utils supervisor \
    lxde dbus-x11 x11-utils alsa-utils mesa-utils libgl1-mesa-dri && \
    DEBIAN_FRONTEND=noninteractive apt install -yq --allow-unauthenticated \
    xvfb x11vnc ttf-ubuntu-font-family fonts-noto-cjk \
    #gtk2-engines-murrine gnome-themes-standard gtk2-engines-pixbuf arc-theme \
    freeglut3-dev libglu1-mesa-dev

# noVNC
RUN mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/novnc/noVNC/tarball/master" | tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/novnc/websockify/tarball/master" | tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

ARG TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

# RUN useradd --create-home --home-dir /home/ubuntu \
#     --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
#     echo ubuntu:ubuntu | chpasswd && \
#     echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# 
# WORKDIR root
# ENV HOME=/home/ubuntu \
#     SHELL=/bin/bash \
#     USER=ubuntu

RUN mv /usr/bin/lxpolkit /usr/bin/lxpolkit.bak

HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/bin/tini", "--"]

COPY desktop.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
