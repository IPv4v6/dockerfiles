#!/usr/bin/env bash

set -e
set -u

DIST=almalinux
DVER=9
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DVER}-${DATE}

rm -rf ${TARGET}
mkdir -p ${TARGET}/etc/yum.repos.d

cat << END > ${TARGET}/etc/yum.repos.d/tempinstall.repo
[main]

[BaseOS]
name=AlmaLinux ${DVER} - BaseOS
mirrorlist=https://mirrors.almalinux.org/mirrorlist/${DVER}/baseos
gpgcheck=1
gpgkey=https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux-9
END

echo "%_dbpath /var/lib/rpm" > ~/.rpmmacros
dnf -y --installroot ${TARGET} --releasever ${DVER} --exclude "systemd" install bash.x86_64 coreutils.x86_64 dnf rpm.x86_64
echo "[main]" > ${TARGET}/etc/yum.conf
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
chroot ${TARGET} /usr/bin/rpmdb --rebuilddb
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/dnf
rm ${TARGET}/etc/yum.repos.d/tempinstall.repo
tar -cJvf ./rootfs-${DIST}-${DVER}-${DATE}.tar.xz -C ${TARGET} .
