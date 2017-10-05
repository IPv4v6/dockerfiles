#!/usr/bin/env bash

set -e
set -u

DIST=void
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DATE}
MIRROR=https://repo.voidlinux.eu/current
XBPS=~/bin/xbps-install.static
XBPS_SHA256=306e3d0e947dc2f8734dfec8ed8c182c03c3a618139d64f3a79c5d0945fd536b
XBPSARCHIVE=xbps-static-static-0.51_1.x86_64-musl.tar.xz
XBPSARCHIVE_URL=https://repo.voidlinux.eu/static/
XBPSARCHIVE_SHA256=60faac8079d7d941d25515bd1e3093fe7510f0aa70e917ae6fce8e6f05eb931b

rm -rf ${TARGET}
mkdir -p ${TARGET}
if [ ! -f ${XBPS} ] ;
then
	wget ${XBPSARCHIVE_URL}${XBPSARCHIVE}
	echo "${XBPSARCHIVE_SHA256}  ${XBPSARCHIVE}" | sha256sum -c -
	mkdir -p ~/bin
	tar -C ~/bin --strip-components=3 -xJf ${XBPSARCHIVE} ./usr/bin/xbps-install.static
	rm ${XBPSARCHIVE}
fi
echo "${XBPS_SHA256}  ${XBPS}" | sha256sum -c -
${XBPS} -S -R ${MIRROR} -r ${TARGET} base-files bash coreutils sed xbps
echo "${DIST}" > ${TARGET}/etc/hostname
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/xbps
rm -rf ${TARGET}/var/db/xbps/http*
tar -cJvf ./rootfs-${DIST}-${DATE}.tar.xz -C ${TARGET} .
