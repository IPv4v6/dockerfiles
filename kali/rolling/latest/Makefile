DIST = kali-rolling
TAG = ${DIST}:latest
USER = ipv4v6

all:	build tag

build:
	./buildfs.sh
	docker build -t ${TAG} .

tag:
	$(eval DATE = $(shell docker inspect ${TAG} | jq -r .[].Created |\
	cut -d ':' -f 1,2 | tr 'T' '_' | tr ':' '-'))
	docker tag ${TAG} ${USER}/${TAG}
	docker tag ${TAG} ${USER}/${DIST}:${DATE}
