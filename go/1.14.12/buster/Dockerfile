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
	wget https://dl.google.com/go/go1.14.12.src.tar.gz && \
	SHA256=b34f4b7ad799eab4c1a52bdef253602ce957125a512f5a1b28dce43c6841b971; \
	echo "${SHA256} go1.14.12.src.tar.gz" | sha256sum -c - && \
	tar -xzvf go1.14.12.src.tar.gz && \
	rm go1.14.12.src.tar.gz && \
	cd go/src && \
	GOROOT_BOOTSTRAP=/usr/lib/go-1.11 \
	GOROOT_FINAL=/usr/local \
	./make.bash && \
	cd / && \
	mv /go/bin /usr/local/ && \
	mv /go/pkg /usr/local/ && \
	mv /go/src /usr/local/ && \
	rm -rf /go && \
	rm -rf /root/.cache/go-build/ && \
	apt-get purge -y \
	golang-1.11-go \
	golang-1.11-src && \
	apt-get clean

CMD ["/usr/local/bin/go"]
