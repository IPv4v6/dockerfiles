FROM ipv4v6/buster
LABEL maintainer "Stefan <mail.ipv4v6+dckr@gmail.com>"

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	thunderbird && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/* && \
	useradd -m -s /bin/bash user

USER user
WORKDIR /home/user

ENTRYPOINT ["/usr/bin/thunderbird"]
