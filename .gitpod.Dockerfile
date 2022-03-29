FROM gitpod/workspace-full

ARG FB_VERSION=1.09.0
ARG OS_VERSION=ubuntu-20.04
ARG OS_ARCH=x86_64
ARG DOWNLOAD_NAME=FreeBASIC-$FB_VERSION-$OS_VERSION-$OS_ARCH

WORKDIR /tmp/
RUN wget https://sourceforge.net/projects/fbc/files/FreeBASIC-$FB_VERSION/Binaries-Linux/$OS_VERSION/$DOWNLOAD_NAME.tar.gz
RUN tar -xvf $DOWNLOAD_NAME.tar.gz
WORKDIR /tmp/$DOWNLOAD_NAME/
RUN sudo ./install.sh -i 
