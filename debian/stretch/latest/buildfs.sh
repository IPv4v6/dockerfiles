#!/usr/bin/env bash

set -e
set -u

DIST=stretch
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=http://archive.debian.org/debian/
SEC=http://archive.debian.org/debian-security/

rm -rf ${TARGET}
mkdir -p ${TARGET}
debootstrap --keyring=/usr/share/keyrings/debian-archive-removed-keys.pgp \
--include faketime --verbose --variant=minbase ${DIST} ${TARGET} ${MIRROR}
echo "${DIST}" > ${TARGET}/etc/hostname
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
echo "deb ${SEC} ${DIST}/updates main" >> ${TARGET}/etc/apt/sources.list
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/apt/archives
rm -rf ${TARGET}/var/lib/apt/lists
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
