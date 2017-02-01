#!/usr/bin/env bash

set -e
set -u

DIST=squeeze
DATE=20140101
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=http://snapshot.debian.org/archive/debian/20140101T042327Z/

mkdir -p ${TARGET}
debootstrap --verbose --variant=minbase ${DIST} ${TARGET} ${MIRROR}
echo "${DIST}" > ${TARGET}/etc/hostname
rm -rf ${TARGET}/var/cache/apt/archives
rm -rf ${TARGET}/var/lib/apt/lists
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
