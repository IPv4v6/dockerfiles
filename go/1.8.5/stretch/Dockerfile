FROM ipv4v6/stretch
LABEL maintainer="Stefan <mail.ipv4v6+dckr@gmail.com>"

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	gcc \
	git \
	golang-1.7-go \
	libc6-dev \
	make \
	wget && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	wget https://storage.googleapis.com/golang/go1.8.5.src.tar.gz && \
	SHA256=4949fd1a5a4954eb54dd208f2f412e720e23f32c91203116bed0387cf5d0ff2d; \
	echo "${SHA256} go1.8.5.src.tar.gz" | sha256sum -c - && \
	tar -xzvf go1.8.5.src.tar.gz && \
	rm go1.8.5.src.tar.gz && \
	cd go/src && \
	GOROOT_BOOTSTRAP=/usr/lib/go-1.7 \
	GOROOT_FINAL=/usr/local \
	./make.bash && \
	cd / && \
	mv /go/bin /usr/local/ && \
	mv /go/pkg /usr/local/ && \
	mv /go/src /usr/local/ && \
	rm -rf /go && \
	apt-get purge -y \
	golang-1.7-go \
	golang-1.7-src

CMD ["/usr/local/bin/go"]
