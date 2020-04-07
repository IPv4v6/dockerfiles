FROM ipv4v6/buster as builder

RUN set -eu && \
	apt-get update && apt-get install --no-install-recommends -y \
	build-essential \
	ca-certificates \
	ccache \
	cmake \
	debhelper \
	dpkg-dev \
	gcc \
	g++ \
	git \
	gnupg \
	libqt5webkit5-dev \
	qt5-qmake \
	qtbase5-dev \
	zlib1g-dev && \
	git clone https://github.com/dvorka/mindforger && \
	cd mindforger && \
	git submodule init && \
	git submodule update && \
	mkdir deps/cmark-gfm/build && \
	cd deps/cmark-gfm/build && \
	cmake -DCMARK_TESTS=OFF -DCMARK_SHARED=OFF .. && \
	cmake --build . && \
	cd /mindforger/build/debian/ && \
	sed -i 's/\/home\/dvorka\/p\/mindforger\/git\/mindforger/\/mindforger/' debian-make-deb.sh && \
	sed -i '/dpkg-buildpackage -S/d' debian-make-deb.sh && \
	sed -i '/pushd .. && mkdir -v deb-source && cp -vf \*.dsc \*.changes \*.deb deb-source && popd/d' debian-make-deb.sh && \
	sed -i '/^export ARG_VERSION/i export GITREVISION=`git rev-parse HEAD | cut -c 1-10`' debian-make-deb.sh && \
	sed -i 's/${ARG_VERSION}/${ARG_VERSION}-${GITREVISION}/' debian-make-deb.sh && \
	./debian-make-deb.sh


FROM scratch
COPY --from=builder /mindforger/build/debian/mindforger-*/deb-binary/ /
