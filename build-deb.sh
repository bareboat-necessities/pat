#!/bin/bash -e

CONTAINER_DISTRO=$1

echo "deb http://deb.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/deb-backports.list

apt-get update  -y -q
apt-get install -y -q wget xz-utils gnupg ca-certificates
apt-get upgrade -y -q

apt-get -y install devscripts/bullseye-backports debhelper-compat \
  build-essential lintian \
  golang/bullseye-backports golang-go/bullseye-backports \
  golang-doc/bullseye-backports golang-src/bullseye-backports libax25 libax25-dev

./make.bash libax25

dpkg-buildpackage -b -uc -us -j8

