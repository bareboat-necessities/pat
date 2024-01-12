#!/bin/bash -e

CONTAINER_DISTRO=$1

echo "deb http://deb.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/deb-backports.list

apt-get update  -y -q
apt-get install -y -q wget xz-utils gnupg ca-certificates
apt-get upgrade -y -q

apt-get -y install devscripts/bookworm-backports debhelper-compat \
  build-essential lintian \
  golang/bookworm-backports golang-go/bookworm-backports \
  golang-doc/bookworm-backports golang-src/bookworm-backports libax25 libax25-dev

./make.bash libax25

dpkg-buildpackage -b -uc -us -j8

