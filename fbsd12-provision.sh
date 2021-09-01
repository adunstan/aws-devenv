#!/bin/sh

su - <<EOF

id

pkg install -q --fetch-only -y \
	sudo \
	git \
	gmake \
	gcc \
	bison \
	flex \
	emacs-nox \
	wget \
	| egrep -v '^[.]'

pkg install -y \
	sudo \
	git \
	gmake \
	gcc \
	bison \
	flex \
	emacs-nox \
	wget \
    | egrep -v '^[.]'

EOF

wget -q -O ademacs.tgz http://bitbucket.org/adunstan/myemacs/get/master.tar.gz

tar -z -C $HOME --strip-components=1 -xf ademacs.tgz

