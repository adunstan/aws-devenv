

pacman -S --needed --noconfirm \
	   git \
	   bison \
	   flex \
	   make \
	   diffutils \
	   perl-LWP-Protocol-https \
	   ucrt64/mingw-w64-ucrt-x86_64-perl \
	   ucrt64/mingw-w64-ucrt-x86_64-gcc \
	   ucrt64/mingw-w64-ucrt-x86_64-zlib \
	   ucrt64/mingw-w64-ucrt-x86_64-ccache \
	   ucrt64/mingw-w64-ucrt-x86_64-tools-git

# do these next two export steps so you don't need to relogin

export PATH=/ucrt64/bin:/ucrt64/bin/site_perl/5.32.1:/ucrt64/bin/vendor_perl:/ucrt64/bin/core_perl:$PATH

export MSYSTEM=UCRT64 \
	   MINGW_CHOST=x86_64-w64-mingw32 \
	   MSYSTEM_CARCH=x86_64 \
	   MINGW_PACKAGE_PREFIX=mingw-w64-ucrt-x86_64 \
	   MSYSTEM_CHOST=x86_64-w64-mingw32 \
	   MSYSTEM_PREFIX=/ucrt64

# or:
# export MSYSTEM=UCRT64; . /etc/msystem

# install IPC::Run
echo installing IPC::Run
(echo y; echo o conf recommends_policy 0; echo notest install IPC::Run) | cpan 

echo fixing prove script
# force ucrt64 prove to use the ucrt64 perl rather than whatever is in the path
sed -i 's,^#!perl,#!/ucrt64/bin/perl,' /ucrt64/bin/core_perl/prove

: <<EOF

echo exiting
exit

mkdir /c/dev
cd /c/dev
git clone https://git.postgresql.org/git/postgresql.git postgres-mingw
cd /c/dev/postgres-mingw

mkdir build

cd build

../configure --without-readline --cache cache --enable-tap-tests PROVE=/ucrt64/bin/core_perl/prove PERL=/ucrt64/bin/perl.exe CC="ccache gcc"
make -j8 -s world-bin && make -j8 -s -C src/interfaces/ecpg/test

make -s -j8 temp-install

mkdir /c/dev/postgres-mingw/build/tmp

(make -Otarget -j12 check-world NO_TEMP_INSTALL=1 PG_TEST_USE_UNIX_SOCKETS=1 TMPDIR=C:/dev/postgres-mingw/build/tmp TAR="C:\Windows\System32\tar.exe" 2>&1 && echo test-world-success || echo test-world-fail) 2>&1 |tee test-world.log

EOF

echo done.
