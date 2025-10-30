NAME = onlyoffice-desktop-editors
VER = 9.0.4
DIST = bookworm
TAG = ${NAME}:${VER}-${DIST}
VOLDIR = ${HOME}/vol.onlyoffice
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
	--ipc host \
	${TAG}
