#!/usr/bin/env bash

set -e
set -u

DIST=fedora
DVER=37
DATE=latest
BUILDROOT=~/BUILDROOT
TARGET=${BUILDROOT}/${DIST}-${DVER}-${DATE}

rm -rf ${TARGET}
mkdir -p ${TARGET}/etc/yum.repos.d

cat << END > ${TARGET}/etc/yum.repos.d/fedora.repo
[fedora]
name=fedora
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-${DVER}&arch=x86_64
gpgkey=https://de.pgpkeys.eu/pks/lookup?op=get&search=0xacb5ee4e831c74bb7c168d27f55ad3fb5323552a
gpgcheck=1
END

cat << END > ${TARGET}/etc/yum.repos.d/fedora-updates.repo
[updates]
name=updates
metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f${DVER}&arch=x86_64
gpgkey=https://de.pgpkeys.eu/pks/lookup?op=get&search=0xacb5ee4e831c74bb7c168d27f55ad3fb5323552a
gpgcheck=1
END

echo "%_dbpath /var/lib/rpm" > ~/.rpmmacros
echo "%_db_backend sqlite" >> ~/.rpmmacros
dnf -y --installroot ${TARGET} --releasever ${DVER} --exclude "systemd" install bash.x86_64 coreutils dnf rpm glibc-minimal-langpack
echo "nameserver 8.8.8.8" > ${TARGET}/etc/resolv.conf
rm -rf ${TARGET}/dev/*
rm -rf ${TARGET}/var/cache/dnf
tar -cJvf ./rootfs-${DIST}-${DVER}-${DATE}.tar.xz -C ${TARGET} .
