#!/bin/sh

apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
        git \
        make \
        bison \
        flex \
        gcc \
        ccache \
        gdb \
        wget \
        perl \
        libwww-perl \
        liblwp-protocol-https-perl \
        python \
        python3 \
        tcl \
        libperl-dev \
        libpython2.7-dev \
        libpython3-dev \
        tcl-dev \
        libssl-dev \
        zlib1g-dev \
        libreadline-dev \
        libgss-dev \
        libxml2-dev \
        libxslt1-dev \
        libldap2-dev \
        libkrb5-dev \
        gettext \
        libipc-run-perl \
		libxml2-utils \
		xsltproc

DEBIAN_FRONTEND=noninteractive apt-get install -y emacs-nox


