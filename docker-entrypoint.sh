#!/bin/bash
set -e

[ $# -gt 0 ] && su packaging -c 'apt-get source "$@"' -- - "$@"
for p in *.dsc; do
	dpkg-source -x "$p"
done
for d in *; do
	if [ -d "$d" ]; then
		pushd "$d"
		if [ -e "debian/control" ]; then
			mk-build-deps -i -r -t "apt-get --force-yes -y" "debian/control"
		else
			mk-build-deps -i -r -t "apt-get --force-yes -y" "$d"
		fi
		su packaging -c 'dpkg-buildpackage -rfakeroot -us -uc'
		popd
	fi
done

