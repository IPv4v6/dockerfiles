FROM ipv4v6/buster
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	gcc \
	git \
	golang-1.11-go \
	libc6-dev \
	make \
	wget && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	wget https://dl.google.com/go/go1.14.11.src.tar.gz && \
	SHA256=1871f3d29b0cf1ebb739c9b134c9bc559282bd3625856e5f12f5aea29ab70f16; \
	echo "${SHA256} go1.14.11.src.tar.gz" | sha256sum -c - && \
	tar -xzvf go1.14.11.src.tar.gz && \
	rm go1.14.11.src.tar.gz && \
	cd go/src && \
	GOROOT_BOOTSTRAP=/usr/lib/go-1.11 \
	GOROOT_FINAL=/usr/local \
	./make.bash && \
	cd / && \
	mv /go/bin /usr/local/ && \
	mv /go/pkg /usr/local/ && \
	mv /go/src /usr/local/ && \
	rm -rf /go && \
	apt-get purge -y \
	golang-1.11-go \
	golang-1.11-src && \
	apt-get clean

CMD ["/usr/local/bin/go"]
