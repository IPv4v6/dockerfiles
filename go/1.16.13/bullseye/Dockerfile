FROM ipv4v6/bullseye
LABEL maintainer="Stefan <mail.ipv4v6+dckr@gmail.com>"
ARG GOFILE=go1.16.13.src.tar.gz
ARG GOFILE_SHA256=b0926654eaeb01ef43816638f42d7b1681f2d3f41b9559f07735522b7afad41a

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	gcc \
	git \
	golang-1.15-go \
	libc6-dev \
	make \
	wget && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	wget https://dl.google.com/go/${GOFILE} && \
	echo "${GOFILE_SHA256} ${GOFILE}" | sha256sum -c - && \
	tar -xzvf ${GOFILE} && \
	rm ${GOFILE} && \
	cd go/src && \
	GOROOT_BOOTSTRAP=/usr/lib/go-1.15 \
	GOROOT_FINAL=/usr/local \
	./make.bash && \
	cd / && \
	mv /go/bin /usr/local/ && \
	mv /go/pkg /usr/local/ && \
	mv /go/src /usr/local/ && \
	rm -rf /go && \
	rm -rf /root/.cache/go-build/ && \
	apt-get purge -y \
	golang-1.15-go \
	golang-1.15-src && \
	apt-get clean

CMD ["/usr/local/bin/go"]
