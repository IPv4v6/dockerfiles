NAME = thunderbird
DIST = bookworm
TAG = ${NAME}:${DIST}
VOLDIR = ${HOME}/vol.${NAME}
UID = $(shell id -u)
GID = $(shell id -g)
CMD = docker

build:
	${CMD} build -t ${TAG} --build-arg UID=${UID} --build-arg GID=${GID} .

run:
	mkdir -p ${VOLDIR}
	${CMD} run -it --rm --env DISPLAY=${DISPLAY} \
	--volume /etc/localtime:/etc/localtime:ro \
	--volume /tmp/.X11-unix:/tmp/.X11-unix \
	--volume ${VOLDIR}:/home/user \
	${TAG}
