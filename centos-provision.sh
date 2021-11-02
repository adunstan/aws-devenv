#!/bin/sh

yum install -y epel-release

yum install -y snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap

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
	vim

yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

wget -nv -O /home/centos/ademacs.tgz http://bitbucket.org/adunstan/myemacs/get/master.tar.gz

su - centos -c "tar -z --strip-components=1 -xf ademacs.tgz"

snap install emacs --classic 2>/dev/null || { sleep 3; snap install emacs --classic; }

