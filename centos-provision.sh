#!/bin/sh

yum install -y epel-release

yum install -y \
        git \
        make \
        bison \
        flex \
        gcc \
        ccache \
        gdb \
        wget \
        perl \
        perl-libwww-perl \
        perl-LWP-Protocol-https \
        perl-Digest-SHA \
        python \
        python36 \
        tcl \
        perl-devel \
        perl-ExtUtils-MakeMaker \
        perl-ExtUtils-Embed \
        python-devel \
        python36-devel \
        tcl-devel \
        openssl-devel \
        zlib-devel \
        readline-devel \
        libxml2-devel \
        libxslt-devel \
        openldap-devel \
        krb5-devel \
        gettext \
        perl-IPC-Run \
        perl-Test-Simple \
        valgrind

yum install -y \
	vim \
	emacs-nox
