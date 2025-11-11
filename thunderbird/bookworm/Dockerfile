FROM docker.io/ipv4v6/bookworm
LABEL maintainer="Stefan <mail.ipv4v6+dckr@gmail.com>"
ARG UID
ARG GID

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	locales thunderbird && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	sed -i 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
	sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	locale-gen && \
	groupadd -g ${GID} user && \
	useradd -u ${UID} -g ${GID} -m -s /bin/bash user

USER user
WORKDIR /home/user

ENTRYPOINT ["/usr/bin/thunderbird"]
