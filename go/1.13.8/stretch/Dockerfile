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
	wget https://dl.google.com/go/go1.13.8.src.tar.gz && \
	SHA256=b13bf04633d4d8cf53226ebeaace8d4d2fd07ae6fa676d0844a688339debec34; \
	echo "${SHA256} go1.13.8.src.tar.gz" | sha256sum -c - && \
	tar -xzvf go1.13.8.src.tar.gz && \
	rm go1.13.8.src.tar.gz && \
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
