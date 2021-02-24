TAG = fedora-33:latest

all:	build tag

build:
	./buildfs.sh
	docker build -t ${TAG} .

tag:
	$(eval DATE = $(shell docker inspect ${TAG} | jq -r .[].Created |\
	cut -d ':' -f 1,2 | tr 'T' '_' | tr ':' '-'))
	docker tag ${TAG} ipv4v6/${TAG}
	docker tag ${TAG} ipv4v6/fedora-33:${DATE}
