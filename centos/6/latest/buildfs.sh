#!/usr/bin/env bash

set -e
set -u

DIST=centos-6
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=http://mirror.centos.org/centos/6/os/x86_64/Packages/

rm -rf ${TARGET}
mkdir -p ${TARGET}
rinse --arch x86_64 --distribution ${DIST} --mirror ${MIRROR} --directory ${TARGET}
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
