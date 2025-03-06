FROM ipv4v6/bookworm
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"
ARG GOFILE=go1.22.12.src.tar.gz
ARG GOFILE_SHA256=012a7e1f37f362c0918c1dfa3334458ac2da1628c4b9cf4d9ca02db986e17d71
ARG GOFILE_TEMP=go1.21.13.src.tar.gz
ARG GOFILE_TEMP_SHA256=71fb31606a1de48d129d591e8717a63e0c5565ffba09a24ea9f899a13214c34d

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	gcc \
	git \
	golang-1.19-go \
	libc6-dev \
	make \
	wget && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	wget https://dl.google.com/go/${GOFILE_TEMP} && \
	echo "${GOFILE_TEMP_SHA256} ${GOFILE_TEMP}" | sha256sum -c - && \
	mkdir GOTEMP && \
	cd GOTEMP && \
	tar -xzvf ../${GOFILE_TEMP} && \
	rm ../${GOFILE_TEMP} && \
	cd go/src && \
	GOROOT_BOOTSTRAP=/usr/lib/go-1.19 \
	./make.bash && \
	cd / && \
	wget https://dl.google.com/go/${GOFILE} && \
	echo "${GOFILE_SHA256} ${GOFILE}" | sha256sum -c - && \
	tar -xzvf ${GOFILE} && \
	rm ${GOFILE} && \
	cd go/src && \
	GOROOT_BOOTSTRAP=/GOTEMP/go \
	GOROOT_FINAL=/usr/local \
	./make.bash && \
	cd / && \
	mv /go/bin /usr/local/ && \
	mv /go/pkg /usr/local/ && \
	mv /go/src /usr/local/ && \
	rm -rf /GOTEMP && \
	rm -rf /go && \
	rm -rf /root/.cache/go-build/ && \
	apt-get purge -y \
	golang-1.19-go \
	golang-1.19-src && \
	apt-get clean

CMD ["/usr/local/bin/go"]
