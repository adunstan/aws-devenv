#!/bin/sh


# basic build environment for msys2, for 64bit # and 32bit builds (nope)

pacman -S --needed --noconfirm \
	base-devel \
	msys/git \
	msys/ccache \
	msys/vim \
	msys/emacs \
	msys/perl-Crypt-SSLeay \
	mingw-w64-x86_64-toolchain # 	mingw-w64-i686-toolchain # no 32 bit thanks

# could do: pacman -S --needed --noconfirm development
# this is more economical. These should cover most of the things you might
# want to configure with

pacman -S --needed --noconfirm \
	   msys/gettext-devel \
	   msys/icu-devel \
	   msys/libiconv-devel \
	   msys/libreadline-devel \
	   msys/libxml2-devel \
	   msys/libxslt-devel \
	   msys/openssl-devel \
	   msys/zlib-devel

echo alias vi=vim >> ~/.bashrc
echo export EDITOR=vim >> ~/.bashrc
echo export LESS=-iMx4R >> ~/.bashrc

echo "shopt -s histappend" >> ~/.bashrc

# my emacs/vi setup
# comment out if not wanted
wget -q -O ademacs.tgz https://bitbucket.org/adunstan/myemacs/get/master.tar.gz
tar -z -xf ademacs.tgz --strip-components=1 --exclude=README.md

# For other tool chains, pick from
# https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/
#
# or see http://winlibs.com/
#
# wget https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/7.3.0/threads-win32/sjlj/x86_64-7.3.0-release-win32-sjlj-rt_v5-rev0.7z/download#"


# buildfarm client stuff

mkdir bf

cd bf

mkdir root

wget --no-verbose https://buildfarm.postgresql.org/downloads/latest-client.tgz

tar -z --strip-components=1 -xf latest-client.tgz

cp build-farm.conf.sample testit64.conf


# with correctly set MSYSTEM and MSYSTEM_CHOST (or MSYSTEM_CHOST 
# completely unset) use of --with-template=win32 is not required.
# Here we set MSYSTEM_CHOST correctly because the buildfarm doesn't
# provide a convenient way to unset ENV variables.

sed -i \
	-e '/MSVC setup/,/^[}]/d' \
	-e 's/CHANGEME/testit64/' \
	-e '/--with-[^ ][^ ]*/d'  \
	-e '/--enable-nls/ a\
            --with-openssl\
       ' \
	-e 's!build_root =>.*!build_root => "/home/Administrator/bf/root",!' \
	-e 's/use_vpath[ ]*=>.*/use_vpath => 1,/' \
	-e '/modules/ s/TestUpgrade//' \
	-e '/build_env/ a\
               \
               PATH => "/mingw64/bin:/usr/bin/vendor_perl:$ENV{PATH}",\
               PERL5LIB => "/home/Administrator/bf/p5lib",\
       ' \
	-e '/config_env/ a\
               \
               MSYSTEM => "MINGW64",\
               MSYSTEM_CHOST => "x86_64-w64-mingw32",\
       ' \
	testit64.conf

cp testit64.conf testit32.conf

sed -i \
	-e 's/testit64/testit32/' \
	-e '/PATH/ s/mingw64/mingw32/' \
	-e '/MSYSTEM/ s/MINGW64/MINGW32/' \
	-e '/MSYSTEM_CHOST/ s/x86_64/i686/' \
	testit32.conf

# required for TAP tests. 
tar -z -xf /c/vfiles/windows-uploads/IPC-Run-Win-0.94.tgz
