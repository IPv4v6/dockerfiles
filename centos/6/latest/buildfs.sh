#!/usr/bin/env bash

set -e
set -u

DIST=centos-6
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=http://vault.centos.org/6.10/os/x86_64/Packages/

rm -rf ${TARGET}
mkdir -p ${TARGET}
rinse --arch x86_64 --distribution ${DIST} --mirror ${MIRROR} --directory ${TARGET}
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm ${TARGET}/etc/yum.repos.d/*repo

cat << 'END' > ${TARGET}/etc/yum.repos.d/CentOS-6.10.repo

[base]
name=CentOS-6.10 - Base
baseurl=http://vault.centos.org/6.10/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

[updates]
name=CentOS-6.10 - Updates
baseurl=http://vault.centos.org/6.10/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
END

curl -o ${TARGET}/etc/pki/tls/certs/ca-bundle.crt https://curl.se/ca/cacert.pem
rm -rf ${TARGET}/dev/*
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
