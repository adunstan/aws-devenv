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

apt install curl ca-certificates gnupg
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
apt update

