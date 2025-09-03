FROM docker.io/ipv4v6/bookworm
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"
ARG UID
ARG GID
ARG FILE=onlyoffice-desktopeditors_amd64.deb
ARG FILE_VERSION=v9.0.4
ARG FILE_PATH=https://github.com/ONLYOFFICE/DesktopEditors/releases/download
ARG FILE_SHA256=c0ee2df6513b8079aee35fd0da5607559bbfa05c1a04b63606776899a15d621a

RUN set -eu && \
	sed -i 's/main/main contrib/' /etc/apt/sources.list && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	wget \
	desktop-file-utils \
	fonts-crosextra-carlito \
	fonts-dejavu \
	fonts-liberation \
	gsettings-desktop-schemas \
	gstreamer1.0-libav \
	gstreamer1.0-plugins-ugly \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libgbm1 \
	libgl1 \
	libgtk-3-0 \
	libice6 \
	libnss3 \
	libsm6 \
	libxkbcommon-x11-0 \
	libxss1 \
	ttf-mscorefonts-installer \
	x11-common \
	xdg-utils && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	groupadd -g ${GID} user && \
	useradd -u ${UID} -g ${GID} -m -s /bin/bash user && \
	wget ${FILE_PATH}/${FILE_VERSION}/${FILE} && \
	echo "${FILE_SHA256} ${FILE}" | sha256sum -c - && \
	dpkg -i ${FILE} && \
	rm ${FILE}

USER user
WORKDIR /home/user

ENTRYPOINT ["/usr/bin/onlyoffice-desktopeditors"]
