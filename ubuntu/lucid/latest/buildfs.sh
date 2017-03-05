#!/usr/bin/env bash

set -e
set -u

DIST=lucid
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=http://old-releases.ubuntu.com/ubuntu/

rm -rf ${TARGET}
mkdir -p ${TARGET}
debootstrap --verbose --variant=minbase ${DIST} ${TARGET} ${MIRROR}
echo "${DIST}" > ${TARGET}/etc/hostname
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
echo "deb ${MIRROR} ${DIST}-updates main" >> ${TARGET}/etc/apt/sources.list
echo "deb ${MIRROR} ${DIST}-security main" >> ${TARGET}/etc/apt/sources.list
rm -rf ${TARGET}/dev/*
rm -f ${TARGET}/var/cache/apt/archives/*deb
rm -f ${TARGET}/var/lib/apt/lists/*ubuntu*
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
