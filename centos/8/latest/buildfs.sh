#!/usr/bin/env bash

set -e
set -u

DIST=centos
DVER=8
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DVER}-${DATE}

rm -rf ${TARGET}
mkdir -p ${TARGET}/etc

cat << END > ${TARGET}/etc/yum.conf
[main]

[BaseOS]
name=CentOS-${DVER} - Base
mirrorlist=http://mirrorlist.centos.org/?release=${DVER}&arch=x86_64&repo=BaseOS
gpgcheck=1
gpgkey=https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official
END

echo "%_dbpath /var/lib/rpm" > ~/.rpmmacros
yum -y --installroot ${TARGET} install bash.x86_64 coreutils.x86_64 dnf rpm.x86_64
echo "[main]" > ${TARGET}/etc/yum.conf
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/yum
rm -rf ${TARGET}/var/lib/yum
tar -cJvf ./rootfs-${DIST}-${DVER}-${DATE}.tar.xz -C ${TARGET} .
