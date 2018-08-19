FROM ipv4v6/stretch
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"

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
	wget https://dl.google.com/go/go1.9.7.src.tar.gz && \
	SHA256=582814fa45e8ecb0859a208e517b48aa0ad951e3b36c7fff203d834e0ef27722; \
	echo "${SHA256} go1.9.7.src.tar.gz" | sha256sum -c - && \
	tar -xzvf go1.9.7.src.tar.gz && \
	rm go1.9.7.src.tar.gz && \
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
