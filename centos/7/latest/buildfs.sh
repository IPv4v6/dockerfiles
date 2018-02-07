#!/usr/bin/env bash

set -e
set -u

DIST=centos
DVER=7
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DVER}-${DATE}

rm -rf ${TARGET}
mkdir -p ${TARGET}/etc

cat << END > ${TARGET}/etc/yum.conf
[main]

[base]
name=CentOS-${DVER} - Base
mirrorlist=http://mirrorlist.centos.org/?release=${DVER}&arch=x86_64&repo=os
gpgcheck=1
gpgkey=https://www.centos.org/keys/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-${DVER} - Updates
mirrorlist=http://mirrorlist.centos.org/?release=${DVER}&arch=x86_64&repo=updates
gpgcheck=1
gpgkey=https://www.centos.org/keys/RPM-GPG-KEY-CentOS-7
END

echo "%_dbpath /var/lib/rpm" > ~/.rpmmacros
yum -y --installroot ${TARGET} install bash coreutils yum rpm
echo "[main]" > ${TARGET}/etc/yum.conf
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/yum
rm -rf ${TARGET}/var/lib/yum
tar -cJvf ./rootfs-${DIST}-${DVER}-${DATE}.tar.xz -C ${TARGET} .
