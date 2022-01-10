#!/bin/sh

packages="sudo git gmake gcc bison flex emacs-nox wget ccache screen"
packages="$packages p5-LWP-protocol-https p5-IPC-Run gettext gettext-tools"

su - <<EOF

id

pkg install -q --fetch-only -y $packages | egrep -v '^[.]'

pkg install -q -y $packages | egrep -v '^[.]'

EOF

wget -q -O ademacs.tgz http://bitbucket.org/adunstan/myemacs/get/master.tar.gz

tar -z -C $HOME --strip-components=1 -xf ademacs.tgz

git clone https://github.com/pgbuildfarm/client-code.git bf

echo "bf needs --with-includes=/usr/local/include --with-libs=/usr/local/lib"
