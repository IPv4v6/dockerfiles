#!/usr/bin/env bash

set -e
set -u

DIST=kali-rolling
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=http://http.kali.org/
PKG="kali-archive-keyring"

rm -rf ${TARGET}
mkdir -p ${TARGET}
debootstrap --verbose --variant=minbase --include=${PKG} ${DIST} ${TARGET} ${MIRROR}
echo "${DIST}" > ${TARGET}/etc/hostname
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/apt/archives
rm -rf ${TARGET}/var/lib/apt/lists
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
