FROM ipv4v6/stretch as builder
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	gcc \
	git \
	libc6-dev \
	libssl-dev \
	make && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	git clone https://github.com/magnumripper/JohnTheRipper && \
	cd JohnTheRipper/src && \
	./configure && \
	make


FROM ipv4v6/stretch
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	libgomp1 \
	libssl1.1 && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
COPY --from=builder /JohnTheRipper/run/ .

ENTRYPOINT ["/usr/local/bin/john"]
