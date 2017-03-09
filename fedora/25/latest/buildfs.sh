#!/usr/bin/env bash

set -e
set -u

DIST=fedora
DVER=25
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DVER}-${DATE}

rm -rf ${TARGET}
mkdir -p ${TARGET}/etc

cat << END > ${TARGET}/etc/yum.conf
[main]

[fedora]
name=fedora
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-${DVER}&arch=x86_64
gpgkey=https://getfedora.org/static/FDB19C98.txt
gpgcheck=1

[updates]
name=updates
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f${DVER}&arch=x86_64
gpgkey=https://getfedora.org/static/FDB19C98.txt
gpgcheck=1
END

echo "%_dbpath /var/lib/rpm" > ~/.rpmmacros
yum -y --installroot ${TARGET} install bash coreutils dnf rpm
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/yum
rm -rf ${TARGET}/var/lib/yum
tar -cJvf ./rootfs-${DIST}-${DVER}-${DATE}.tar.xz -C ${TARGET} .
