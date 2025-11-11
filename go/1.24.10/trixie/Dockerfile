FROM ipv4v6/trixie
LABEL maintainer="Stefan <mail.ipv4v6+dckr@gmail.com>"
ARG GOFILE=go1.24.10.src.tar.gz
ARG GOFILE_SHA256=34000dcc47a517b78fcf2657ee7d033328a57079fe60c4ed8b7b84260d1d19d3

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	gcc \
	git \
	golang-1.24-go \
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
	GOROOT_BOOTSTRAP=/usr/lib/go-1.24 \
	GOROOT_FINAL=/usr/local \
	./make.bash && \
	cd / && \
	mv /go/bin /usr/local/ && \
	mv /go/pkg /usr/local/ && \
	mv /go/src /usr/local/ && \
	mv /go/go.env /usr/local/ && \
	rm -rf /go && \
	rm -rf /root/.cache/go-build/ && \
	apt-get purge -y \
	golang-1.24-go \
	golang-1.24-src && \
	apt-get clean

CMD ["/usr/local/bin/go"]
