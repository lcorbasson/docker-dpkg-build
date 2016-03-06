#!/bin/bash
DIR="$(dirname "$0")"
pushd "$DIR"
PKG="$PWD/packages"
sudo docker build -t docker-dpkg-build .
sudo docker run -v "$PKG:/packaging" -it docker-dpkg-build "$@"
popd
ls "$PKG"/*.deb

