#!/usr/bin/env bash

set -e
set -u

DIST=alpine
DVER=3.11
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DVER}-${DATE}
MIRROR=http://dl-cdn.alpinelinux.org/alpine
PUBKEY_BASEURL=https://alpinelinux.org/keys/
PUBKEY_FILE="alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub"
APK=~/bin/apk.static
APK_SHA256=696076822ee89a54435787081a7411b44e33f61266c85ee44710533fa9f4d3c2
APKTOOL_BASEURL=${MIRROR}/v${DVER}/main/x86_64/
APKTOOL_FILE=apk-tools-static-2.10.4-r3.apk
APKTOOL_FILE_SHA256=cc18fcef55850ac3a8bfe84fcbf24c706807992c8ce8d9034f340e004f64bbfc

rm -rf ${TARGET}
mkdir -p ${TARGET}/etc/apk/keys
if [ ! -f ${APK} ] ;
then
	wget ${APKTOOL_BASEURL}${APKTOOL_FILE}
	echo "${APKTOOL_FILE_SHA256}  ${APKTOOL_FILE}" | sha256sum -c -
	mkdir -p ~/bin
	tar -C ~/bin --strip-components=1 -xzf ${APKTOOL_FILE} sbin/apk.static
	rm ${APKTOOL_FILE}
fi
echo "${APK_SHA256}  ${APK}" | sha256sum -c -
wget ${PUBKEY_BASEURL}${PUBKEY_FILE}
mv -i ${PUBKEY_FILE} ${TARGET}/etc/apk/keys/
${APK} -X ${MIRROR}/v${DVER}/main -U --root ${TARGET} --initdb add alpine-base
echo ${MIRROR}/v${DVER}/main > ${TARGET}/etc/apk/repositories
echo ${DIST} > ${TARGET}/etc/hostname
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/apk/*
tar -cJvf ./rootfs-${DIST}-${DVER}-${DATE}.tar.xz -C ${TARGET} .
